! 三机器人联动项目：一个控制器带三台机器人（MultiMove），三台一起抬一件长工件、同步搬走
! 点位均为教学值，在自己的工作站里重新示教。
! 需要控制器选项：MultiMove Coordinated（604-1）；三台机器人各一个运动任务 T_ROB1 / T_ROB2 / T_ROB3
! 指令写法按 ABB《Application manual - MultiMove》（3HAC089689-001 / 3HAC050961-001）第 6 章：
!   WaitSyncTask 碰头（半协调）；SyncMoveOn ... SyncMoveOff 之间是同步运动，
!   同步段里每句运动指令都带 \ID，三个任务里相同 \ID 的指令同时开始、同时到点
! 本文件是 T_ROB3 的程序模块，三个文件分别载入三个任务
! 流程：等工件 -> 三台碰头 -> 各自下到抓取点合爪 -> 同步抬起 -> 同步搬到目标 -> 同步放下 -> 松爪回原位

MODULE MultiRobot_T3
  ! ===== 三个任务一模一样的同步标识和任务名单 =====
  VAR syncident sync1;
  VAR syncident sync2;
  VAR syncident sync3;
  VAR syncident sync4;
  ! 任务名必须和控制器里的任务名一模一样
  PERS tasks all_tasks{3} := [["T_ROB1"], ["T_ROB2"], ["T_ROB3"]];

  ! ===== 工具和工件坐标系（教学值） =====
  TASK PERS tooldata tGripper := [TRUE, [[0, 0, 120], [1, 0, 0, 0]], [2.0, [0, 0, 60], [1, 0, 0, 0], 0, 0, 0]];
  ! wobjPart：本机器人看工件的坐标系，原点在本机器人负责的那一段工件顶面
  TASK PERS wobjdata wobjPart := [FALSE, TRUE, "", [[400, 0, 300], [1, 0, 0, 0]], [[0, 0, 0], [1, 0, 0, 0]]];

  ! ===== 点位（教学值，在 wobjPart 里） =====
  CONST robtarget pAbove := [[0, 0, 150], [0, 0.7071, 0, 0.7071], [0, 0, 0, 0], [9E9, 9E9, 9E9, 9E9, 9E9, 9E9]];
  CONST robtarget pGrip := [[0, 0, 0], [0, 0.7071, 0, 0.7071], [0, 0, 0, 0], [9E9, 9E9, 9E9, 9E9, 9E9, 9E9]];
  CONST robtarget pLift := [[0, 0, 200], [0, 0.7071, 0, 0.7071], [0, 0, 0, 0], [9E9, 9E9, 9E9, 9E9, 9E9, 9E9]];
  CONST robtarget pCarry := [[0, 300, 200], [0, 0.7071, 0, 0.7071], [0, 0, 0, 0], [9E9, 9E9, 9E9, 9E9, 9E9, 9E9]];
  CONST robtarget pPut := [[0, 300, 0], [0, 0.7071, 0, 0.7071], [0, 0, 0, 0], [9E9, 9E9, 9E9, 9E9, 9E9, 9E9]];
  CONST robtarget pHome := [[0, 0, 400], [0, 0.7071, 0, 0.7071], [0, 0, 0, 0], [9E9, 9E9, 9E9, 9E9, 9E9, 9E9]];

  PROC main()
    SetDO doGrip3, 0;
    MoveJ pHome, v1000, fine, tGripper\WObj:=wobjPart;
    WHILE TRUE DO
      LiftTogether;
    ENDWHILE
  ENDPROC

  PROC LiftTogether()
    ! 碰头 1：三台都到了再一起下去（半协调，各走各的路）
    WaitSyncTask sync1, all_tasks;
    MoveJ pAbove, v500, z20, tGripper\WObj:=wobjPart;
    MoveL pGrip, v100, fine, tGripper\WObj:=wobjPart;
    SetDO doGrip3, 1;
    WaitTime 0.5;
    ! 碰头 2 + 开始同步：三台都夹紧了才一起抬
    SyncMoveOn sync2, all_tasks;
    MoveL pLift \ID:=10, v100, fine, tGripper\WObj:=wobjPart;
    MoveL pCarry \ID:=20, v200, z10, tGripper\WObj:=wobjPart;
    MoveL pPut \ID:=30, v100, fine, tGripper\WObj:=wobjPart;
    SyncMoveOff sync3;
    ! 同步结束后各自松爪
    SetDO doGrip3, 0;
    WaitTime 0.5;
    MoveL pCarry, v200, z20, tGripper\WObj:=wobjPart;
    MoveJ pHome, v1000, fine, tGripper\WObj:=wobjPart;
    ! 碰头 3：三台都回原位才开始下一件
    WaitSyncTask sync4, all_tasks;
  ENDPROC
ENDMODULE
