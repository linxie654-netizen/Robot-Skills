#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""文档检查：扫仓库里所有 .md 文件。
查：README 标语“Robot-Skills，让 AI 更会写 RAPID。”在不在；
禁词（见下面 BANNED 表；2026-11-22 用户纠正后加了核实状态类标注词与真实设备相关词）；
每个项目 README 六节（①搭建步骤 ②IO 配置表 ③仿真方法 ④故障分析
⑤安全检查 ⑥怎么学这个项目）齐不齐；
没标“教学值”就下断言的地方（只列出来，不算失败）。
上传范围内的文件（projects/、本轮教学与 3D 文档、skills/robot-rapid、
以及下面 NEW_SCOPE 列出的已上传文件）禁词算失败；
只有本地-only 的 youtube-study/ 里的历史遗留禁词只列为“旧账”，
不算失败、不自动改（那是本地学习草稿，不进仓库）。
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
BANNED = ["python-expert", "破解", "30 天试用", "30天试用", "30 天免费", "30天免费",
          "未核实", "未核验", "未验证", "没有上机", "上真机", "真机",
          "没在 RobotStudio 跑过", "没在 RobotStudio 里跑过",
          "未在 RobotStudio 里跑过", "还没在 RobotStudio 里跑过",
          # 2026-11-22 Q96 用户定：仓库里不出现任何负面 / 没完成 / 不确定类提示
          "学不会", "没跑过", "没跑通", "没上机", "待核对", "待补", "待查",
          "查不到", "没查到", "没找到", "不确定", "推测", "纸面", "骨架", "短板",
          "做不了", "没做", "没学", "有争议", "出入", "拿不到", "被拦"]
# “上机”单独用正则：只禁“上机”本身，不误伤“装上机器人”“上机械臂”
REGEX_BANNED = [(r"上机(?![器械])", "上机")]
# 这三个词多半是技术描述（“这样写机器人不会动”），只在不属于下面技术句式时算失败。
# Q96 逐条人工看过，允许的句式都列在 SOFT_ALLOW 里；新增句子不在里面就会报出来，再人工判断。
SOFT_BANNED = ["不会", "不知道", "找不到"]
SOFT_ALLOW = re.compile(
    r"不会\s?(掉|倒|撞|跟|动|背|和|被|自己|手写|丢|断|无限|互相|半路|进广告|用|一碰)|会不会|啥都不会"
    r"|不知道\s?(哪|是哪|去哪|先动|该|PIN|自己|MoveJ|就别|回退)|就不知道|人就不知道|操作员就不知道"
    r"|找不到\s?(功能|信号|文件|单元|版本)|类型找不到|报找不到")
# “30 天”只禁试用相关写法（“30 天试用”）；“30 天内可恢复”说的是回收站保留期，不禁。
# 版本号单独用词界匹配：只禁“RobotStudio 6.08”“2024.1”这种钉死版本的写法，
# 项目名 abb-robotstudio-mcp6.08 是事实名称，不算。
VERSION_BANNED = [r"\b6\.08\b", r"\b2024\.1\b"]
# 注：RobotStudio 的三条只禁上面这四种原话写法。“没在 RobotStudio 虚拟控制
# 器里跑通就不算会”是仿真里先跑一遍的工作规则，不是核实状态标注，留着；
# 单一个“没跑过”也不在表里（同理）。
# 2026-11-22 Q96：整个公开仓库都算（含 learning-log.md），禁词算失败；
# 只有本地专用文件不进仓库，禁词只列为“旧账”。
LOCAL_ONLY = [
    "docs/youtube-study/",
    "docs/abb-rapid-pack-study.md",
    "docs/robomasters-study.md",
    "docs/palletizing-simulation.md",
    "rapid/11_palletizing.mod",
    "vendor/",
    "checks/",
    "skill/",
    "tools/",
]
SCAN_SUFFIXES = {".md", ".mod", ".html"}
SIX_SECTIONS = ["搭建步骤", "IO 配置表", "仿真方法", "故障分析", "安全检查", "怎么学这个项目"]
# 断言味的词：同一行没写“教学值”就列出来人工看
ASSERT_WORDS = ["一定", "必须", "都能", "肯定", "没问题", "直接用", "照抄"]

failures, legacy, asserts = [], [], []


def is_new(path: Path) -> bool:
    rel = str(path.relative_to(ROOT)).replace("\\", "/")
    return not any(rel.startswith(p) or rel == p.rstrip("/") for p in LOCAL_ONLY)


def main():
    readme = ROOT / "README.md"
    text = readme.read_text(encoding="utf-8", errors="replace")
    if SLOGAN not in text:
        failures.append(f"README.md: 标语缺失：{SLOGAN}")
    else:
        print(f"标语在：README.md")

    mds = sorted(p for p in ROOT.rglob("*") if p.is_file() and p.suffix in SCAN_SUFFIXES
                 and ".git" not in p.parts and ".bak" not in p.name and "q92bak" not in p.name)
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
            for pat, name in REGEX_BANNED:
                if re.search(pat, ln):
                    item = f"{rel}:{i}: 禁词“{name}”"
                    (failures if is_new(path) else legacy).append(item)
            for word in SOFT_BANNED:
                if word in ln and not SOFT_ALLOW.search(ln):
                    item = f"{rel}:{i}: 禁词“{word}”——{ln.strip()[:40]}"
                    (failures if is_new(path) else legacy).append(item)
            for pat in VERSION_BANNED:
                if re.search(pat, ln):
                    item = f"{rel}:{i}: 禁词“钉死版本号”"
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

    print(f"扫了 {checked} 个 .md/.mod/.html，{len(projects)} 个项目 README")
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
