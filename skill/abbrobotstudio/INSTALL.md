# 安装 abbrobotstudio Skill / Install the abbrobotstudio Skill

这是唯一的 ABB 技能，叫 `abbrobotstudio`。Skill 文件在 `SKILL.md`，配合本仓库的 ABB 编程库使用（RAPID 例程、RobotStudio 教程、Python 联动、新手路线、0 到 1 全流程都在仓库里）。`scripts/` 是 Windows 上操作 RobotStudio 桥的脚本，`references/recipes.md` 是 C# 片段。

## 这个技能有什么用

装上它，助手就按这套方法教你：写 RAPID 代码（10 个例程照着练）、从 0 到 1 建工作站（建站 → 加机器人 → 示教器 → 建模 → 组件 → 编程，6 段一步步点）、先在 RobotStudio 虚拟控制器里仿真跑通再上真机、Python 也能发指令控制机器人。你每次提问，助手都记下来、加深一点，库和技能一起长大。

## 新手安装：3 步

1. 下载本仓库：`git clone https://github.com/linxie654-netizen/abb-robot-programming.git`（没装 git 就在网页上点 `Code` → `Download ZIP`）。
2. 把 `skill/abbrobotstudio` 复制到你的 Skill 目录（下面按助手分开写）。
3. 问第一个问题，比如“我是新手，从哪开始学 ABB？”，助手就带你从 `rapid/01_move_basics.mod` 开始练。

## 安装方法

### 方法 1：Muse（推荐）

```bash
git clone https://github.com/linxie654-netizen/abb-robot-programming.git
cp -r abb-robot-programming/skill/abbrobotstudio ~/workspace/custom-skills/abbrobotstudio
```

### 方法 2：Claude Code

```bash
git clone https://github.com/linxie654-netizen/abb-robot-programming.git
cp -r abb-robot-programming/skill/abbrobotstudio ~/.claude/skills/abbrobotstudio
```

### 方法 3：其他 AI 助手

把 `skill/abbrobotstudio/SKILL.md` 的全文发给你的 AI 助手，或把它存到你的助手支持的 Skill 目录，让助手按里面的方法工作。

## 需要什么

- 不需要装任何软件，只需要本仓库（RAPID 例程和教程都在里面）。
- 要在 RobotStudio 里跑仿真：装 RobotStudio（ABB 官网免费下载），见 `robotstudio/tutorial.md`。
- 要在 Windows 电脑上用 HTTP 桥操作 RobotStudio：需要 ClaudeBridge 插件，见 `docs/bridge-merged-v1.md`（RobotStudio 6.08，只在虚拟控制器上操作）。

## 版本

- Skill 与本仓库同步更新：每次提问都会记入 `learning-log.md`、加深一点、同步到 GitHub。
- 本 Skill 不是 ABB 官方出品，是按官方语法和网上多家新手教程共识写的教学版，点位是教学值，真机要重新示教。

---

## Install (English)

The only ABB skill, named `abbrobotstudio`. Skill file: `SKILL.md` in this folder. It works together with the ABB programming library in this repository (RAPID examples, RobotStudio tutorial, Python integration, beginner roadmap, 0-to-1 pipeline). `scripts/` holds the Windows scripts for operating RobotStudio through the bridge; `references/recipes.md` holds C# snippets.

### Muse (recommended)

```bash
git clone https://github.com/linxie654-netizen/abb-robot-programming.git
cp -r abb-robot-programming/skill/abbrobotstudio ~/workspace/custom-skills/abbrobotstudio
```

### Claude Code

```bash
git clone https://github.com/linxie654-netizen/abb-robot-programming.git
cp -r abb-robot-programming/skill/abbrobotstudio ~/.claude/skills/abbrobotstudio
```

### Other AI assistants

Send the full text of `skill/abbrobotstudio/SKILL.md` to your assistant, or save it in your assistant's skill directory.

### Requirements

- No extra software: the library is in this repository.
- To run simulations: install RobotStudio (free download from ABB), see `robotstudio/tutorial.md`.
- To operate RobotStudio through the HTTP bridge on Windows: the ClaudeBridge add-in is needed, see `docs/bridge-merged-v1.md` (RobotStudio 6.08, virtual controller only).

### Version

- The skill is updated together with this repository: every question is recorded in `learning-log.md`, the skill deepens a little, and the library is synced to GitHub.
- This skill is not an official ABB product. It is a teaching version written from official syntax and the consensus of several beginner tutorials. Positions are teaching values; reteach them before running on real hardware.
