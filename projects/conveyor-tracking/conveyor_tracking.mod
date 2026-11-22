! 输送带跟踪项目：传送带不停，机器人跟着动的料取件
! 1. 需要 Conveyor Tracking 选项，没这个选项跟踪编不过
! 2. 动态跟踪要靠选项里的跟踪指令和输送带标定，
!    那些指令名、参数名这里不编、不写，用之前先查跟踪手册
! 3. 下面是“传送带停一下再取”的保守骨架（等料到、皮带停、再取件），
!    不是动态跟踪；先把这个骨架在仿真里跑起来，再按跟踪手册补动态跟踪的写法
! 点位是示例值，在自己的工作站里重新示教。
! 流程：等料到取料区 -> 发皮带停 -> 等皮带停稳 -> 取料 -> 发皮带走 -> 放料到托盘

MODULE ConveyorTracking
  ! ===== 工具和工件坐标系（教学值，量自己的再改） =====
  TASK PERS tooldata tGripper := [TRUE, [[0, 0, 120], [1, 0, 0, 0]], [0.5, [0, 0, 60], [1, 0, 0, 0], 0, 0, 0]];
  ! wobjConv：原点在传送带取料点（皮带顶面）
  TASK PERS wobjdata wobjConv := [FALSE, TRUE, "", [[300, -120, 400], [1, 0, 0, 0]], [[0, 0, 0], [1, 0, 0, 0]]];
  ! wobjPallet：原点在托盘顶面一角
  TASK PERS wobjdata wobjPallet := [FALSE, TRUE, "", [[150, 60, 300], [1, 0, 0, 0]], [[0, 0, 0], [1, 0, 0, 0]]];

  ! ===== 点位（教学值） =====
  CONST robtarget pPickUp := [[0, 0, 180], [0, 0.7071, 0, 0.7071], [0, 0, 0, 0], [9E9, 9E9, 9E9, 9E9, 9E9, 9E9]];
  CONST robtarget pPick := [[0, 0, 60], [0, 0.7071, 0, 0.7071], [0, 0, 0, 0], [9E9, 9E9, 9E9, 9E9, 9E9, 9E9]];
  CONST robtarget pPlaceUp := [[0, 0, 180], [0, 0.7071, 0, 0.7071], [0, 0, 0, 0], [9E9, 9E9, 9E9, 9E9, 9E9, 9E9]];
  CONST robtarget pPlace := [[0, 0, 60], [0, 0.7071, 0, 0.7071], [0, 0, 0, 0], [9E9, 9E9, 9E9, 9E9, 9E9, 9E9]];
  CONST robtarget pHome := [[100, 100, 500], [0, 0.7071, 0, 0.7071], [0, 0, 0, 0], [9E9, 9E9, 9E9, 9E9, 9E9, 9E9]];

  VAR num nCount := 0;

  PROC main()
    SetDO doGrip, 0;
    ! 一开始皮带走起来，等料来
    SetDO doConvRun, 1;
    MoveJ pHome, v1000, z50, tGripper;
    WHILE TRUE DO
      PickOnBelt;
      PlacePart;
      nCount := nCount + 1;
    ENDWHILE
  ENDPROC

  ! 在皮带上取件（保守版：停带再取，不是动态跟踪）
  PROC PickOnBelt()
    ! 料到了取料区，传感器亮
    WaitDI diPartReady, 1;
    ! 停皮带，等停稳信号再动手，皮带还在动绝不伸手
    SetDO doConvRun, 0;
    WaitDI diConvStopped, 1;
    WaitTime 0.3;
    MoveJ pPickUp, v1000, z50, tGripper\WObj:=wobjConv;
    MoveL pPick, v200, fine, tGripper\WObj:=wobjConv;
    SetDO doGrip, 1;
    WaitTime 0.3;
    MoveL pPickUp, v500, z50, tGripper\WObj:=wobjConv;
    ! 取完再开皮带，让下一件料进来
    SetDO doConvRun, 1;
    WaitDI diConvStopped, 0;
  ENDPROC

  ! 放料到托盘
  PROC PlacePart()
    MoveJ pPlaceUp, v1000, z50, tGripper\WObj:=wobjPallet;
    MoveL pPlace, v200, fine, tGripper\WObj:=wobjPallet;
    SetDO doGrip, 0;
    WaitTime 0.3;
    MoveL pPlaceUp, v500, z50, tGripper\WObj:=wobjPallet;
  ENDPROC
ENDMODULE
