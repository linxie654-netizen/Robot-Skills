! 焊接项目：一条直焊缝 + 一段圆弧焊缝，用 RobotWare Arc 的弧焊指令
! 点位均为教学值，在自己的工作站里重新示教。
! 需要控制器选项：RobotWare Arc（虚拟控制器里再加 Simulated Welder 模拟焊机）
! 指令写法按 ABB《Application manual - Arc and Arc Sensor》（3HAC050988-001）第 8 章：
!   ArcLStart ToPoint, Speed, Seam, Weld [\Weave], Zone, Tool [\WObj];
!   ArcL / ArcLEnd 参数相同；ArcC / ArcCEnd 多一个圆弧中间点 CirPoint
! 流程：回安全点 -> 飞行起弧走到起焊点 -> 沿直缝焊 -> 圆弧段焊并收弧 -> 抬枪 -> 回安全点

MODULE Welding
  ! ===== 工具和工件坐标系（教学值，量自己的再改） =====
  ! tTorch：TCP 在焊丝尖端，工具 Z 轴和焊枪平行（手册要求）
  TASK PERS tooldata tTorch := [TRUE, [[0, 0, 200], [1, 0, 0, 0]], [1.0, [0, 0, 100], [1, 0, 0, 0], 0, 0, 0]];
  ! wobjPart：原点在焊缝起点那一端
  TASK PERS wobjdata wobjPart := [FALSE, TRUE, "", [[400, 0, 350], [1, 0, 0, 0]], [[0, 0, 0], [1, 0, 0, 0]]];

  ! ===== 焊接数据（教学值） =====
  ! seamdata：起弧、收弧阶段（送气、引弧、填弧坑、回烧、后送气）
  ! 结构：purge_time, preflow_time, ign_arc, ign_move_delay, scrape_start,
  !       heat_speed, heat_time, heat_distance, heat_arc, cool_time,
  !       fill_time, fill_arc, bback_time, rback_time, bback_arc, postflow_time
  ! arcdata 9 个数：sched, mode, voltage, wirefeed, control, current, voltage2, wirefeed2, control2
  ! 省事的做法：在 RobotStudio 程序数据窗口新建 seamdata，系统按焊机配置填好默认值再改
  PERS seamdata seam1 := [0.5, 0.5, [0, 0, 22, 120, 0, 0, 0, 0, 0], 0.2, 0, 0, 0, 0, [0, 0, 0, 0, 0, 0, 0, 0, 0], 0, 0.5, [0, 0, 18, 80, 0, 0, 0, 0, 0], 0.1, 0, [0, 0, 0, 0, 0, 0, 0, 0, 0], 0.5];
  ! welddata：焊接阶段。结构：weld_speed, org_weld_speed, main_arc, org_arc
  ! 焊速 10 mm/s，电压 24 V，送丝 150
  PERS welddata weld1 := [10, 0, [0, 0, 24, 150, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0]];
  ! weavedata：摆动（选用，不摆就去掉 \Weave）。结构 15 个数：weave_shape, weave_type,
  !   weave_length, weave_width, weave_height, dwell_left, dwell_center, dwell_right,
  !   weave_dir, weave_tilt, weave_ori, weave_bias, org_weave_width, org_weave_height, org_weave_bias
  ! weave_shape 1 = 之字摆，周期长 4 mm、摆宽 3 mm（摆动频率最高 2 Hz）
  PERS weavedata weave1 := [1, 0, 4, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];

  ! ===== 点位（教学值，在 wobjPart 里） =====
  CONST robtarget pApproach := [[0, 0, 80], [0, 0.7071, 0, 0.7071], [0, 0, 0, 0], [9E9, 9E9, 9E9, 9E9, 9E9, 9E9]];
  CONST robtarget pWeldStart := [[0, 0, 0], [0, 0.7071, 0, 0.7071], [0, 0, 0, 0], [9E9, 9E9, 9E9, 9E9, 9E9, 9E9]];
  CONST robtarget pWeldMid := [[100, 0, 0], [0, 0.7071, 0, 0.7071], [0, 0, 0, 0], [9E9, 9E9, 9E9, 9E9, 9E9, 9E9]];
  CONST robtarget pArcStart := [[200, 0, 0], [0, 0.7071, 0, 0.7071], [0, 0, 0, 0], [9E9, 9E9, 9E9, 9E9, 9E9, 9E9]];
  CONST robtarget pArcCir := [[250, 50, 0], [0, 0.7071, 0, 0.7071], [0, 0, 0, 0], [9E9, 9E9, 9E9, 9E9, 9E9, 9E9]];
  CONST robtarget pWeldEnd := [[200, 100, 0], [0, 0.7071, 0, 0.7071], [0, 0, 0, 0], [9E9, 9E9, 9E9, 9E9, 9E9, 9E9]];
  CONST robtarget pDepart := [[200, 100, 80], [0, 0.7071, 0, 0.7071], [0, 0, 0, 0], [9E9, 9E9, 9E9, 9E9, 9E9, 9E9]];
  CONST robtarget pHome := [[100, 100, 500], [0, 0.7071, 0, 0.7071], [0, 0, 0, 0], [9E9, 9E9, 9E9, 9E9, 9E9, 9E9]];

  VAR num nRetry := 0;

  PROC main()
    MoveJ pHome, v1000, z50, tTorch;
    WHILE TRUE DO
      ! 等夹具夹紧信号，没工件不焊
      WaitDI diPartReady, 1;
      nRetry := 0;
      WeldSeam;
      TPWrite "Seam done";
      WaitDI diPartReady, 0;
    ENDWHILE
  ENDPROC

  ! 焊一条缝：直线段 -> 圆弧段并收弧
  PROC WeldSeam()
    MoveJ pApproach, v500, z20, tTorch\WObj:=wobjPart;
    ! 飞行起弧：走向 pWeldStart 的路上提前送气，到点起弧（起弧点自动按 fine 处理）
    ArcLStart pWeldStart, v100, seam1, weld1\Weave:=weave1, fine, tTorch\WObj:=wobjPart;
    ! 起弧、收弧点之外都用 z10 这类过渡点（手册建议）
    ArcL pWeldMid, v100, seam1, weld1\Weave:=weave1, z10, tTorch\WObj:=wobjPart;
    ArcL pArcStart, v100, seam1, weld1\Weave:=weave1, z10, tTorch\WObj:=wobjPart;
    ! 圆弧段：经过 pArcCir 到 pWeldEnd，到点收弧（填弧坑、回烧、后送气按 seam1）
    ArcCEnd pArcCir, pWeldEnd, v100, seam1, weld1\Weave:=weave1, fine, tTorch\WObj:=wobjPart;
    MoveL pDepart, v500, z20, tTorch\WObj:=wobjPart;
    MoveJ pHome, v1000, z50, tTorch;
  ERROR
    ! 引弧失败、焊接中断弧（这两种手册写明可自动重试）：最多重试 2 次，再失败就停下报给操作员
    IF (ERRNO = AW_IGNI_ERR OR ERRNO = AW_WELD_ERR) AND nRetry < 2 THEN
      nRetry := nRetry + 1;
      TPWrite "Arc error, retry "\Num:=nRetry;
      RETRY;
    ELSE
      TPWrite "Weld error: check torch, gas, wire";
      RAISE;
    ENDIF
  ENDPROC
ENDMODULE
