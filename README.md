<div align="center">

# 🤖 ABB 机器人编程学习库

<img src="assets/cover.png" alt="ABB 工业机器人" width="720">

**写对 RAPID 代码，在 RobotStudio 里仿真跑通，再上真机。**

![RAPID](https://img.shields.io/badge/RAPID-10%E4%BE%8B%E7%A8%8B-blue)
![RobotStudio](https://img.shields.io/badge/RobotStudio-6.08-green)
![Skill](https://img.shields.io/badge/Skill-Robot--RAPID-orange)
![Language](https://img.shields.io/badge/%E8%AF%AD%E8%A8%80-%E4%B8%AD%E6%96%87-red)

[🚀 30 秒上手](#-新手安装3-步) · [📖 新手路线](docs/beginner-roadmap.md) · [⚡ 速查表](docs/cheatsheet.md) · [🔍 对比学习](docs/comparison.md)

</div>

| 写代码 | 仿真 | Smart 组件 | 边学边长大 |
|---|---|---|---|
| RAPID 又对又快，10 个例程照着练 | 虚拟控制器先跑通、查碰撞，再上真机 | 从 0 到 1 建站 6 段，建模、组件都包了 | 每次提问都记下来，技能越问越全 |

中文，拆步骤，给完整能跑的代码，重要代码逐段讲。目标：Python + PLC + ABB 机器人联动，做工业自动化。

**版本钉死（2026-11-20 核实）**：RobotStudio 6.08、RobotWare 6、IRC5 控制器、RAPID 例程按官方语法重写。

## 🗺️ 能力地图：要干什么，找什么

| 你要干什么 | 打开什么 | 得到什么 |
|---|---|---|
| 写一段 RAPID 代码 | `skill/robot-rapid/references/rapid-patterns.md` + `rapid/` | 9 种常用模式，照着抄，改点位就能跑 |
| 程序报错、跑不通 | `skill/robot-rapid/references/troubleshooting.md` | 报错对号表，先定位再动手 |
| 搭 Smart 组件 | `skill/robot-rapid/references/smart-components.md` | 一步步搭，信号、逻辑、动作都写清了 |
| 跑仿真、上真机前检查 | `skill/robot-rapid/references/simulation-checklist.md` | 逐项打勾，没打完不上真机 |
| 从 0 到 1 建工作站 | `docs/full-pipeline.md` | 6 段全流程，照着点 |
| 新手从哪开始 | `docs/beginner-roadmap.md` | 12 课路线 + 6 个常犯错 |
| Python 控制机器人 | `python/01_move_joints.py` | 先打印 RAPID 检查再执行 |
| 以前问过的问题 | `skill/robot-rapid/references/learned.md` | 问题 → 答案 → 为什么，现成的 |

---

## ✨ 这个技能有什么用

就一个技能，叫 **Robot-RAPID**（文件夹名 `robot-rapid`），装上它，助手就按这套方法教你：

1. **教你写 RAPID 代码**：MoveJ / MoveL / MoveAbsJ、IO、循环、坐标系、圆弧、报错处理，10 个例程照着练，不用每次从零找资料。
2. **带你从 0 到 1 建工作站**：建站 → 加机器人 → 示教器教点 → 建模 → Smart 组件 → 编程，6 段一步步点，卡住了截图或贴报错，助手帮你改。
3. **先仿真，再真机**：所有程序先在 RobotStudio 虚拟控制器里跑通、查完碰撞，再低速手动验证，不拿真机试没跑过的程序。
4. **Python 也能控制机器人**：用 `abb_motion_program_exec` 发指令，打印出 RAPID 先检查再执行。
5. **越问越全**：你每次提问，助手都记下来、加深一点，库和技能一起长大，不会丢。

> 不是 ABB 官方教程，是按官方语法和网上多家新手教程共识重写的教学版，点位是教学值，真机要重新示教。

---

## 🚀 新手安装：3 步

**第 1 步：一条命令装技能（跟别的 skill 一样）**

```bash
npx skills add linxie654-netizen/abb-robot-programming
```

需要 Node.js 22.20 以上。命令会找到仓库里的 `robot-rapid`，让你选装到哪个助手（Claude Code、Cursor 等）。2026-11-20 已实测能装上。

**第 2 步：不用命令行？手动装也行**

先把库下载下来：

```bash
git clone https://github.com/linxie654-netizen/abb-robot-programming.git
```

没装 git？直接打开上面这个链接，点绿色的 `Code` → `Download ZIP`，解压就行。再按下面把技能复制到你的助手里：

| 你用的助手 | 复制命令 |
|---|---|
| Muse | `cp -r abb-robot-programming/skill/robot-rapid ~/workspace/custom-skills/robot-rapid` |
| Claude Code | `cp -r abb-robot-programming/skill/robot-rapid ~/.claude/skills/robot-rapid` |
| 其他助手 | 把 `skill/robot-rapid/SKILL.md` 的全文发给它，或存到它支持的 Skill 目录 |

**第 3 步：问第一个问题**

在助手里直接问，比如：

> 我是新手，从哪开始学 ABB？

助手就会按这个技能的方法，带你从 `rapid/01_move_basics.mod` 开始练。

**还要装 RobotStudio 才能仿真**：去 [ABB 官网](https://new.abb.com/products/robotics/robotstudio/downloads)免费下载，装好后按 `robotstudio/tutorial.md` 建站。没定机器人型号先用 IRB 120 练。

---

## 📂 目录

- `rapid/` — RAPID 教学例程（我按官方语法重写的，不是抄别人的）
  - `01_move_basics.mod` — MoveJ / MoveL / MoveAbsJ 基础
  - `02_pick_place.mod` — 搬运：取料、放料、夹爪 IO
  - `03_io_signals.mod` — 数字 IO、等待信号、SetDO / WaitDI
  - `04_loops_conditions.mod` — IF、FOR、WHILE、计数搬运
  - `05_coordinates.mod` — 工具 tooldata、工件 wobjdata、坐标系
  - `06_joint_move.mod` — J1-J6 关节运动、jointtarget
  - `07_move_circle.mod` — MoveC 圆弧
  - `08_test_case_functions.mod` — TEST/CASE + FUNC 函数返回值
  - `09_error_handling.mod` — ERROR 报错处理、RAISE
  - `10_analog_io_wait.mod` — 模拟量 IO、WaitUntil 等条件
- `python/` — Python 联动例程（用 `abb_motion_program_exec`）
  - `01_move_joints.py` — Python 发 MoveAbsJ
  - `02_pick_place.py` — Python 发 MoveJ/MoveL 搬运
  - `requirements.txt` — `abb-motion-program-exec`
- `robotstudio/` — RobotStudio 教程
  - `tutorial.md` — 建站、选机器人、虚拟控制器、示教、仿真，一步步来
- `docs/` — 速查和对比
  - `beginner-roadmap.md` — 新手必学 12 课路线（网上教程共识版）
  - `cheatsheet.md` — RAPID 速查表
  - `comparison.md` — 网上 APP / 库对比学习表
  - `full-pipeline.md` — 从 0 到 1 全流程 6 段（Skill 版）
  - `connectors.md` — 连接器怎么搞：MCP + RWS + PC SDK，3 条路
  - `mcp-install-6.08.md` — MCP 服务器 + 插件安装（RobotStudio 6.08）
  - `other-ai-prompt.md` — 给另一个 AI 的安装指令（可复制）
- `skill/robot-rapid/` — 唯一的 ABB Skill，叫 Robot-RAPID（通用版，任何人都能装）
  - `SKILL.md` — Skill 正文（RAPID、0 到 1 全流程、桥操作）
  - `INSTALL.md` — 安装方法（Muse / Claude Code / 其他助手）
  - `scripts/`、`references/` — 桥操作脚本和 C# 片段
- `learning-log.md` — 每次提问记录，按用户要求持续记
- `vendor/` — 拉取的开源参考源（别人的项目，保留原仓库和协议）
  - `abb_motion_program_exec/` — rpiRobotics，Apache-2.0
  - `ABB_EGM_Python/` — rparak，MIT
  - `Hershey-ABB-Robot-Handwriting/` — FLo-ABB，MIT

## ✅ 先跑通哪一步

1. 装 RobotStudio（ABB 官网下载，免费版）。
2. 按 `robotstudio/tutorial.md` 建站，选一个机器人（没定型号先用 IRB 120 练）。
3. 在虚拟控制器上跑 `rapid/01_move_basics.mod`。
4. 再跑 `python/01_move_joints.py`，看 Python 怎么发指令。
5. 真机操作前，先在仿真里跑通，确认速度、区域、工具都对。

## ⚠️ 安全提醒

- 真机必须在手动低速下先验证，确认无碰撞再切自动。
- EGM、真机联动要按 ABB 手册开选项，不要在真机上直接试没仿真过的程序。
- 本库例程里的点位、速度都是教学值，换到你的工件和夹具上必须重新示教。
