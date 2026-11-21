# 新手必学路线图：网上教程的共识版

来源：2026-11-20 查了 plcprogramming.io、RobotIndus3、TryPLC、CMU RobotStudio 教程、AYE Tech Hub 等多家新手教程，它们的共识如下。不是我一个人编的，来源见 `docs/comparison.md` 末尾。

## 网上新手教程都讲的 4 种编机器人方法

1. **RAPID 代码**：全控制，运动、逻辑、IO、报错、通讯都能写。最难，但必须学。
2. **RobotStudio 离线编程**：电脑上建站、仿真，虚拟控制器跑真固件，验证好了再传真机。最安全的新手起点。
3. **FlexPendant 示教**：手柄上手动 jog、示教点位，现场调点位最准。
4. **Wizard Easy Programming**：OmniCore 手柄上的图形积木编程，不用写 RAPID，适合操作工做简单任务，不是编程主线。

新手顺序：RobotStudio 仿真 -> RAPID 基础 -> 示教调点 -> 真机低速验证。

## 12 课路线（按网上 15 课 / 6 小时+课程归纳）

### 第 1 周：先跑起来
- L1：认识系统：机器人本体 IRB + 控制器 IRC5 / OmniCore + FlexPendant + RobotStudio。算会：能说清本体、控制器、示教器、RobotStudio 各是干什么的。
- L2：RobotStudio 建站：新建工作站、选机器人、启动虚拟控制器、jog J1-J6。算会：新建工作站、选好机器人、启动虚拟控制器、jog J1-J6 一整套走得通。
- L3：第一个程序：MODULE + PROC main + TPWrite，先让示教器显示一句话。算会：程序在虚拟控制器里跑起来，示教器显示出那句话。
- L4：示教点：Jog 到姿态 -> Teach Target -> 建 Path -> 同步到 RAPID -> 仿真播放。算会：Jog、示教、建 Path、同步、仿真播放一整套走通，点位是自己示教的。

### 第 2 周：RAPID 基础
- L5：数据：VAR 可变、CONST 固定；num、bool、string；robtarget、jointtarget、tooldata、wobjdata、speeddata、zonedata。算会：每种数据都说得出一个用的地方，写一段类型用对了的程序。
- L6：运动：MoveJ（关节，快，路径弯）、MoveL（直线，路径直）、MoveC（圆弧）、MoveAbsJ（直接给 J1-J6 角度，回零用）。算会：四种运动各写一段，在虚拟控制器里跑通，说得出哪种情况用哪种。
- L7：速度和区域：v5 到 vmax，数字是 mm/s；fine 精确定位停稳，z50/z100 是圆角不停。靠近工件用 v200 + fine，空跑用 v1000 + z50。算会：靠近工件用 v200 + fine、空跑用 v1000 + z50 写对了，靠近工件还用 v1000 + z100 能自己发现不对。
- L8：流程控制：IF/ELSEIF/ELSE、FOR、WHILE、TEST/CASE。对应本库 `rapid/04_loops_conditions.mod` 和 `rapid/08_test_case_functions.mod`。算会：四种流程控制各写一段，跑通 `rapid/04` 和 `rapid/08` 的对应例程。

### 第 3 周：坐标系和 IO
- L9：坐标系：世界 wobj0、关节坐标、工具坐标、工件坐标。工具 TCP 要标定，工件位置一动只改 wobj，不重示教每个点。算会：工具 TCP 标定过，工件挪地方只改 wobj、不重示教每个点，仿真里验证过。
- L10：IO：SetDO、WaitDI、WaitUntil、SetAO/WaitAI；传感器有料才做，没料跳过。对应 `rapid/03_io_signals.mod` 和 `rapid/10_analog_io_wait.mod`。算会：SetDO、WaitDI、WaitUntil 写进程序，有料才做、没料跳过，跑通 `rapid/03` 和 `rapid/10`。
- L11：程序结构：PROC 做动作、FUNC 返回值、模块分开写，主程序只调子程序。对应 `rapid/08_test_case_functions.mod` 里的 FUNC 例子。算会：一段程序按“主程序只调子程序”拆开，拆完还能跑通。

### 第 4 周：做完整应用 + 排错
- L12：完整搬运：取料、放料、计数、提示，仿真跑通、查碰撞，再上真机低速验证。算会：取料、放料、计数、提示全套在虚拟控制器里跑通，碰撞检查过，换个工件位置再跑通。
- L13：报错处理：ERROR 陷阱、RAISE、TRAP 中断。对应 `rapid/09_error_handling.mod`。算会：ERROR 陷阱、RAISE、TRAP 各写一段，故意造一个错能被程序接住，跑通 `rapid/09`。
- L14：安全：手动低速先验证、确认无碰撞再切自动、急停和围栏规则、不要在真机上试没仿真过的程序。算会：手动低速验证、确认无碰撞再切自动、急停和围栏规则都说得出，没仿真过的程序不上真机。
- L15：进阶方向（先知道，不急着学）：多任务、PLC 通讯（Ethernet/IP、PROFINET、OPC UA）、EGM 实时控制、Python 联动。算会：能说清多任务、PLC 通讯、EGM、Python 联动各是干什么的、先学哪个（只要求说清方向，不要求会做；三课在 `docs/advanced-topics.md`，同样要跑通才算会）。

## 新手最常犯的错（多家教程都提到的）
1. 语句漏分号 `;`，编译不过。
2. 速度太快、区域用错，靠近工件还用 v1000 + z100。
3. 工具没标 TCP，点位全偏。
4. 工件一动就重示教所有点，其实只改 wobj 就行。
5. 姿态 confdata 不对，报“目标不可达”，要换腕部姿态。
6. 没仿真就上真机。

## 本库对应关系
- 基础移动：`rapid/01_move_basics.mod`
- 搬运：`rapid/02_pick_place.mod`
- IO：`rapid/03_io_signals.mod`、`rapid/10_analog_io_wait.mod`
- 循环判断：`rapid/04_loops_conditions.mod`
- 坐标系：`rapid/05_coordinates.mod`
- J1-J6：`rapid/06_joint_move.mod`
- 圆弧：`rapid/07_move_circle.mod`
- TEST/CASE + 函数：`rapid/08_test_case_functions.mod`
- 报错：`rapid/09_error_handling.mod`
- 速查：`docs/cheatsheet.md`
- RobotStudio：`robotstudio/tutorial.md`
- Python 联动：`python/01_move_joints.py`、`python/02_pick_place.py`
