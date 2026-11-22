# 安装 robot-rapid Skill / Install the robot-rapid Skill

这是唯一的 ABB 技能，叫 `robot-rapid`。Skill 文件在 `SKILL.md`，配合本仓库的 ABB 编程库使用（RAPID 例程、RobotStudio 教程、Python 联动、新手路线、0 到 1 全流程都在仓库里）。

## 这个技能有什么用

装上它，助手就按这套方法教你：写 RAPID 代码（10 个例程照着练）、从 0 到 1 建工作站（建站 → 加机器人 → 示教器 → 建模 → 组件 → 编程，6 段一步步点）、先在 RobotStudio 虚拟控制器里仿真跑通、Python 也能发指令控制机器人。你每次提问，助手都记下来、加深一点，库和技能一起长大。

## 新手安装：4 步

1. 一条命令装技能（跟别的 skill 一样，推荐）：`npx skills add linxie654-netizen/Robot-Skills`（需要 Node.js 22.20 以上；命令会找到仓库里的 `robot-rapid`，让你选装到哪个助手；2026-11-22 已实测，`--list` 能找到 1 个技能，`--skill robot-rapid -a claude-code -g -y` 能装到 `.claude/skills/robot-rapid/`）。装完直接跳到第 4 步。
2. 下载本仓库：`git clone https://github.com/linxie654-netizen/Robot-Skills.git`（没装 git 就在网页上点 `Code` → `Download ZIP`）。
3. 把 `skills/robot-rapid` 复制到你的 Skill 目录（下面按助手分开写）。
4. 问第一个问题，比如“我是新手，从哪开始学 ABB？”，助手就带你从 `rapid/01_move_basics.mod` 开始练。

### 插件市场安装（Claude Code）

仓库已按 Claude 插件市场规范布局（根目录 `.claude-plugin/plugin.json` + `skills/robot-rapid/SKILL.md`），在 Claude Code 里跑：

```
/plugin marketplace add linxie654-netizen/Robot-Skills
```

再装插件里的技能。市场那条路 2026-11-22 已按官方布局改好，待 Claude Code 里实测加载。

## 安装方法

### 方法 1：Muse（推荐）

```bash
git clone https://github.com/linxie654-netizen/Robot-Skills.git
cp -r Robot-Skills/skills/robot-rapid ~/workspace/custom-skills/robot-rapid
```

### 方法 2：Claude Code

```bash
git clone https://github.com/linxie654-netizen/Robot-Skills.git
cp -r Robot-Skills/skills/robot-rapid ~/.claude/skills/robot-rapid
```

### 方法 3：其他 AI 助手（Cursor、Codex、Windsurf、OpenClaw、Trae、Copilot 等）

支持所有 AI 模型 Agent：只要是支持 Agent Skills 标准的 AI 编程助手都能装。一条命令：`npx skills add linxie654-netizen/Robot-Skills --skill robot-rapid -a <助手名> -g -y`（把 `<助手名>` 换成 cursor、codex 这类）；或者把 `skills/robot-rapid/SKILL.md` 的全文发给你的 AI 助手，或把它存到你的助手支持的 Skill 目录，让助手按里面的方法工作。

## 需要什么

- 不需要装任何软件，只需要本仓库（RAPID 例程和教程都在里面）。
- 要在 RobotStudio 里跑仿真：装 RobotStudio（ABB 官网免费下载），见 `robotstudio/tutorial.md`。
- 写 RAPID 代码推荐装 ABB RAPID Pack（VS Code 扩展，Marketplace 里搜名字装，免费）：离线就能用，F12 跳定义、Shift+F12 找引用、F2 改名、报错提示。

## 版本

- Skill 与本仓库同步更新：每次提问都会记入 `learning-log.md`、加深一点；同步到 GitHub 前先问用户，同意了再同步。
- 本 Skill 不是 ABB 官方出品，是按官方语法和网上多家新手教程共识写的教学版，点位是教学值，在仿真里重新示教。

---

## Install (English)

The only ABB skill, named `robot-rapid`. Skill file: `SKILL.md` in this folder. It works together with the ABB programming library in this repository (RAPID examples, RobotStudio tutorial, Python integration, beginner roadmap, 0-to-1 pipeline).

### Muse (recommended)

```bash
git clone https://github.com/linxie654-netizen/Robot-Skills.git
cp -r Robot-Skills/skills/robot-rapid ~/workspace/custom-skills/robot-rapid
```

### Claude Code

```bash
git clone https://github.com/linxie654-netizen/Robot-Skills.git
cp -r Robot-Skills/skills/robot-rapid ~/.claude/skills/robot-rapid
```

### Other AI assistants (Cursor, Codex, Windsurf, OpenClaw, Trae, Copilot, etc.)

Supports all AI model agents: any AI coding assistant that supports the Agent Skills standard can use it. One command: `npx skills add linxie654-netizen/Robot-Skills --skill robot-rapid -a <agent> -g -y` (replace `<agent>` with cursor, codex, and so on); or send the full text of `skills/robot-rapid/SKILL.md` to your assistant, or save it in your assistant's skill directory.

### Check the install worked

1. Ask the assistant: “我是新手，从哪开始学 ABB？”
2. It should answer from `rapid/01_move_basics.mod` and offer the 15-lesson roadmap in `docs/beginner-roadmap.md`.
3. Ask it something that is already learned, for example: “RAPID 最像哪种语言？” — it should answer Pascal straight away, without searching again.
4. If it gives generic robot advice instead of RAPID code, the skill is not loaded: check the folder is in the right skills directory and the folder name is exactly `robot-rapid`.

### Requirements

- No extra software: the library is in this repository.
- To run simulations: install RobotStudio (free download from ABB), see `robotstudio/tutorial.md`.

### Version

- The skill is updated together with this repository: every question is recorded in `learning-log.md` and the skill deepens a little; sync to GitHub only after asking the user first.
- This skill is not an official ABB product. It is a teaching version written from official syntax and the consensus of several beginner tutorials. Positions are teaching values; reteach them in simulation.
