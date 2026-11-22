! 三机器人联动项目：三台机器人一个控制器，配合搬一件大工件
! 思路照 docs/advanced-topics.md 第 2 课（多任务）写：
! - 需要 623-1 Multitasking 选项；要全程一起动，还需要 MultiMove 选项
! - 这是骨架：同步和协调动作的写法按手册补齐，补完在仿真里跑
! - 三个任务：T_ROB1、T_ROB2、T_ROB3，各带一台机器人
! - 同步靠 WaitSyncTask 碰头，协调动作靠 SyncMoveOn / SyncMoveOff 包起来，
!   协调动作里每句 Move 都带 \ID，三台机器人相同 \ID 的动作是一对
! - 下面一个文件里写了三个任务的 PROC，各任务的模块里只留自己那一份，
!   main 里只调自己机器人的 PROC，别把三台的都调了
! - 三台机器人怎么摆、工件多重、谁抬哪头，仿真里先搭再调
! 点位是示例值，在自己的工作站里重新示教。
! 流程：三台先碰头 -> 开始协调 -> 一起抬起工件 -> 一起搬到目标点 -> 一起放下 -> 协调结束

MODULE MultiRobot
  ! ===== 三个任务共用的同步点和任务名单（每个任务的模块里都要一模一样） =====
  VAR syncident sync1; ! 碰头点 1：都到了再开始
  VAR syncident sync2; ! 碰头点 2：开始协调动作
  VAR syncident sync3; ! 碰头点 3：协调动作结束
  ! 任务名单，名字必须和控制器里建的任务名一模一样，差一个字母就永远等不到对方
  PERS tasks all_tasks{3} := [["T_ROB1"], ["T_ROB2"], ["T_ROB3"]];

  ! ===== 工具（教学值，每台机器人按自己的工具改） =====
  TASK PERS tooldata tGripper := [TRUE, [[0, 0, 120], [1, 0, 0, 0]], [0.5, [0, 0, 60], [1, 0, 0, 0], 0, 0, 0]];

  ! ===== 工件坐标系（教学值，三台共用一件大工件） =====
  ! wobjPart：原点在工件左端顶面中心；下面 Move 句现在没写 \\WObj，走的是默认 wobj0，
  ! 示教点位时改成 \\WObj:=wobjPart，并按工件实际位置重标
  TASK PERS wobjdata wobjPart := [FALSE, TRUE, "", [[350, -150, 500], [1, 0, 0, 0]], [[0, 0, 0], [1, 0, 0, 0]]];

  ! ===== 点位（教学值） =====
  ! 机器人 1 的点：抬工件左端
  CONST robtarget p1Up := [[350, -150, 650], [0, 0.7071, 0, 0.7071], [0, 0, 0, 0], [9E9, 9E9, 9E9, 9E9, 9E9, 9E9]];
  CONST robtarget p1Lift := [[350, -150, 500], [0, 0.7071, 0, 0.7071], [0, 0, 0, 0], [9E9, 9E9, 9E9, 9E9, 9E9, 9E9]];
  CONST robtarget p1Target := [[350, 0, 500], [0, 0.7071, 0, 0.7071], [0, 0, 0, 0], [9E9, 9E9, 9E9, 9E9, 9E9, 9E9]];
  ! 机器人 2 的点：抬工件中间
  CONST robtarget p2Up := [[350, 0, 650], [0, 0.7071, 0, 0.7071], [0, 0, 0, 0], [9E9, 9E9, 9E9, 9E9, 9E9, 9E9]];
  CONST robtarget p2Lift := [[350, 0, 500], [0, 0.7071, 0, 0.7071], [0, 0, 0, 0], [9E9, 9E9, 9E9, 9E9, 9E9, 9E9]];
  CONST robtarget p2Target := [[350, 150, 500], [0, 0.7071, 0, 0.7071], [0, 0, 0, 0], [9E9, 9E9, 9E9, 9E9, 9E9, 9E9]];
  ! 机器人 3 的点：抬工件右端
  CONST robtarget p3Up := [[350, 150, 650], [0, 0.7071, 0, 0.7071], [0, 0, 0, 0], [9E9, 9E9, 9E9, 9E9, 9E9, 9E9]];
  CONST robtarget p3Lift := [[350, 150, 500], [0, 0.7071, 0, 0.7071], [0, 0, 0, 0], [9E9, 9E9, 9E9, 9E9, 9E9, 9E9]];
  CONST robtarget p3Target := [[350, 300, 500], [0, 0.7071, 0, 0.7071], [0, 0, 0, 0], [9E9, 9E9, 9E9, 9E9, 9E9, 9E9]];
  CONST robtarget pHome := [[100, 100, 500], [0, 0.7071, 0, 0.7071], [0, 0, 0, 0], [9E9, 9E9, 9E9, 9E9, 9E9, 9E9]];

  ! ===== 任务 T_ROB1 的主程序（只在 T_ROB1 里跑） =====
  PROC main()
    ! 等工件就位再动手，没工件不抬
    WaitDI diPartReady, 1;
    ! 机器人 1 先合爪夹住工件左端（夹爪信号按自己系统对，见 README 的 IO 表）
    SetDO doGrip, 1;
    WaitTime 0.3;
    Rob1Move;
  ENDPROC

  ! 机器人 1：碰头 -> 协调抬起 -> 协调搬运 -> 协调放下 -> 结束
  PROC Rob1Move()
    WaitSyncTask sync1, all_tasks;
    SyncMoveOn sync2, all_tasks;
    MoveJ p1Up \ID:=10, v100, z10, tGripper;
    MoveL p1Lift \ID:=20, v100, z10, tGripper;
    MoveL p1Target \ID:=30, v100, z10, tGripper;
    SyncMoveOff sync3;
    MoveJ pHome, v500, z50, tGripper;
  ENDPROC

  ! ===== 任务 T_ROB2 的动作（只在 T_ROB2 里跑，main 里调 Rob2Move） =====
  ! \ID 必须和机器人 1、3 的一一对应，10 对 10，20 对 20，30 对 30
  PROC Rob2Move()
    WaitSyncTask sync1, all_tasks;
    SyncMoveOn sync2, all_tasks;
    MoveJ p2Up \ID:=10, v100, z10, tGripper;
    MoveL p2Lift \ID:=20, v100, z10, tGripper;
    MoveL p2Target \ID:=30, v100, z10, tGripper;
    SyncMoveOff sync3;
    MoveJ pHome, v500, z50, tGripper;
  ENDPROC

  ! ===== 任务 T_ROB3 的动作（只在 T_ROB3 里跑，main 里调 Rob3Move） =====
  PROC Rob3Move()
    WaitSyncTask sync1, all_tasks;
    SyncMoveOn sync2, all_tasks;
    MoveJ p3Up \ID:=10, v100, z10, tGripper;
    MoveL p3Lift \ID:=20, v100, z10, tGripper;
    MoveL p3Target \ID:=30, v100, z10, tGripper;
    SyncMoveOff sync3;
    MoveJ pHome, v500, z50, tGripper;
  ENDPROC
ENDMODULE
