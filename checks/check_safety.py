#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""安全检查：扫每个项目 README。
1. 有没有“安全检查”一节；
2. 危险操作有没有“弹确认 / 先确认再动手”的提醒——安全检查一节里要有
   “确认”二字（例如“先手动低速跑一遍，确认……再切自动”）；
3. 全文不许出现真实设备相关字样（2026-11-22 用户纠正：技能只针对
   RobotStudio 仿真学习）——出现“真机/上真机”就失败；安全检查只查
   仿真项（轨迹、碰撞、速度、IO）。
用法：python3 checks/check_safety.py [--root DIR]
退出码：0=通过，1=有失败项。"""
import sys
from pathlib import Path

ROOT = Path(sys.argv[sys.argv.index("--root") + 1]) if "--root" in sys.argv else Path(__file__).resolve().parent.parent

failures = []


def safety_section(lines):
    start = end = None
    for i, ln in enumerate(lines):
        if "安全检查" in ln and ln.startswith("#"):
            start = i
        elif start is not None and ln.startswith("## "):
            end = i
            break
    return lines[start:end] if start is not None else []


def main():
    projects = sorted((ROOT / "projects").glob("*/README.md"))
    if not projects:
        print("FAIL: projects/ 下没找到项目 README")
        return 1
    for pr in projects:
        rel = str(pr.relative_to(ROOT)).replace("\\", "/")
        lines = pr.read_text(encoding="utf-8", errors="replace").splitlines()
        sec = safety_section(lines)
        if not sec:
            failures.append(f"{rel}: 缺“安全检查”一节")
            continue
        if not any("确认" in ln for ln in sec):
            failures.append(f"{rel}: 安全检查一节里没写“确认”提醒")
        for i, ln in enumerate(lines):
            if "真机" in ln:
                failures.append(f"{rel}:{i + 1}: 出现真实设备相关字样——{ln.strip()[:50]}")
        print(f"  {rel}: 安全检查 {len(sec)} 行，真实设备相关字样 {sum('真机' in ln for ln in lines)} 处" if not any(f.startswith(rel) for f in failures) else f"  {rel}: 有问题，见下")
    if failures:
        print(f"FAIL: {len(failures)} 项")
        for f in failures:
            print(f"  FAIL: {f}")
        return 1
    print("PASS: 安全检查通过")
    return 0


if __name__ == "__main__":
    sys.exit(main())
