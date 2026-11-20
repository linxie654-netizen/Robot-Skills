# 安装 ABB 编程 Skill / Install the ABB Programming Skill

Skill 文件：`SKILL.md`（本目录）。这个 Skill 配合本仓库的 ABB 编程库使用（RAPID 例程、RobotStudio 教程、Python 联动、新手路线都在仓库里）。

## 安装方法

### 方法 1：Muse（推荐）

1. 克隆本仓库：
   ```bash
   git clone https://github.com/linxie654-netizen/abb-robot-programming.git
   ```
2. 把 `skill/` 整个目录复制到你的自定义 Skill 目录：
   ```bash
   cp -r abb-robot-programming/skill ~/workspace/custom-skills/abb_robot_programming
   ```
3. 在 Muse 里问 ABB 问题时，助手会按这个 Skill 的方法查库、给代码、做对比。

### 方法 2：Claude Code

```bash
git clone https://github.com/linxie654-netizen/abb-robot-programming.git
cp -r abb-robot-programming/skill ~/.claude/skills/abb-robot-programming
```

### 方法 3：其他 AI 助手

把 `skill/SKILL.md` 的全文发给你的 AI 助手，或把它存到你的助手支持的 Skill 目录，让助手按里面的方法工作。

## 需要什么

- 不需要装任何软件，只需要本仓库（RAPID 例程和教程都在里面）。
- 要在 RobotStudio 里跑仿真：装 RobotStudio（ABB 官网免费下载），见 `robotstudio/tutorial.md`。
- 要用 AI 直接操作 RobotStudio：需要 MCP 服务器 + 插件，见 `docs/mcp-install-6.08.md`（RobotStudio 6.08，Windows）。

## 版本

- Skill 与本仓库同步更新：每次提问都会记入 `learning-log.md`、加深一点、同步到 GitHub。
- 本 Skill 不是 ABB 官方出品，是按官方语法和网上多家新手教程共识写的教学版，点位是教学值，真机要重新示教。

---

## Install (English)

Skill file: `SKILL.md` in this folder. It works together with the ABB programming library in this repository (RAPID examples, RobotStudio tutorial, Python integration, beginner roadmap).

### Muse (recommended)

```bash
git clone https://github.com/linxie654-netizen/abb-robot-programming.git
cp -r abb-robot-programming/skill ~/workspace/custom-skills/abb_robot_programming
```

### Claude Code

```bash
git clone https://github.com/linxie654-netizen/abb-robot-programming.git
cp -r abb-robot-programming/skill ~/.claude/skills/abb-robot-programming
```

### Other AI assistants

Send the full text of `skill/SKILL.md` to your assistant, or save it in your assistant's skill directory.

### Requirements

- No extra software: the library is in this repository.
- To run simulations: install RobotStudio (free download from ABB), see `robotstudio/tutorial.md`.
- To let an AI operate RobotStudio: install the MCP server + add-in, see `docs/mcp-install-6.08.md` (RobotStudio 6.08, Windows).

### Version

- The skill is updated together with this repository: every question is recorded in `learning-log.md`, the skill deepens a little, and the library is synced to GitHub.
- This skill is not an official ABB product. It is a teaching version written from official syntax and the consensus of several beginner tutorials. Positions are teaching values; reteach them before running on real hardware.
