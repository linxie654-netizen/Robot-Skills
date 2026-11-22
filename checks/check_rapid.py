#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""代码检查：扫仓库里所有 .mod 文件。
查：PROC/ENDPROC、FUNC/ENDFUNC、TRAP/ENDTRAP、MODULE/ENDMODULE 配对；
必填段 tooldata / wobjdata 有没有出现；禁词（见下面 BANNED 表；
2026-11-22 用户纠正后加了核实状态类标注词与真实设备相关词，
新加的词注释里也要查——.mod 里的文字说明都在注释里）。
用法：python3 checks/check_rapid.py [--root DIR]
退出码：0=通过，1=有失败项。"""
import re
import sys
from pathlib import Path

ROOT = Path(sys.argv[sys.argv.index("--root") + 1]) if "--root" in sys.argv else Path(__file__).resolve().parent.parent

PAIRS = [
    (r"^\s*PROC\b", r"^\s*ENDPROC\b", "PROC/ENDPROC"),
    (r"^\s*FUNC\b", r"^\s*ENDFUNC\b", "FUNC/ENDFUNC"),
    (r"^\s*TRAP\b", r"^\s*ENDTRAP\b", "TRAP/ENDTRAP"),
    (r"^\s*MODULE\b", r"^\s*ENDMODULE\b", "MODULE/ENDMODULE"),
]
BANNED = ["python-expert", "破解", "30 天", "30天", "6.08", "2024.1", "试用",
          "未核实", "未核验", "未验证", "没有上机", "上真机", "真机",
          "没在 RobotStudio 跑过", "没在 RobotStudio 里跑过",
          "未在 RobotStudio 里跑过", "还没在 RobotStudio 里跑过"]
# 新加的词：注释行也要查（.mod 里的文字说明都在注释里）。
# 旧的 7 个词只查非注释行（沿用原来的做法）。
# 注：RobotStudio 的三条只禁上面这四种原话写法；单一个“没跑过”不在表里——
# “没跑过就不算会”是仿真里先跑一遍的工作规则，不是核实状态标注，留着。
NEW_WORDS = {"未核实", "未核验", "未验证", "没有上机", "上真机", "真机",
             "没在 RobotStudio 跑过", "没在 RobotStudio 里跑过",
             "未在 RobotStudio 里跑过", "还没在 RobotStudio 里跑过"}

failures, warnings = [], []


def check_file(path: Path):
    lines = path.read_text(encoding="utf-8", errors="replace").splitlines()
    rel = path.relative_to(ROOT)
    for open_re, close_re, name in PAIRS:
        n_open = sum(1 for ln in lines if re.search(open_re, ln) and not ln.strip().startswith("!"))
        n_close = sum(1 for ln in lines if re.search(close_re, ln) and not ln.strip().startswith("!"))
        if n_open != n_close:
            failures.append(f"{rel}: {name} 配不上（开 {n_open} / 合 {n_close}）")
    text = "\n".join(lines)
    # tooldata / wobjdata 只对本轮新建的项目 .mod 强制要求：
    # 老例程 rapid/ 用系统默认 tool0 / wobj0，不写声明是正常的，只记 WARN。
    if "projects" in path.parts:
        if "tooldata" not in text:
            failures.append(f"{rel}: 缺 tooldata（必填段）")
        if "wobjdata" not in text:
            failures.append(f"{rel}: 缺 wobjdata（必填段）")
    else:
        if "tooldata" not in text or "wobjdata" not in text:
            warnings.append(f"{rel}: 没写 tooldata/wobjdata 声明，用的是系统默认 tool0/wobj0")
    for word in BANNED:
        for i, ln in enumerate(lines, 1):
            is_comment = ln.strip().startswith("!")
            if word in ln and (word in NEW_WORDS or not is_comment):
                failures.append(f"{rel}:{i}: 禁词“{word}”")
    # 注释里写“教学值”是好习惯：没标的数值型断言只记一条提醒
    if "教学值" not in text:
        warnings.append(f"{rel}: 全文没写“教学值”，点位若是教学值请标注")


def main():
    mods = sorted(ROOT.rglob("*.mod"))
    # vendor/ 是第三方源码，不归本库检查
    mods = [m for m in mods if "vendor" not in m.parts]
    if not mods:
        print("FAIL: 一个 .mod 都没找到")
        return 1
    for m in mods:
        check_file(m)
    print(f"扫了 {len(mods)} 个 .mod 文件")
    for w in warnings:
        print(f"  WARN: {w}")
    if failures:
        print(f"FAIL: {len(failures)} 项")
        for f in failures:
            print(f"  FAIL: {f}")
        return 1
    print("PASS: 代码检查通过")
    return 0


if __name__ == "__main__":
    sys.exit(main())
