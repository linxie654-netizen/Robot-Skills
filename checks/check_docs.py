#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""文档检查：扫仓库里所有 .md 文件。
查：README 标语“Robot-Skills，让 AI 更会写 RAPID。”在不在；
禁词（见下面 BANNED 表；2026-11-22 用户纠正后加了核实状态类标注词与真实设备相关词）；
每个项目 README 六节（①搭建步骤 ②IO 配置表 ③仿真方法 ④故障分析
⑤安全检查 ⑥怎么学这个项目）齐不齐；
没标“教学值”就下断言的地方（只列出来，不算失败）。
上传范围内的文件（projects/、本轮教学与 3D 文档、skill/robot-rapid、
以及下面 NEW_SCOPE 列出的已上传文件）禁词算失败；
旧文件里的历史遗留禁词只列为“旧账”，不算失败、不自动改。
用法：python3 checks/check_docs.py [--root DIR]
退出码：0=通过，1=有失败项。"""
import re
import sys
from pathlib import Path

ROOT = Path(sys.argv[sys.argv.index("--root") + 1]) if "--root" in sys.argv else Path(__file__).resolve().parent.parent

SLOGAN = "Robot-Skills，让 AI 更会写 RAPID。"
# 禁词：2026-11-22 用户纠正后加进核实状态类标注词与真实设备相关词。
# 注意：本列表自身含这些词是设计使然——check_docs.py 只扫 .md，不扫 .py，
# 所以列表本身不会被自己查到；checks/README.md 里也别把禁词逐字写出来。
BANNED = ["python-expert", "破解", "30 天", "30天", "6.08", "2024.1",
          "未核实", "未核验", "未验证", "没有上机", "上真机", "真机",
          "没在 RobotStudio 跑过", "没在 RobotStudio 里跑过",
          "未在 RobotStudio 里跑过", "还没在 RobotStudio 里跑过"]
# 注：RobotStudio 的三条只禁上面这四种原话写法。“没在 RobotStudio 虚拟控制
# 器里跑通就不算会”是仿真里先跑一遍的工作规则，不是核实状态标注，留着；
# 单一个“没跑过”也不在表里（同理）。
# 上传范围内的内容（禁词算失败）：本轮新增 + 下面列出的已上传文件。
# 不在里面的（learning-log.md、youtube-study/、旧草稿、CHANGELOG.md 旧节、
# comparison.md 旧节、check-report.md）只列为“旧账”，不算失败、不自动改。
NEW_SCOPE = [
    "projects/",
    "docs/teaching-guide.md",
    "docs/exam-practice.md",
    "docs/progress-tracker.md",
    "docs/3d-simulation-research.md",
    "docs/threejs-arm-demo.html",
    "skill/robot-rapid/",
    "python/",
    "docs/advanced-topics.md",
    "docs/evals.md",
    "docs/beginner-roadmap.md",
    "SECURITY.md",
    "INSTALL.md",
    "python/README.md",
    "README.md",
    "README_EN.md",
    "docs/full-pipeline.md",
    "checks/",
]
SIX_SECTIONS = ["搭建步骤", "IO 配置表", "仿真方法", "故障分析", "安全检查", "怎么学这个项目"]
# 断言味的词：同一行没写“教学值”就列出来人工看
ASSERT_WORDS = ["一定", "必须", "都能", "肯定", "没问题", "直接用", "照抄"]

failures, legacy, asserts = [], [], []


def is_new(path: Path) -> bool:
    rel = str(path.relative_to(ROOT)).replace("\\", "/")
    return any(rel.startswith(p) or rel == p.rstrip("/") for p in NEW_SCOPE)


def main():
    readme = ROOT / "README.md"
    text = readme.read_text(encoding="utf-8", errors="replace")
    if SLOGAN not in text:
        failures.append(f"README.md: 标语缺失：{SLOGAN}")
    else:
        print(f"标语在：README.md")

    mds = sorted(p for p in ROOT.rglob("*.md") if ".git" not in p.parts)
    checked = 0
    for path in mds:
        lines = path.read_text(encoding="utf-8", errors="replace").splitlines()
        rel = str(path.relative_to(ROOT)).replace("\\", "/")
        checked += 1
        for i, ln in enumerate(lines, 1):
            for word in BANNED:
                if word in ln:
                    item = f"{rel}:{i}: 禁词“{word}”"
                    (failures if is_new(path) else legacy).append(item)
            for word in ASSERT_WORDS:
                if word in ln and "教学值" not in ln:
                    asserts.append(f"{rel}:{i}: “{word}”——{ln.strip()[:60]}")

    projects = sorted((ROOT / "projects").glob("*/README.md"))
    for pr in projects:
        text = pr.read_text(encoding="utf-8", errors="replace")
        rel = str(pr.relative_to(ROOT)).replace("\\", "/")
        for sec in SIX_SECTIONS:
            if sec not in text:
                failures.append(f"{rel}: 缺“{sec}”一节")

    print(f"扫了 {checked} 个 .md，{len(projects)} 个项目 README")
    if legacy:
        print(f"旧账（历史文件里的禁词，不算本轮失败，共 {len(legacy)} 处）：")
        for item in legacy[:20]:
            print(f"  LEGACY: {item}")
        if len(legacy) > 20:
            print(f"  LEGACY: ……还有 {len(legacy) - 20} 处，见上")
    if asserts:
        print(f"未标“教学值”的断言味表述（共 {len(asserts)} 处，人工复核）：")
        for item in asserts[:20]:
            print(f"  ASSERT: {item}")
        if len(asserts) > 20:
            print(f"  ASSERT: ……还有 {len(asserts) - 20} 处")
    if failures:
        print(f"FAIL: {len(failures)} 项")
        for f in failures:
            print(f"  FAIL: {f}")
        return 1
    print("PASS: 文档检查通过")
    return 0


if __name__ == "__main__":
    sys.exit(main())
