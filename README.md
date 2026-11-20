# ABB 编程库

给 elonjack 的 ABB 学习库。中文，拆步骤，完整代码，重要代码逐段讲。
目标：Python + PLC + ABB 机器人联动，做工业自动化。

## 这个库有什么用
- 学 ABB 不用每次从零找资料：RAPID 例程、RobotStudio 教程、Python 联动、新手 12 课路线、速查表都在里面，照着练就行。
- 每次提问都往里面加：你问一个问题，我就记一条、加深一点，库越学越全。
- 放 GitHub 上不会丢：换电脑、换手机，打开 https://github.com/linxie654-netizen/abb-robot-programming 就能看，也能发给别人看。
- 不是 ABB 官方教程，是按官方语法和网上多家新手教程共识重写的教学版，点位是教学值，真机要重新示教。

## 目录

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
  - `connectors.md` — 连接器怎么搞：MCP + RWS + PC SDK，3 条路
  - `mcp-install-6.08.md` — MCP 服务器 + 插件安装（RobotStudio 6.08）
  - `other-ai-prompt.md` — 给另一个 AI 的安装指令（可复制）
- `skill/` — 可安装的 Skill（通用版，任何人都能装）
  - `SKILL.md` — ABB 编程 Skill
  - `INSTALL.md` — 安装方法（Muse / Claude Code / 其他助手）
- `learning-log.md` — 每次提问记录，按用户要求持续记
- `vendor/` — 拉取的开源参考源（别人的项目，保留原仓库和协议）
  - `abb_motion_program_exec/` — rpiRobotics，Apache-2.0
  - `ABB_EGM_Python/` — rparak，MIT
  - `Hershey-ABB-Robot-Handwriting/` — FLo-ABB，MIT

## 先跑通哪一步

1. 装 RobotStudio（ABB 官网下载，免费版）。
2. 按 `robotstudio/tutorial.md` 建站，选一个机器人（没定型号先用 IRB 120 练）。
3. 在虚拟控制器上跑 `rapid/01_move_basics.mod`。
4. 再跑 `python/01_move_joints.py`，看 Python 怎么发指令。
5. 真机操作前，先在仿真里跑通，确认速度、区域、工具都对。

## 安全提醒

- 真机必须在手动低速下先验证，确认无碰撞再切自动。
- EGM、真机联动要按 ABB 手册开选项，不要在真机上直接试没仿真过的程序。
- 本库例程里的点位、速度都是教学值，换到你的工件和夹具上必须重新示教。

## 安装 Skill

`skill/SKILL.md` 是通用版 Skill，任何人都能装，安装方法见 `skill/INSTALL.md`。
以后问 ABB 问题，助手会先按这个 Skill 的方法查库、给代码、做对比。
