! 分拣项目：传送带来料 -> 按类型分到 3 个箱子，不认识的进废品箱
! 点位是示例值，在自己的工作站里重新示教。
! 分法（教学设定）：两个光电信号拼出类型——diTypeA=1 是 A 类，diTypeB=1 是 B 类，
! 两个都是 0 是 C 类，两个都是 1 算认不出来，进废品箱
! 信号名要和控制器里的 IO 配置对上
! 流程：等料 -> 读类型 -> 取料 -> 按类型放进对应的箱子 -> 计数

MODULE Sorting
  ! ===== 工具和工件坐标系（教学值，量自己的再改） =====
  TASK PERS tooldata tGripper := [TRUE, [[0, 0, 120], [1, 0, 0, 0]], [0.5, [0, 0, 60], [1, 0, 0, 0], 0, 0, 0]];
  ! wobjConv：原点在传送带取料点（皮带顶面）
  TASK PERS wobjdata wobjConv := [FALSE, TRUE, "", [[300, -120, 400], [1, 0, 0, 0]], [[0, 0, 0], [1, 0, 0, 0]]];
  ! wobjBin：原点在分拣区一角，三个箱子的放料点都相对它
  TASK PERS wobjdata wobjBin := [FALSE, TRUE, "", [[150, 100, 300], [1, 0, 0, 0]], [[0, 0, 0], [1, 0, 0, 0]]];

  ! ===== 点位（教学值） =====
  CONST robtarget pPickUp := [[0, 0, 180], [0, 0.7071, 0, 0.7071], [0, 0, 0, 0], [9E9, 9E9, 9E9, 9E9, 9E9, 9E9]];
  CONST robtarget pPick := [[0, 0, 60], [0, 0.7071, 0, 0.7071], [0, 0, 0, 0], [9E9, 9E9, 9E9, 9E9, 9E9, 9E9]];
  ! 三个箱子的放料点：A 箱在 X=0，B 箱在 X=150，C 箱在 X=300（教学值，按自己箱子位置改）
  CONST robtarget pBinA := [[0, 0, 80], [0, 0.7071, 0, 0.7071], [0, 0, 0, 0], [9E9, 9E9, 9E9, 9E9, 9E9, 9E9]];
  CONST robtarget pBinB := [[150, 0, 80], [0, 0.7071, 0, 0.7071], [0, 0, 0, 0], [9E9, 9E9, 9E9, 9E9, 9E9, 9E9]];
  CONST robtarget pBinC := [[300, 0, 80], [0, 0.7071, 0, 0.7071], [0, 0, 0, 0], [9E9, 9E9, 9E9, 9E9, 9E9, 9E9]];
  ! 废品箱在 Y=-150 那边（教学值）
  CONST robtarget pBinReject := [[0, -150, 80], [0, 0.7071, 0, 0.7071], [0, 0, 0, 0], [9E9, 9E9, 9E9, 9E9, 9E9, 9E9]];
  CONST robtarget pHome := [[100, 100, 500], [0, 0.7071, 0, 0.7071], [0, 0, 0, 0], [9E9, 9E9, 9E9, 9E9, 9E9, 9E9]];

  VAR num nCountA := 0;
  VAR num nCountB := 0;
  VAR num nCountC := 0;
  VAR num nCountReject := 0;

  PROC main()
    VAR num nType;
    SetDO doGrip, 0;
    MoveJ pHome, v1000, z50, tGripper;
    WHILE TRUE DO
      ! 等料到，读类型，取料，再按类型放
      WaitDI diPartReady, 1;
      nType := ReadType();
      PickPart;
      PlaceByType nType;
    ENDWHILE
  ENDPROC

  ! 读类型：两个信号拼出 1=A、2=B、3=C、0=认不出来
  FUNC num ReadType()
    WaitTime 0.2;
    IF DInput(diTypeA) = 1 AND DInput(diTypeB) = 0 THEN
      RETURN 1;
    ELSEIF DInput(diTypeA) = 0 AND DInput(diTypeB) = 1 THEN
      RETURN 2;
    ELSEIF DInput(diTypeA) = 0 AND DInput(diTypeB) = 0 THEN
      RETURN 3;
    ELSE
      RETURN 0;
    ENDIF
  ENDFUNC

  ! 取料：下降 -> 合爪 -> 抬起
  PROC PickPart()
    MoveJ pPickUp, v1000, z50, tGripper\WObj:=wobjConv;
    MoveL pPick, v200, fine, tGripper\WObj:=wobjConv;
    SetDO doGrip, 1;
    WaitTime 0.3;
    MoveL pPickUp, v500, z50, tGripper\WObj:=wobjConv;
  ENDPROC

  ! 按类型放料：TEST 分四路，认不出来的进废品箱
  PROC PlaceByType(num nType)
    VAR robtarget pBin;
    TEST nType
    CASE 1:
      pBin := pBinA;
      nCountA := nCountA + 1;
    CASE 2:
      pBin := pBinB;
      nCountB := nCountB + 1;
    CASE 3:
      pBin := pBinC;
      nCountC := nCountC + 1;
    DEFAULT:
      pBin := pBinReject;
      nCountReject := nCountReject + 1;
      TPWrite "认不出来的料，进废品箱";
    ENDTEST
    MoveJ Offs(pBin, 0, 0, 120), v1000, z50, tGripper\WObj:=wobjBin;
    MoveL pBin, v200, fine, tGripper\WObj:=wobjBin;
    SetDO doGrip, 0;
    WaitTime 0.3;
    MoveL Offs(pBin, 0, 0, 120), v500, z50, tGripper\WObj:=wobjBin;
  ENDPROC
ENDMODULE
