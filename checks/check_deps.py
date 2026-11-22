#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""依赖检查：三样对得上才算过。
1. python/requirements.txt 里的包名和版本（没钉版本只记 WARN）；
   abb-motion-program-exec 要能在 vendor/ 里找到本地包。
2. Node 版本要求：README 里写的“Node.js 22.20 以上”，对本地 node --version。
3. 技能安装命令：README 里写的命令要和约定的命令一致：
   npx skills add linxie654-netizen/Robot-Skills。
用法：python3 checks/check_deps.py [--root DIR]
退出码：0=通过，1=有失败项。"""
import re
import shutil
import subprocess
import sys
from pathlib import Path

ROOT = Path(sys.argv[sys.argv.index("--root") + 1]) if "--root" in sys.argv else Path(__file__).resolve().parent.parent
EXPECTED_INSTALL = "npx skills add linxie654-netizen/Robot-Skills"

failures, warnings = [], []


def parse_version_req(text: str):
    """从 README 里抠 'Node.js 22.20 以上' 这类要求，返回 (22, 20) 或 None。"""
    m = re.search(r"Node\.js\s+(\d+)\.(\d+)", text)
    return (int(m.group(1)), int(m.group(2))) if m else None


def main():
    # 1. requirements.txt
    req = ROOT / "python" / "requirements.txt"
    if not req.exists():
        failures.append("python/requirements.txt 不存在")
    else:
        for ln in req.read_text(encoding="utf-8").splitlines():
            ln = ln.strip()
            if not ln or ln.startswith("#"):
                continue
            m = re.match(r"^([A-Za-z0-9_.-]+)\s*(.*)$", ln)
            pkg, ver = m.group(1), m.group(2)
            if not ver:
                warnings.append(f"requirements.txt: {pkg} 没钉版本")
            else:
                print(f"  依赖：{pkg} {ver}")
            if pkg == "abb-motion-program-exec":
                if not (ROOT / "vendor" / "abb_motion_program_exec").exists():
                    failures.append("abb-motion-program-exec 在 vendor/ 里找不到本地包")

    # 2. Node 版本要求
    readme = (ROOT / "README.md").read_text(encoding="utf-8", errors="replace")
    req_ver = parse_version_req(readme)
    if not req_ver:
        failures.append("README.md 里没写 Node 版本要求")
    else:
        print(f"  README 要求 Node.js {req_ver[0]}.{req_ver[1]} 以上")
    node = shutil.which("node")
    if not node:
        failures.append("本机没装 node，装不了技能也验不了版本")
    else:
        out = subprocess.run(["node", "--version"], capture_output=True, text=True)
        m = re.match(r"v(\d+)\.(\d+)", out.stdout.strip())
        local = (int(m.group(1)), int(m.group(2))) if m else None
        print(f"  本机 node {out.stdout.strip()}")
        if local and req_ver and local < req_ver:
            failures.append(f"本机 node {local} 低于 README 要求的 {req_ver}")

    # 3. 安装命令
    if EXPECTED_INSTALL in readme:
        print(f"  安装命令对得上：{EXPECTED_INSTALL}")
    else:
        failures.append(f"README.md 里找不到安装命令：{EXPECTED_INSTALL}")

    for w in warnings:
        print(f"  WARN: {w}")
    if failures:
        print(f"FAIL: {len(failures)} 项")
        for f in failures:
            print(f"  FAIL: {f}")
        return 1
    print("PASS: 依赖检查通过")
    return 0


if __name__ == "__main__":
    sys.exit(main())
