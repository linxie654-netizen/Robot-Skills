# 进阶三课：EGM、多任务、外轴（大白话教学）

先决条件是 30 课学完、01 例程跑通——用户 2026-11-22 点了直接学难的，难的课也一样：先看懂，再去仿真里跑，跑通了才算。

内容按通用写，不按版本分开写。点位、速度全是教学值，在仿真里重新示教。

---

## 第 1 课：EGM 实时控制——电脑每 4 毫秒指挥机器人一次

### 是什么

EGM 是 Externally Guided Motion（外部引导运动）的缩写。平时机器人按 RAPID 程序里写好的点位自己走；开了 EGM，机器人改听电脑的话：电脑每 4 毫秒发一次新位置，机器人跟着走。

一句话能干什么：**让电脑实时指挥机器人**，比如跟着视觉、跟着力传感器、跟着另一台设备走，程序里写死的点位做不到的事，EGM 能做到。

EGM 有两种用法（ABB 手册原话）：

| 用法 | 意思 | 什么时候用 |
| --- | --- | --- |
| EGM Position Guidance（位置引导） | 机器人不走程序里的路，改走电脑发来的路 | 电脑要实时指挥机器人，比如视觉引导、力控 |
| EGM Path Correction（路径修正） | 程序里的路照走，电脑只发一个偏移量，把路修一修 | 路已经编好了，但工件有点歪，边走边修正 |

另外还有一种只读的 EGM Position Stream：只往外发机器人数据，不接管控制。

### 先决条件（缺一个都跑不起来）

1. **控制器要有 EGM 选项**：RobotWare 选项 689-1 Externally Guided Motion。系统里没这个选项，EGM 的指令根本编不过。开选项的办法：在 RobotStudio 里右键控制器 → 改选项（Change Options）→ Engineering Tools 里勾 EGM，改完重启控制器。
2. **控制器里配好通讯**：两处。第一处是 Communication → Transmission Protocol 里配 UC 设备（UDPUC），Remote Address 填电脑的 IP；第二处是 Motion → External Motion Interface Data 里配 EGM 性能参数（joint、pose、path_corr 三套）。
3. **电脑那边要有发数据的程序**：EGM 是电脑和控制器之间用 UDP + protobuf 通协议，电脑每 4 毫秒发一次。库里有现成的两套：`vendor/ABB_EGM_Python`（rparak，Python 发关节位置，测过 IRB 120 和 YuMi，MIT 协议）和 `vendor/abb_motion_program_exec`（rpiRobotics，EGM 三种模式都有，Apache-2.0）。
4. **防火墙**：要关电脑防火墙，不然 UDP 包进不来（rparak 的 README 原话）。

### 最小 RAPID 例程（关节模式）

例程照 `vendor/ABB_EGM_Python` 里 IRB 120 的 `Module1.mod` 原文简化，点位是教学值：

```rapid
MODULE ModuleEGM
    ! EGM 的身份证，一个 EGM 会话用一个
    LOCAL VAR egmident egm_id;
    ! EGM 用的工件坐标系：这里就是机器人底座
    LOCAL PERS wobjdata egm_wobj := [FALSE, TRUE, "", [[0.0, 0.0, 0.0],[1.0, 0.0, 0.0, 0.0]], [[0.0, 0.0, 0.0],[1.0, 0.0, 0.0, 0.0]]];
    ! 收敛条件：每个轴方向误差允许正负 0.1 度
    LOCAL CONST egm_minmax egm_condition_orient := [-0.1, 0.1];

    PROC Main()
        ! 先走到一个安全的起始位置，再开 EGM
        MoveAbsJ [[0,0,0,0,0,0],[9E9,9E9,9E9,9E9,9E9,9E9]], v100, fine, tool0\WObj:=wobj0;
        EGM_JOINT_CONTROL;
    ENDPROC

    PROC EGM_JOINT_CONTROL()
        ! 1. 先释放，再领一个 EGM 身份证
        EGMReset egm_id;
        EGMGetId egm_id;
        ! 2. 配通讯：用 UdpUc，名字叫 "default"，机器人叫 "ROB_1"，关节模式
        EGMSetupUC ROB_1, egm_id, "default", "ROB_1", \Joint;

        WHILE TRUE DO
            ! 3. 准备一次 EGM 会话：6 个轴都用同一个收敛条件
            EGMActJoint egm_id,
                        \WObj:=egm_wobj,
                        \J1:=egm_condition_orient
                        \J2:=egm_condition_orient
                        \J3:=egm_condition_orient
                        \J4:=egm_condition_orient
                        \J5:=egm_condition_orient
                        \J6:=egm_condition_orient
                        \LpFilter:=100
                        \SampleRate:=4
                        \MaxPosDeviation:=1000
                        \MaxSpeedDeviation:=1000;
            ! 4. 开始跑：电脑发关节角，机器人跟着走
            EGMRunJoint egm_id, EGM_STOP_HOLD, \J1 \J2 \J3 \J4 \J5 \J6 \CondTime:=1.0 \RampInTime:=0.1 \RampOutTime:=0.1 \PosCorrGain:=1.0;
        ENDWHILE

        ERROR
        ! 电脑断了、UDP 超时，报一句话再继续等，不直接死机
        IF ERRNO = ERR_UDPUC_COMM THEN
            TPWrite "Communication timeout: EGM";
            TRYNEXT;
        ENDIF
    ENDPROC
ENDMODULE
```

电脑那边（Python）要做的事，照 `vendor/abb_motion_program_exec` 的 `examples/egm/egm_joint_target_example.py`：

```python
# 电脑每 4 毫秒发 6 个关节角（单位：度），机器人跟着走
egm = EGM()
while (t2 - t1) < 5:  # 只跑 5 秒做试验
    res, feedback = egm.receive_from_robot(timeout=0.05)
    if res:
        egm.send_to_robot(np.ones((6,)) * np.sin(t2 - t1) * 5)
client.stop_egm()  # 停掉 EGM，机器人回到程序控制
```

三种模式的区别（照 `vendor/abb_motion_program_exec/docs/egm.md`）：

| 模式 | 电脑发什么 | 更新多快 | 难在哪 |
| --- | --- | --- | --- |
| 关节目标（Joint target） | 6 个关节角（度） | 每 4 毫秒 | 最简单，先学这个 |
| 姿态目标（Pose target） | 工具位置（毫米）+ 姿态四元数 | 每 4 毫秒 | 要躲奇异点，参数多 |
| 路径修正（Path correction） | 路径坐标系里的偏移量（毫米） | 48 毫秒才更新一次 | 延迟大，反馈控制容易不稳 |

### 常见坑

- **EGM 会绕过很多安全功能，包括防碰撞**（ABB 手册和上游库的原话警告）。EGM 乱发数据，机器人会乱动。先在 RobotStudio 仿真里测。
- **电脑不发数据，机器人就等着**：EGMRunJoint 跑起来之后，控制器在等电脑的 UDP 包；电脑没发，程序就卡在那，最后报通讯超时 `ERR_UDPUC_COMM`。光写 RAPID 不够，电脑那边必须同时跑。
- **延迟比想的大**：EGM 标称 4 毫秒一发，但实际延迟可能明显更大；拿它做反馈控制（比如力控闭环），延迟大了会抖、会不稳。
- **姿态模式别碰奇异点**：姿态目标是电脑发位置、机器人自己算关节角，走到奇异点附近会算不出来。
- **路径修正别用 fine 点隔开**：`EGMMoveL` / `EGMMoveC` 之间用 fine 点会报错（上游库 egm.md 原话提醒）。

### 依据来源

- ABB《Application manual - Externally Guided Motion》，文档号 3HAC073318-001，RobotWare 7.6：EGM 两种用法、指令表（EGMSetupUC、EGMGetId、EGMActJoint、EGMActPose、EGMActMove、EGMRunJoint、EGMMoveL、EGMMoveC 等）。
- ABB《Application manual - Controller software IRC5》3HAC050798-001 §9.3：EGM 是 689-1 选项；EGM 绕过路径规划、适合需要高响应的场合。
- `vendor/ABB_EGM_Python`（rparak，MIT）：IRB 120 的 `Module1.mod` 原文、README（UDP 端口、防火墙、egm.proto 位置）。
- `vendor/abb_motion_program_exec/docs/egm.md` + `examples/egm/`：三种模式、4 毫秒 / 48 毫秒更新、配置方法、安全警告。

### 算会

算会：例程四步走通，电脑发数据、机器人跟着走；电脑断了报 ERR_UDPUC_COMM 能认出来。

---
## 第 2 课：多任务——一个控制器同时跑几个程序

### 是什么

平时一个控制器跑一个 RAPID 程序（一个任务，叫 T_ROB1）。多任务就是**一个控制器同时跑几个程序**，每个程序叫一个任务（Task），各干各的活，关键地方互相等一等、通个信。

一句话能干什么：**让机器人一边干活，一边有人在后台看着**，或者**让两台机器人互相配合**，不用两个控制器。

什么时候用多任务：

| 场景 | 怎么做 |
| --- | --- |
| 机器人干活，后台一直盯着信号 | 主任务 T_ROB1 动机器人，后台任务一直等信号，信号一到就处理 |
| 两台机器人抬一个重东西 | 两个运动任务，用同步指令让它们同时起、同时停 |
| 机器人焊，变位机跟着转 | 机器人一个任务，变位机一个任务，协调着动 |
| 电脑一直要读机器人状态 | 一个后台任务专门发状态，主任务只管干活，互不干扰 |

### 先决条件

1. **控制器要有 623-1 Multitasking 选项**。没这个选项，控制器里只能有一个任务。
2. **任务分三种类型**，建任务时就要定好（ABB 社区和 ROS 教程的原话）：

| 类型 | 意思 | 用在哪 |
| --- | --- | --- |
| NORMAL（正常） | 急停会停；程序指针停在哪，下次从哪继续 | 机器人运动的任务只能是这个类型；调试时先全用这个类型 |
| STATIC（静态） | 后台跑，急停也不停 | 后台一直跑的监控程序 |
| SEMISTATIC（半静态） | 后台跑，开机自动从头开始跑 | 开机就要自己跑起来的后台程序，比如 ROS 的状态服务器 |

3. **后台任务的模块要预加载**：STATIC 和 SEMISTATIC 任务的模块必须在系统参数里设成自动加载，不然控制器启动时任务里是空的。
4. **调试先用 NORMAL**：RobotStudio 不让直接改 STATIC / SEMISTATIC 任务里的代码。正确做法是先设成 NORMAL 调好，调好了再改回 SEMISTATIC，改完重启控制器。

### 任务之间怎么同步、怎么共享数据

**同步：互相等一等。** 最常用的指令是 `WaitSyncTask`：每个任务跑到这句话就停下，等所有任务都到了，再一起往下跑。像约好了在路口碰头，人齐了再走。

**共享数据：两种办法。**

1. **PERS 变量放公共模块**：一个系统模块（比如叫 `Common.sys`）里放 PERS 变量，所有任务都加载这个模块，谁都能读、谁都能改。ROS 的 ABB 驱动就是这么干的：`ROS_common.sys` 是“所有任务共享的全局变量和数据类型”。
2. **信号**：信号是控制器全局的，一个任务 `SetDO` 发，另一个任务 `WaitDI` 等。信号怎么配、名字要一模一样，见技能里的配信号条目。

**多机器人协调：MultiMove。** 一个控制器最多带 4 台机器人（ABB 产品规格原话），最多 7 个运动任务（比如 4 台机器人 + 1 台变位机 + 2 根附加轴）。MultiMove 分两个选项：

| 选项 | 意思 |
| --- | --- |
| 604-2 MultiMove Independent（独立） | 各台机器人大部分时间各干各的，只在约好的点互相等一等（`WaitSyncTask`） |
| 604-1 MultiMove Coordinated（协调） | 所有动作全程同步，同时起、同时停；604-1 包含 604-2 的全部功能 |

### 最小 RAPID 例程（两台机器人抬东西）

例程照 ABB YuMi 官方例子和 `vendor/abb_motion_program_exec` 的 `examples/multimove_example.py` 简化。两台机器人各一个任务，点位是教学值：

```rapid
! 两个任务共用这几行，每个任务的模块里都要有
VAR syncident sync1;   ! 碰头点 1：都到了再开始
VAR syncident sync2;   ! 碰头点 2：开始协调动作
VAR syncident sync3;   ! 碰头点 3：协调动作结束
! 所有要同步的任务名单，名字必须和控制器里建的任务名一模一样
PERS tasks all_tasks{2} := [["T_ROB1"], ["T_ROB2"]];

! ===== 任务 T_ROB1（机器人 1）=====
PROC Main()
    ! 1. 先碰头：两个任务都跑到这句，才一起往下走
    WaitSyncTask sync1, all_tasks;
    ! 2. 开始协调：从这句起，两台机器人共用一个运动规划，同时起、同时停
    SyncMoveOn sync2, all_tasks;
    ! 3. 协调动作：每句 Move 都要带 \ID，两台机器人相同 \ID 的动作是一对
    MoveJ p1 \ID:=10, v100, z10, tool0;
    MoveL p2 \ID:=20, v100, z10, tool0;
    MoveL p3 \ID:=30, v100, z10, tool0;
    ! 4. 协调结束
    SyncMoveOff sync3;
ENDPROC

! ===== 任务 T_ROB2（机器人 2）=====
PROC Main()
    WaitSyncTask sync1, all_tasks;
    SyncMoveOn sync2, all_tasks;
    ! 注意：\ID 必须和机器人 1 的一一对应，10 对 10，20 对 20
    MoveJ q1 \ID:=10, v100, z10, tool0;
    MoveL q2 \ID:=20, v100, z10, tool0;
    MoveL q3 \ID:=30, v100, z10, tool0;
    SyncMoveOff sync3;
ENDPROC
```

用 Python 发多机程序（照 `vendor/abb_motion_program_exec` 的例子）：两个 `MotionProgram` 各写各的机器人，`SyncMoveOn()` 开头，`execute_multimove_motion_program([mp, mp2])` 一起下发。注意上游库的原话提醒：**两个程序的指令条数必须一样多**。

### 常见坑

- **同步点名字对不上**：`syncident` 变量和 `tasks` 名单，两个任务里必须一模一样；名字差一个字母，任务就永远等不到对方，程序卡死。
- **\ID 没配对**：协调动作里 `SyncMoveOn` 之后每句 Move 的 `\ID`，两台机器人必须一一对应；对不上，控制器不知道哪两句是一对。
- **后台任务改代码改不了**：STATIC / SEMISTATIC 任务在 RobotStudio 里不让直接改代码，先改成 NORMAL，改完再改回去、重启控制器。
- **后台任务里别写运动指令**：后台任务是干杂活的（等信号、发状态、算数据），机器人运动只放在 NORMAL 的运动任务里。
- **急停不停后台任务**：STATIC / SEMISTATIC 任务急停也不停，写后台任务要想清楚：急停的时候它该干什么，别让它在急停后还发指令。
- **同步点设少了会各走各的**：只用 `WaitSyncTask` 碰一次头，碰完头各走各的；要全程一起动，必须用 `SyncMoveOn` / `SyncMoveOff` 包起来。

### 依据来源

- ABB《Product specification - Controller software IRC5》3HAC050945：604-1 MultiMove Coordinated、604-2 MultiMove Independent、一个控制器最多 4 台机器人、最多 7 个运动任务、每个任务可带 1 台机器人 + 最多 6 根不带 TCP 的外轴。
- ABB 社区帖子《Setting up multitasking in RAPID programs》：623-1 选项、三种任务类型、调试先用 NORMAL、后台任务模块要预加载。
- ROS wiki《abb_driver/Tutorials/InstallServer》：623-1 + 672-1 选项、三个任务的建法（ROS_StateServer / ROS_MotionServer 是 SEMISTATIC，T_ROB1 是 NORMAL）、`ROS_common.sys` 共享变量。
- ABB YuMi App 官方例子：`WaitSyncTask` / `SyncMoveOn` / `SyncMoveOff` 的实际写法、`PERS tasks all_tasks{2}`。
- `vendor/abb_motion_program_exec` 的 `examples/multimove_example.py` + `docs/robot_multimove_setup_manual.md`：Python 发双机程序、两程序指令数要一样、一个控制器带两台机器人。

### 算会

算会：两个任务 WaitSyncTask 碰头、PERS 共享数据，协调动作 \ID 一一对应，仿真里跑通。

---
## 第 3 课：外轴——机器人本体之外的第七根轴

### 是什么

外轴就是机器人本体六个轴之外的轴。常见两种：**变位机**（翻转工件的转台）和**导轨**（带着机器人走的轨道）。外轴有自己的电机和标定，控制器把它当第七根轴（或更多轴）管。

一句话能干什么：**让机器人够得着够不着的地方**——工件太大焊一面不够，变位机翻个面再焊；工件太长机器人行程不够，导轨带着机器人走一段。

### 先决条件

1. **外轴要配好、标定好**：外轴的零点、方向要标出来。不标定，外轴转的角度和程序里的角度对不上，焊缝全偏。标定方法按 ABB 操作手册走，标完验证一遍再用。
2. **程序里要先激活外轴**：动外轴之前，先用 `ActUnit` 把外轴的机械单元激活（比如 `ActUnit STN1;`，STN1 是机械单元的名字，按自己系统的名字改）。没激活就动外轴，控制器会报错。
3. **点位里有外轴的值**：`robtarget` 和 `jointtarget` 里除了位置、姿态、关节姿态，还有一项外轴位置（`extjoint`，写成 `extax`）。点位教好后，检查外轴值对不对。

### 最小 RAPID 例程（变位机翻 90 度再焊）

例程照 ABB 社区焊接帖子的写法简化。变位机叫 STN1，点位是教学值：

```rapid
MODULE ModuleExt
    ! 变位机在 0 度时教的焊点
    PERS robtarget pWeld1 := [[500, 0, 300], [0, 0, 1, 0], [0, 0, 0, 0], [0, 9E9, 9E9, 9E9, 9E9, 9E9]];
    PERS robtarget pWeld2 := [[500, 200, 300], [0, 0, 1, 0], [0, 0, 0, 0], [0, 9E9, 9E9, 9E9, 9E9, 9E9]];
    ! 只动变位机的目标：机器人六个轴写 9E9（不动），外轴 eax_a 写 90 度
    PERS jointtarget jTable90 := [[9E9, 9E9, 9E9, 9E9, 9E9, 9E9], [90, 9E9, 9E9, 9E9, 9E9, 9E9]];

    PROC Main()
        ! 1. 先激活变位机这个机械单元
        ActUnit STN1;
        ! 2. 变位机在 0 度，焊第一面
        MoveJ pWeld1, v400, fine, tool0;
        MoveL pWeld2, v100, fine, tool0;
        ! 3. 变位机自己转 90 度，翻个面（MoveExtJ 只动外轴，不动 TCP）
        MoveExtJ jTable90, v100, fine;
        ! 4. 翻完面再焊第二面
        MoveJ pWeld1, v400, fine, tool0;
        MoveL pWeld2, v100, fine, tool0;
    ENDPROC
ENDMODULE
```

看懂例程要记住三点：

- **`9E9` 的意思是“这根轴别管”**：`robtarget` 外轴那 6 个数里写 9E9，就是“这次不动外轴”；`jointtarget` 机器人六个轴写 9E9，就是“这次只动外轴，机器人不动”。
- **`MoveExtJ` 只动外轴**：让外轴自己转到指定角度，不带 TCP 走。机器人和外轴的动作要分开写，别写在同一句里。
- **外轴值跟着点位走**：`robtarget` 里的 `extax` 是外轴位置。变位机在 0 度教的点，变位机转到 90 度再跑，点位就错了——要么重新示教，要么让外轴回到教点的角度再跑。

### 协调运动：机器人边焊、变位机边转

上面例程是“先焊一面、停下来翻个面、再焊另一面”，叫分开动。更难的是**协调运动**：焊缝要变位机边转、机器人边焊，两边同时动。

协调运动两种做法（ABB 社区原话）：

| 做法 | 意思 | 什么时候用 |
| --- | --- | --- |
| 工件坐标系挂在变位机上 | 把 `wobj` 挂到变位机，变位机转，工件坐标系跟着转，机器人按工件坐标系走 | 变位机带着工件转，焊缝相对工件不动，最常用 |
| 两台任务包起来同步 | 机器人一个任务，变位机一个任务，用 `SyncMoveOn` / `SyncMoveOff` 包起来（见第 2 课） | 机器人和变位机各走各的轨迹，但要同时起、同时停 |

协调运动配错了，焊枪和工件各走各的，焊缝全偏。配之前先想清楚：谁带着谁转。

### 常见坑

- **外轴没标定就编程序**：转的角度和程序里的角度对不上，怎么调都不对，先标定再编程。
- **忘了 `ActUnit`**：动外轴之前没激活机械单元，控制器报错；机械单元名字按自己系统的改，别照抄 STN1。
- **点位教的时候外轴在 0 度，跑的时候在 90 度**：点位全错。要么外轴回教点的角度再跑，要么重新示教。
- **外轴动作和机器人动作写在同一句**：控制器不知道先动谁，分开写。
- **变位机翻工件时人在单元里**：外轴动起来力气大、范围大，翻工件时人在单元外，联动区域要划禁区。
- **速度用太大**：变位机带着重工件转，速度先用小的（比如 v100），跑顺了再往上加。

### 依据来源

- ABB《Technical reference manual - RAPID overview》3HAC16580-1 §2.8：`MoveExtJ` 是“动直线或旋转外轴，不带 TCP”；`SearchExtJ` 是外轴搜索。
- ABB 社区帖子《Issue with my weld program, Please help》：`ActUnit STN1` 先激活、点位重示教要带外轴值、`9E9` 表示不引用外轴位置、机器人和变位机分开编程序的做法。
- ABB 社区帖子《Toolpathing of a spiral》：`extax.eax_a` 的写法、协调运动用 `SyncMoveOn` 包两个任务、变位机当机械单元的做法。
- ABB《Product specification - Controller software IRC5》3HAC050945：每个 RAPID 任务可带 1 台机器人 + 最多 6 根不带 TCP 的外轴。
- `docs/youtube-study/drafts/external-axis-programming.md`（本地草稿）：RU011 Day 4 大纲、外轴的两种形态、标定和安全要点。

---

## 三课的关系：先学哪个

| 顺序 | 课 | 为什么这个顺序 |
| --- | --- | --- |
| 先 | 第 3 课 外轴 | 最常用，焊接、搬运都碰得到；只用 RAPID 就能写，不用另外装东西 |
| 再 | 第 2 课 多任务 | 两个机器人配合、后台盯信号都要它；要开 623-1 选项 |
| 最后 | 第 1 课 EGM | 最难，要开 689-1 选项、要配通讯、电脑还要同时发数据；先把前两课跑通再碰 |

下一步去 RobotStudio 里跑：外轴先建一个带变位机的工作站，多任务先建两个任务碰一次头，EGM 先跑通 `vendor/ABB_EGM_Python` 的 IRB 120 例子。跑通一课，再学下一课。

## 依据来源总表

| 内容 | 来源 |
| --- | --- |
| EGM 两种用法、指令表 | ABB《Application manual - Externally Guided Motion》3HAC073318-001（RobotWare 7.6） |
| EGM 是 689-1 选项、绕过路径规划 | ABB《Application manual - Controller software IRC5》3HAC050798-001 §9.3 |
| EGM 关节模式 RAPID 原文 | `vendor/ABB_EGM_Python/ABB_RobotStudio/ABB_IRB_120/T_ROB_1/Module1.mod`（rparak，MIT） |
| EGM 三种模式、配置、安全警告 | `vendor/abb_motion_program_exec/docs/egm.md`、`examples/egm/` |
| 多任务 623-1、三种任务类型、调试方法 | ABB 社区《Setting up multitasking in RAPID programs》、ROS wiki《abb_driver/Tutorials/InstallServer》 |
| MultiMove 604-1 / 604-2、最多 4 台机器人、最多 7 个运动任务 | ABB《Product specification - Controller software IRC5》3HAC050945 |
| 同步写法 `WaitSyncTask` / `SyncMoveOn` / `SyncMoveOff` | ABB YuMi App 官方例子、`vendor/abb_motion_program_exec/examples/multimove_example.py` |
| 外轴 `MoveExtJ`、`ActUnit`、`9E9`、`extax.eax_a` | ABB《Technical reference manual - RAPID overview》3HAC16580-1 §2.8、ABB 社区焊接帖和螺旋轨迹帖 |
| 外轴大纲、两种形态 | `docs/youtube-study/drafts/external-axis-programming.md`（RU011 Day 4） |

### 算会

算会：ActUnit 激活、MoveExtJ 转 90 度、9E9 会写，变位机翻面再焊跑通。
