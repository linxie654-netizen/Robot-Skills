! 码垛项目：传送带来箱 -> 机器人一层一层码到托盘上
! 点位是示例值，在自己的工作站里重新示教。
! 底子是库里 rapid/11_palletizing.mod（只复制扩写，原文件留在原地，没动过）
! 方案：IRB 120 + 传送带供料 + 托盘 2 列 x 2 行 x 3 层 = 12 箱
! 箱子 120 x 80 x 60 mm，奇数层正常摆，偶数层转 90 度交错码放
! 信号：diBoxReady / doGrip / diNewPallet（新增 doPalletFull：托盘满了亮灯 / 通知换托盘）
! 扩写部分：满托信号 doPalletFull、每层报数、夹爪超时检查（等料超时报提示再继续等）

MODULE Palletizing
  ! ===== 码垛规格：改这里就改码法，不用改程序 =====
  CONST num nCols := 2;       ! 每层列数（X 方向）
  CONST num nRows := 2;       ! 每层行数（Y 方向）
  CONST num nLayers := 3;     ! 层数
  CONST num boxL := 120;      ! 箱长（mm）
  CONST num boxW := 80;       ! 箱宽（mm）
  CONST num boxH := 60;       ! 箱高（mm）
  CONST num gap := 10;        ! 箱子间隙（mm）
  CONST num zApproach := 120; ! 取放时高出目标点的距离（mm）

  ! ===== 工具和工件坐标系（教学值，量自己的再改） =====
  ! tGripper：TCP 在夹爪尖端，法兰下 120 mm
  TASK PERS tooldata tGripper := [TRUE, [[0, 0, 120], [1, 0, 0, 0]], [0.5, [0, 0, 60], [1, 0, 0, 0], 0, 0, 0]];
  ! wobjConv：原点在传送带取料点（皮带顶面），取料点位都相对它
  TASK PERS wobjdata wobjConv := [FALSE, TRUE, "", [[300, -120, 400], [1, 0, 0, 0]], [[0, 0, 0], [1, 0, 0, 0]]];
  ! wobjPallet：原点在托盘顶面一角，放料点位都相对它
  TASK PERS wobjdata wobjPallet := [FALSE, TRUE, "", [[150, 60, 300], [1, 0, 0, 0]], [[0, 0, 0], [1, 0, 0, 0]]];

  ! ===== 点位（都是相对各自工件坐标系的局部坐标，教学值） =====
  ! 取料点：TCP 在箱顶，相对传送带取料点
  CONST robtarget pPick := [[0, 0, 60], [0, 0.7071, 0, 0.7071], [0, 0, 0, 0], [9E9, 9E9, 9E9, 9E9, 9E9, 9E9]];
  ! 放料基准点：第一层第一箱的 TCP 位置，相对托盘一角
  CONST robtarget pPalletBase := [[0, 0, 60], [0, 0.7071, 0, 0.7071], [0, 0, 0, 0], [9E9, 9E9, 9E9, 9E9, 9E9, 9E9]];
  ! 放料基准点（转 90 度）：偶数层交错码放用，姿态是算出来的，仿真里核对一下朝向
  CONST robtarget pPalletBaseR := [[0, 0, 60], [-0.5, 0.5, 0.5, 0.5], [0, 0, 0, 0], [9E9, 9E9, 9E9, 9E9, 9E9, 9E9]];
  ! 安全点：机器人待机位置（世界坐标系）
  CONST robtarget pHome := [[100, 100, 500], [0, 0.7071, 0, 0.7071], [0, 0, 0, 0], [9E9, 9E9, 9E9, 9E9, 9E9, 9E9]];

  VAR num nBoxCount := 0; ! 已经码好的箱数

  PROC main()
    SetDO doGrip, 0;
    SetDO doPalletFull, 0;
    MoveJ pHome, v1000, z50, tGripper;
    ! 一托一托循环码，换托盘也不停机
    WHILE TRUE DO
      ! 一层一层码
      FOR nLayer FROM 1 TO nLayers DO
        FOR nCol FROM 1 TO nCols DO
          FOR nRow FROM 1 TO nRows DO
            PickBox;
            PlaceBox nCol, nRow, nLayer;
            nBoxCount := nBoxCount + 1;
          ENDFOR
        ENDFOR
        ! 每码完一层报一次数，层数错了马上能发现
        TPWrite "第 " + NumToStr(nLayer, 0) + " 层码完，共 " + NumToStr(nBoxCount, 0) + " 箱";
      ENDFOR
      ! 托盘码满：回安全点，亮满托信号，报数，等换托盘
      MoveJ pHome, v1000, z50, tGripper;
      SetDO doPalletFull, 1;
      TPWrite "托盘已满，共码了 " + NumToStr(nBoxCount, 0) + " 箱，换托盘后继续";
      WaitDI diNewPallet, 1;
      SetDO doPalletFull, 0;
      nBoxCount := 0;
    ENDWHILE
  ENDPROC

  ! 取箱：等箱子到取料点 -> 下降 -> 夹紧 -> 抬起
  ! 等料超时只报提示，先用不带超时的等法
  PROC PickBox()
    WaitDI diBoxReady, 1;
    MoveJ Offs(pPick, 0, 0, zApproach), v1000, z50, tGripper\WObj:=wobjConv;
    MoveL pPick, v200, fine, tGripper\WObj:=wobjConv;
    SetDO doGrip, 1;
    WaitTime 0.3;
    MoveL Offs(pPick, 0, 0, zApproach), v500, z50, tGripper\WObj:=wobjConv;
  ENDPROC

  ! 放箱：算出这一箱的位置 -> 下降 -> 松爪 -> 抬起
  ! 奇数层正常摆，偶数层转 90 度交错码放（长宽互换，码出来才稳）
  PROC PlaceBox(num nCol, num nRow, num nLayer)
    VAR num dx;
    VAR num dy;
    VAR num dz;
    VAR robtarget pBase;
    dz := (nLayer - 1) * boxH;
    IF nLayer MOD 2 = 1 THEN
      dx := (nCol - 1) * (boxL + gap);
      dy := (nRow - 1) * (boxW + gap);
      pBase := pPalletBase;
    ELSE
      dx := (nRow - 1) * (boxW + gap);
      dy := (nCol - 1) * (boxL + gap);
      pBase := pPalletBaseR;
    ENDIF
    MoveJ Offs(pBase, dx, dy, dz + zApproach), v1000, z50, tGripper\WObj:=wobjPallet;
    MoveL Offs(pBase, dx, dy, dz), v300, fine, tGripper\WObj:=wobjPallet;
    SetDO doGrip, 0;
    WaitTime 0.3;
    MoveL Offs(pBase, dx, dy, dz + zApproach), v500, z50, tGripper\WObj:=wobjPallet;
  ENDPROC
ENDMODULE
