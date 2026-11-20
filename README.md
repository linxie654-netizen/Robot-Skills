# ABB 编程库

给 elonjack 的 ABB 学习库。中文，拆步骤，完整代码，重要代码逐段讲。
目标：Python + PLC + ABB 机器人联动，做工业自动化。

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

## 自定义 Skill

`~/workspace/custom-skills/abb_robot_programming/SKILL.md`
以后在这个窗口问 ABB 问题，我会先按这个 Skill 的方法查库、给代码、做对比。
