# 安装 python-expert Skill / Install the python-expert Skill

Python 编程技能，叫 `python-expert`。Skill 文件在 `SKILL.md`，配合本仓库的 Python 联动例程使用（`python/` 里的 01、02 例程，ABB 联动库在 `vendor/abb_motion_program_exec/`）。

## 这个技能有什么用

装上它，助手就按这套方法教你：写 Python 代码（给完整能跑的代码，重要代码逐段讲）、调 bug（报错先看最后一行）、做自动化脚本（先手工走一遍再写成脚本）、做 GUI（先从 Python 自带的 tkinter 入手）、做小工具（一个 `.py` 文件，命令行能跑）、用 Python 控制 ABB 机器人（先打印 RAPID 检查再执行）。你每次提问，助手都记下来、加深一点，库和技能一起长大。

## 新手安装：3 步

0. 一条命令装技能（跟别的 skill 一样，推荐）：`npx skills add linxie654-netizen/Robot-Skills --skill python-expert`（需要 Node.js 22.20 以上；命令会找到仓库里的 `python-expert`，让你选装到哪个助手）。装完直接跳到第 3 步。
1. 下载本仓库：`git clone https://github.com/linxie654-netizen/Robot-Skills.git`（没装 git 就在网页上点 `Code` → `Download ZIP`）。
2. 把 `skill/python-expert` 复制到你的 Skill 目录（下面按助手分开写）。
3. 问第一个问题，比如“帮我写个批量重命名的脚本”，助手就按这个技能的方法带你写。

## 安装方法

### 方法 1：Muse（推荐）

```bash
git clone https://github.com/linxie654-netizen/Robot-Skills.git
cp -r Robot-Skills/skill/python-expert ~/workspace/custom-skills/python-expert
```

### 方法 2：Claude Code

```bash
git clone https://github.com/linxie654-netizen/Robot-Skills.git
cp -r Robot-Skills/skill/python-expert ~/.claude/skills/python-expert
```

### 方法 3：其他 AI 助手

把 `skill/python-expert/SKILL.md` 的全文发给你的 AI 助手，或把它存到你的助手支持的 Skill 目录，让助手按里面的方法工作。

## 需要什么

- Python 3（用你电脑上已有的就行，不另外指定版本）。
- 第三方库按需装：ABB 联动要装 `abb-motion-program-exec`，见 `python/requirements.txt`（`pip install -r python/requirements.txt`）。
- 要用 Python 控制机器人跑仿真：装 RobotStudio（ABB 官网免费下载），见 `robotstudio/tutorial.md`。

## 版本

- Skill 与本仓库同步更新：每次提问都会记入 `learning-log.md`、加深一点；同步到 GitHub 前先问用户，同意了再同步。
- 本 Skill 是教学版：给初学者的大白话教学，代码是能跑的完整例子，不懂的先查再写，不编不存在的库和函数。

---

## Install (English)

Python programming skill, named `python-expert`. Skill file: `SKILL.md` in this folder. It works together with the Python examples in this repository (`python/01_move_joints.py`, `python/02_pick_place.py`, ABB library in `vendor/abb_motion_program_exec/`).

### Muse (recommended)

```bash
git clone https://github.com/linxie654-netizen/Robot-Skills.git
cp -r Robot-Skills/skill/python-expert ~/workspace/custom-skills/python-expert
```

### Claude Code

```bash
git clone https://github.com/linxie654-netizen/Robot-Skills.git
cp -r Robot-Skills/skill/python-expert ~/.claude/skills/python-expert
```

### Other AI assistants

Send the full text of `skill/python-expert/SKILL.md` to your assistant, or save it in your assistant's skill directory.

### Check the install worked

1. Ask the assistant: “帮我写个批量重命名的脚本。”
2. It should give complete runnable code with a short explanation for each important part, in Chinese and in plain language.
3. Ask it something already learned, for example: “ABB 联动之前要先干什么？” — it should answer: print the generated RAPID and check it first, without searching again.
4. If it gives only theory without code, the skill is not loaded: check the folder is in the right skills directory and the folder name is exactly `python-expert`.

### Requirements

- Python 3 (use the one already on your computer).
- Third-party libraries as needed: `abb-motion-program-exec` for ABB control, see `python/requirements.txt`.
- To run robot simulations: install RobotStudio (free download from ABB), see `robotstudio/tutorial.md`.

### Version

- The skill is updated together with this repository: every question is recorded in `learning-log.md` and the skill deepens a little; sync to GitHub only after asking the user first.
- This skill is a teaching version for beginners: plain-language lessons with complete runnable examples. Unknown libraries and functions are checked first, never invented.
