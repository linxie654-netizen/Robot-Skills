! 搬运项目：传送带来料 -> 机器人搬到托盘
! 点位是示例值，在自己的工作站里重新示教。
! 够不着就把传送带 / 托盘往机器人跟前挪
! 信号名要和控制器里的 IO 配置对上，这里用 diPartReady / doGrip / diPalletReady
! 流程：等料 -> 取料 -> 搬运 -> 放料 -> 计数，托盘满了等换托盘

MODULE Handling
  ! ===== 工具和工件坐标系（教学值，量自己的再改） =====
  ! tGripper：TCP 在夹爪尖端，法兰下 120 mm
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

  CONST num nPalletMax := 6; ! 一托盘放 6 件（教学值，按自己托盘改）
  VAR num nCount := 0;       ! 已经搬好的件数

  PROC main()
    ! 一开始夹爪松开，回安全点
    SetDO doGrip, 0;
    MoveJ pHome, v1000, z50, tGripper;
    WHILE TRUE DO
      ! 托盘没就位就等着，别空搬
      WaitDI diPalletReady, 1;
      PickPart;
      PlacePart;
      nCount := nCount + 1;
      ! 一托盘搬满：回安全点，报数，等换托盘
      IF nCount >= nPalletMax THEN
        MoveJ pHome, v1000, z50, tGripper;
        TPWrite "一托盘搬满，共 " + NumToStr(nCount, 0) + " 件，换托盘后继续";
        WaitDI diPalletReady, 0;
        WaitDI diPalletReady, 1;
        nCount := 0;
      ENDIF
    ENDWHILE
  ENDPROC

  ! 取料：等料到 -> 下降 -> 合爪 -> 抬起
  PROC PickPart()
    WaitDI diPartReady, 1;
    MoveJ pPickUp, v1000, z50, tGripper\WObj:=wobjConv;
    MoveL pPick, v200, fine, tGripper\WObj:=wobjConv;
    SetDO doGrip, 1;
    WaitTime 0.3;
    MoveL pPickUp, v500, z50, tGripper\WObj:=wobjConv;
  ENDPROC

  ! 放料：下降 -> 松爪 -> 抬起
  PROC PlacePart()
    MoveJ pPlaceUp, v1000, z50, tGripper\WObj:=wobjPallet;
    MoveL pPlace, v200, fine, tGripper\WObj:=wobjPallet;
    SetDO doGrip, 0;
    WaitTime 0.3;
    MoveL pPlaceUp, v500, z50, tGripper\WObj:=wobjPallet;
  ENDPROC
ENDMODULE
