# 新手必学路线图：网上教程的共识版

来源：2026-11-20 查了 plcprogramming.io、RobotIndus3、TryPLC、CMU RobotStudio 教程、AYE Tech Hub 等多家新手教程，它们的共识如下。不是我一个人编的，来源见 `docs/comparison.md` 末尾。

## 网上新手教程都讲的 4 种编机器人方法

1. **RAPID 代码**：全控制，运动、逻辑、IO、报错、通讯都能写。最难，但必须学。
2. **RobotStudio 离线编程**：电脑上建站、仿真，虚拟控制器跑真固件。最安全的新手起点。
3. **FlexPendant 示教**：手柄上手动 jog、示教点位，现场调点位最准。
4. **Wizard Easy Programming**：OmniCore 手柄上的图形积木编程，不用写 RAPID，适合操作工做简单任务，不是编程主线。

新手顺序：RobotStudio 仿真 -> RAPID 基础 -> 示教调点 -> 仿真验证。

## 15 课路线（按网上 15 课 / 6 小时+课程归纳）

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
- L12：完整搬运：取料、放料、计数、提示，仿真跑通、查碰撞。算会：取料、放料、计数、提示全套在虚拟控制器里跑通，碰撞检查过，换个工件位置再跑通。
- L13：报错处理：ERROR 陷阱、RAISE、TRAP 中断。对应 `rapid/09_error_handling.mod`。算会：ERROR 陷阱、RAISE、TRAP 各写一段，故意造一个错能被程序接住，跑通 `rapid/09`。
- L14：安全：手动低速先验证、确认无碰撞再切自动、急停和围栏规则、不要试没仿真过的程序。算会：手动低速验证、确认无碰撞再切自动、急停和围栏规则都说得出，没仿真过的程序不跑。
- L15：进阶方向（先知道，不急着学）：多任务、PLC 通讯（Ethernet/IP、PROFINET、OPC UA）、EGM 实时控制、Python 联动。算会：能说清多任务、PLC 通讯、EGM、Python 联动各是干什么的、先学哪个（只要求说清方向，不要求会做；三课在 `docs/advanced-topics.md`，同样要跑通才算会）。

## 官方课程有、本路线补上的知识点（对照 ABB 官方 RoboMasters / Advanced Programming 大纲，2026-11-22 补）

15 课学完再学这 5 课，都在 RobotStudio 虚拟控制器里练。

- L16：系统事件 Event Routine：开机、启动、停止、复位时自动跑一段程序（比如开机先把夹爪 DO 复位）。在系统参数 Controller → Event Routine 里挂例行程序名和事件（POWER_ON、START、STOP、RESET 等）。算会：挂一个 POWER_ON 事件，重启虚拟控制器后那段程序自己跑了（示教器上能看到它写的一句话）。
- L17：搜索 SearchL：机器人沿直线慢慢走，等某个 DI 变化，把变化那一刻的位置记下来，用来找工件高度或边缘。写法 `SearchL \Stop, di_sensor, pFound, pEnd, v100, tool1;`。算会：在仿真里用一个 DI 模拟传感器，SearchL 停下后把 pFound 的 Z 值写到示教器上，换个触发时机再跑一次，记下的位置跟着变。
- L18：限速限加速 AccSet / VelSet：`AccSet 50, 100;` 把加速度降到一半，`VelSet 50, 800;` 速度打五折、最高不超过 800 mm/s。搬易晃的东西、调试时用。算会：同一段路径设前设后各跑一遍，用 RobotStudio 的信号分析器或节拍时间看出差别，最后恢复 `AccSet 100, 100; VelSet 100, 5000;`。
- L19：走着触发 TriggIO + TriggL：机器人不停，走到路径上离终点（或起点）某个距离时自动置 DO，比停下来 SetDO 省时间。先 `TriggIO trig1, 10 \DOp:=do_glue, 1;` 定义，再 `TriggL p20, v300, trig1, z10, tool1;`。算会：仿真里 DO 在离目标 10mm 处变 1，用信号分析器看到 DO 变化时机器人没停。
- L20：姿态监控 ConfJ / ConfL + 事件日志：`ConfL \Off;` 关掉直线运动的姿态监控，走不通的直线有时能过去，代价是腕部可能突然翻转，用完要 `ConfL \On;` 打开。同时学会看事件日志：报错号、原因、处理建议都在里面。算会：故意造一个“姿态不对”的报错，从事件日志里找到报错号和建议，改完跑通；能说清 ConfL \Off 的风险。

另外两样操作员技能，30 课里有、本路线没单列：备份与恢复（RobotStudio 控制器选项卡 → 备份）、UAS 用户授权（谁能改程序、谁只能看）。考 ABB 操作员课会碰到。

## 新手最常犯的错（多家教程都提到的）
1. 语句漏分号 `;`，编译不过。
2. 速度太快、区域用错，靠近工件还用 v1000 + z100。
3. 工具没标 TCP，点位全偏。
4. 工件一动就重示教所有点，其实只改 wobj 就行。
5. 姿态 confdata 不对，报“目标不可达”，要换腕部姿态。
6. 没仿真就直接跑。

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
