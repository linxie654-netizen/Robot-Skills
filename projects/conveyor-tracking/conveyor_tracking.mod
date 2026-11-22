! 输送带跟踪项目：传送带不停，机器人跟着皮带上的工件走、边走边取
! 点位均为教学值，在自己的工作站里重新示教。
! 需要控制器选项：Conveyor Tracking；输送带机械单元在系统参数里叫 CNV1
! 指令写法按 ABB《Application manual - Conveyor tracking》（3HAC050991-001）第 6、8 章：
!   ActUnit CNV1 激活输送带 -> WaitWObj 等工件进启动窗口并连上 ->
!   在随皮带走的工件坐标系里取件 -> 最后一句用固定坐标系、fine 点离开 ->
!   DropWObj 断开 -> DeactUnit CNV1
! 流程：回等待点 -> 激活输送带 -> 等工件 -> 跟着走取件 -> 离开皮带 -> 断开 -> 放到托盘

MODULE ConveyorTracking
  ! ===== 工具（教学值） =====
  TASK PERS tooldata tGripper := [TRUE, [[0, 0, 120], [1, 0, 0, 0]], [0.5, [0, 0, 60], [1, 0, 0, 0], 0, 0, 0]];
  ! ===== 随输送带走的工件坐标系 =====
  ! robhold FALSE；ufprog FALSE = 用户坐标系会动（跟着输送带）；ufmec "CNV1" = 跟哪条输送带
  ! uframe 留零：输送带基坐标系在标定时定好，这里不用填
  TASK PERS wobjdata wobjCnv1 := [FALSE, FALSE, "CNV1", [[0, 0, 0], [1, 0, 0, 0]], [[0, 0, 0], [1, 0, 0, 0]]];
  ! 固定的托盘坐标系：原点在托盘顶面一角
  TASK PERS wobjdata wobjPallet := [FALSE, TRUE, "", [[150, 60, 300], [1, 0, 0, 0]], [[0, 0, 0], [1, 0, 0, 0]]];
  ! 另一种写法用的固定取件坐标系（控制器没有 Conveyor Tracking 选项时用，见文件末尾 PickStopBelt）
  TASK PERS wobjdata wobjBelt := [FALSE, TRUE, "", [[300, -120, 400], [1, 0, 0, 0]], [[0, 0, 0], [1, 0, 0, 0]]];

  ! ===== 点位（教学值） =====
  ! 跟踪段的点在 wobjCnv1 里示教：原点在皮带上的工件那一刻的位置
  CONST robtarget pCnvAbove := [[0, 0, 100], [0, 0.7071, 0, 0.7071], [0, 0, 0, 0], [9E9, 9E9, 9E9, 9E9, 9E9, 9E9]];
  CONST robtarget pCnvPick := [[0, 0, 0], [0, 0.7071, 0, 0.7071], [0, 0, 0, 0], [9E9, 9E9, 9E9, 9E9, 9E9, 9E9]];
  ! 等待点、离开点在固定坐标系（wobj0）里
  CONST robtarget pWait := [[300, -200, 550], [0, 0.7071, 0, 0.7071], [0, 0, 0, 0], [9E9, 9E9, 9E9, 9E9, 9E9, 9E9]];
  CONST robtarget pLeave := [[300, 0, 550], [0, 0.7071, 0, 0.7071], [0, 0, 0, 0], [9E9, 9E9, 9E9, 9E9, 9E9, 9E9]];
  ! 托盘点在 wobjPallet 里
  CONST robtarget pPlaceUp := [[0, 0, 150], [0, 0.7071, 0, 0.7071], [0, 0, 0, 0], [9E9, 9E9, 9E9, 9E9, 9E9, 9E9]];
  CONST robtarget pPlace := [[0, 0, 40], [0, 0.7071, 0, 0.7071], [0, 0, 0, 0], [9E9, 9E9, 9E9, 9E9, 9E9, 9E9]];

  ! 夹爪跟着工件时的停留：在取件点随皮带走 0.3 秒再离开（stoppointdata 的 followtime）
  VAR stoppointdata followTime := [3, FALSE, [0, 0, 0, 0], 0, 0.3, "", 0, 0];
  VAR num nCount := 0;

  PROC main()
    SetDO doGrip, 0;
    ! 跟踪时关掉线性姿态监控，手册例子里同样先 ConfL\Off
    ConfL\Off;
    MoveJ pWait, v1000, fine, tGripper;
    WHILE TRUE DO
      PickOnBelt;
      PlacePart;
      nCount := nCount + 1;
    ENDWHILE
  ENDPROC

  ! 跟着皮带取件：皮带不停
  PROC PickOnBelt()
    ActUnit CNV1;
    ! 等工件过同步开关、进启动窗口，连上以后 wobjCnv1 就跟着工件走
    WaitWObj wobjCnv1;
    MoveL pCnvAbove, v1000, z20, tGripper\WObj:=wobjCnv1;
    ! 下到工件上，用 followTime 在取件点跟着皮带走一小段，夹爪合上
    MoveL pCnvPick, v500, z1\Inpos:=followTime, tGripper\WObj:=wobjCnv1;
    SetDO doGrip, 1;
    MoveL pCnvAbove, v500, z20, tGripper\WObj:=wobjCnv1;
    ! 离开皮带：必须是固定坐标系里的 fine 点，这是结束跟踪的唯一办法
    MoveL pLeave, v1000, fine, tGripper;
    DropWObj wobjCnv1;
    DeactUnit CNV1;
  ENDPROC

  ! 放到托盘
  PROC PlacePart()
    MoveJ pPlaceUp, v1000, z50, tGripper\WObj:=wobjPallet;
    MoveL pPlace, v200, fine, tGripper\WObj:=wobjPallet;
    SetDO doGrip, 0;
    WaitTime 0.3;
    MoveL pPlaceUp, v500, z50, tGripper\WObj:=wobjPallet;
    MoveJ pWait, v1000, fine, tGripper;
  ENDPROC

  ! 另一种写法：控制器没有 Conveyor Tracking 选项时，用光电开关停带再取
  ! 用法：main 里把 PickOnBelt 换成 PickStopBelt；取件点用固定的 wobjBelt
  PROC PickStopBelt()
    WaitDI diPartReady, 1;
    ! 停皮带，等停稳信号再伸手
    SetDO doConvRun, 0;
    WaitDI diConvStopped, 1;
    MoveJ pCnvAbove, v1000, z50, tGripper\WObj:=wobjBelt;
    MoveL pCnvPick, v200, fine, tGripper\WObj:=wobjBelt;
    SetDO doGrip, 1;
    WaitTime 0.3;
    MoveL pCnvAbove, v500, z50, tGripper\WObj:=wobjBelt;
    SetDO doConvRun, 1;
  ENDPROC
ENDMODULE
