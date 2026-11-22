! 焊接项目：沿一条直焊缝走焊枪，干跑轨迹 + 焊接输出
! 1. 需要弧焊选项（比如 ArcWare），没这个选项焊枪指令编不过
! 2. 点位是示例值，在自己的工作站里重新示教。
! 3. 下面只用 MoveL + SetDO 写“干跑 + 开关焊输出”的骨架，
!    弧焊专用的起弧 / 收弧指令名这里不编、不写，用之前先查弧焊手册
! 4. 开焊之前，先在仿真里干跑轨迹（焊输出关掉），确认轨迹、角度、碰撞都没问题
! 流程：回安全点 -> 走到起焊点 -> 开保护气 -> 开焊 -> 沿焊缝走 -> 关焊 -> 关气 -> 回安全点

MODULE Welding
  ! ===== 工具和工件坐标系（教学值，量自己的再改） =====
  ! tTorch：TCP 在焊丝尖端，焊枪姿态按自己焊枪标定后再改
  TASK PERS tooldata tTorch := [TRUE, [[0, 0, 200], [1, 0, 0, 0]], [1.0, [0, 0, 100], [1, 0, 0, 0], 0, 0, 0]];
  ! wobjPart：原点在工件焊缝起点那一端
  TASK PERS wobjdata wobjPart := [FALSE, TRUE, "", [[400, 0, 350], [1, 0, 0, 0]], [[0, 0, 0], [1, 0, 0, 0]]];

  ! ===== 点位（教学值） =====
  ! 焊缝从 X=0 走到 X=200（教学值，按自己工件改）
  CONST robtarget pWeldStartUp := [[0, 0, 100], [0, 0.7071, 0, 0.7071], [0, 0, 0, 0], [9E9, 9E9, 9E9, 9E9, 9E9, 9E9]];
  CONST robtarget pWeldStart := [[0, 0, 0], [0, 0.7071, 0, 0.7071], [0, 0, 0, 0], [9E9, 9E9, 9E9, 9E9, 9E9, 9E9]];
  CONST robtarget pWeldMid := [[100, 0, 0], [0, 0.7071, 0, 0.7071], [0, 0, 0, 0], [9E9, 9E9, 9E9, 9E9, 9E9, 9E9]];
  CONST robtarget pWeldEnd := [[200, 0, 0], [0, 0.7071, 0, 0.7071], [0, 0, 0, 0], [9E9, 9E9, 9E9, 9E9, 9E9, 9E9]];
  CONST robtarget pWeldEndUp := [[200, 0, 100], [0, 0.7071, 0, 0.7071], [0, 0, 0, 0], [9E9, 9E9, 9E9, 9E9, 9E9, 9E9]];
  CONST robtarget pHome := [[100, 100, 500], [0, 0.7071, 0, 0.7071], [0, 0, 0, 0], [9E9, 9E9, 9E9, 9E9, 9E9, 9E9]];

  PROC main()
    ! 一开始焊输出全关，别一上电就出弧
    SetDO doWeldOn, 0;
    SetDO doGasOn, 0;
    MoveJ pHome, v1000, z50, tTorch;
    WHILE TRUE DO
      ! 等工件就位（夹具夹紧信号），没工件不焊
      WaitDI diPartReady, 1;
      WeldOneSeam;
      TPWrite "一条焊缝走完，等下一件";
      WaitDI diPartReady, 0;
    ENDWHILE
  ENDPROC

  ! 焊一条缝：走到起焊点 -> 开气 -> 开焊 -> 沿缝走 -> 关焊 -> 关气 -> 抬起
  ! 起弧要不要提前送气、收弧要不要填弧坑、焊完要不要等冷却，
  ! 参数先按最保守的写，开焊按弧焊手册调
  PROC WeldOneSeam()
    MoveJ pWeldStartUp, v500, z50, tTorch\WObj:=wobjPart;
    MoveL pWeldStart, v200, fine, tTorch\WObj:=wobjPart;
    ! 开保护气，等一会儿再开焊（时间是教学值）
    SetDO doGasOn, 1;
    WaitTime 0.5;
    SetDO doWeldOn, 1;
    WaitTime 0.3;
    ! 沿焊缝走：速度先用 v100（教学值），跑顺了再按弧焊手册调
    MoveL pWeldMid, v100, fine, tTorch\WObj:=wobjPart;
    MoveL pWeldEnd, v100, fine, tTorch\WObj:=wobjPart;
    ! 关焊，再关气，抬枪
    SetDO doWeldOn, 0;
    WaitTime 0.3;
    SetDO doGasOn, 0;
    MoveL pWeldEndUp, v500, z50, tTorch\WObj:=wobjPart;
    MoveJ pHome, v1000, z50, tTorch;
  ENDPROC
ENDMODULE
