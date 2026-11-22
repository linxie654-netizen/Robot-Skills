! 上下料项目：给机床上毛坯、等机床加工完、再把成品取出来
! 点位是示例值，在自己的工作站里重新示教。
! 场景（教学设定）：传送带来毛坯，机器人放进机床，机床加工，机器人取出成品放到成品托盘
! 机床门、加工完成信号都走 IO，门没开好、机床没停稳，机器人绝不伸手进去
! 信号名要和控制器里的 IO 配置对上
! 流程：等毛坯 -> 取毛坯 -> 等机床空闲 -> 开门 -> 上料 -> 关门 -> 发加工启动
!       -> 等加工完 -> 开门 -> 取成品 -> 关门 -> 放成品到托盘

MODULE Loading
  ! ===== 工具和工件坐标系（教学值，量自己的再改） =====
  TASK PERS tooldata tGripper := [TRUE, [[0, 0, 120], [1, 0, 0, 0]], [0.5, [0, 0, 60], [1, 0, 0, 0], 0, 0, 0]];
  ! wobjConv：原点在传送带取料点（皮带顶面）
  TASK PERS wobjdata wobjConv := [FALSE, TRUE, "", [[300, -120, 400], [1, 0, 0, 0]], [[0, 0, 0], [1, 0, 0, 0]]];
  ! wobjMachine：原点在机床夹具中心
  TASK PERS wobjdata wobjMachine := [FALSE, TRUE, "", [[200, 150, 400], [1, 0, 0, 0]], [[0, 0, 0], [1, 0, 0, 0]]];
  ! wobjOut：原点在成品托盘一角
  TASK PERS wobjdata wobjOut := [FALSE, TRUE, "", [[150, -150, 300], [1, 0, 0, 0]], [[0, 0, 0], [1, 0, 0, 0]]];

  ! ===== 点位（教学值） =====
  CONST robtarget pPickUp := [[0, 0, 180], [0, 0.7071, 0, 0.7071], [0, 0, 0, 0], [9E9, 9E9, 9E9, 9E9, 9E9, 9E9]];
  CONST robtarget pPick := [[0, 0, 60], [0, 0.7071, 0, 0.7071], [0, 0, 0, 0], [9E9, 9E9, 9E9, 9E9, 9E9, 9E9]];
  CONST robtarget pLoadUp := [[0, 0, 180], [0, 0.7071, 0, 0.7071], [0, 0, 0, 0], [9E9, 9E9, 9E9, 9E9, 9E9, 9E9]];
  CONST robtarget pLoad := [[0, 0, 60], [0, 0.7071, 0, 0.7071], [0, 0, 0, 0], [9E9, 9E9, 9E9, 9E9, 9E9, 9E9]];
  CONST robtarget pOutUp := [[0, 0, 180], [0, 0.7071, 0, 0.7071], [0, 0, 0, 0], [9E9, 9E9, 9E9, 9E9, 9E9, 9E9]];
  CONST robtarget pOut := [[0, 0, 60], [0, 0.7071, 0, 0.7071], [0, 0, 0, 0], [9E9, 9E9, 9E9, 9E9, 9E9, 9E9]];
  CONST robtarget pHome := [[100, 100, 500], [0, 0.7071, 0, 0.7071], [0, 0, 0, 0], [9E9, 9E9, 9E9, 9E9, 9E9, 9E9]];

  VAR num nDoneCount := 0; ! 已经加工好的件数

  PROC main()
    SetDO doGrip, 0;
    SetDO doCycleStart, 0;
    MoveJ pHome, v1000, z50, tGripper;
    WHILE TRUE DO
      ! 先取毛坯，再上料，再等加工，再取成品
      PickBlank;
      LoadMachine;
      WaitDI diCycleDone, 1;
      UnloadMachine;
      PlaceFinished;
      nDoneCount := nDoneCount + 1;
      TPWrite "加工完 " + NumToStr(nDoneCount, 0) + " 件";
    ENDWHILE
  ENDPROC

  ! 取毛坯：等料 -> 下降 -> 合爪 -> 抬起
  PROC PickBlank()
    WaitDI diPartReady, 1;
    MoveJ pPickUp, v1000, z50, tGripper\WObj:=wobjConv;
    MoveL pPick, v200, fine, tGripper\WObj:=wobjConv;
    SetDO doGrip, 1;
    WaitTime 0.3;
    MoveL pPickUp, v500, z50, tGripper\WObj:=wobjConv;
  ENDPROC

  ! 上料：等机床空闲 -> 开门（等门开好信号）-> 放进夹具 -> 松爪 -> 退出 -> 关门 -> 发加工启动
  ! 门的开 / 关是发一个脉冲还是保持信号、门开好信号来没来，按机床说明书对；
  ! 这里按“发信号、等回信”的保守写法
  PROC LoadMachine()
    WaitDI diMachineReady, 1;
    SetDO doDoorOpen, 1;
    WaitDI diDoorOpen, 1;
    MoveJ pLoadUp, v500, z50, tGripper\WObj:=wobjMachine;
    MoveL pLoad, v100, fine, tGripper\WObj:=wobjMachine;
    SetDO doGrip, 0;
    WaitTime 0.3;
    MoveL pLoadUp, v500, z50, tGripper\WObj:=wobjMachine;
    MoveJ pHome, v1000, z50, tGripper;
    SetDO doDoorOpen, 0;
    WaitDI diDoorOpen, 0;
    SetDO doCycleStart, 1;
    WaitTime 0.5;
    SetDO doCycleStart, 0;
  ENDPROC

  ! 取成品：等加工完 -> 开门（等门开好）-> 进去夹成品 -> 退出 -> 关门
  PROC UnloadMachine()
    SetDO doDoorOpen, 1;
    WaitDI diDoorOpen, 1;
    MoveJ pLoadUp, v500, z50, tGripper\WObj:=wobjMachine;
    MoveL pLoad, v100, fine, tGripper\WObj:=wobjMachine;
    SetDO doGrip, 1;
    WaitTime 0.3;
    MoveL pLoadUp, v500, z50, tGripper\WObj:=wobjMachine;
    MoveJ pHome, v1000, z50, tGripper;
    SetDO doDoorOpen, 0;
    WaitDI diDoorOpen, 0;
  ENDPROC

  ! 放成品到托盘：下降 -> 松爪 -> 抬起
  PROC PlaceFinished()
    MoveJ pOutUp, v1000, z50, tGripper\WObj:=wobjOut;
    MoveL pOut, v200, fine, tGripper\WObj:=wobjOut;
    SetDO doGrip, 0;
    WaitTime 0.3;
    MoveL pOutUp, v500, z50, tGripper\WObj:=wobjOut;
  ENDPROC
ENDMODULE
