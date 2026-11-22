! 有技能时按 skills/robot-rapid/SKILL.md 该给的搬运程序（纸面例子）
! 同一提示：“帮我写一段 RAPID，从 A 点取箱子放到 B 点。”
! 以 rapid/02_pick_place.mod 为底子，补上等料信号（带超时）、报错处理、回零。
! 点位是教学值，在仿真里重新示教。

MODULE WithSkillPickPlace
  CONST robtarget pPickUp := [[350, -150, 650], [0, 0.7071, 0, 0.7071], [0, 0, 0, 0], [9E9, 9E9, 9E9, 9E9, 9E9, 9E9]];
  CONST robtarget pPick := [[350, -150, 500], [0, 0.7071, 0, 0.7071], [0, 0, 0, 0], [9E9, 9E9, 9E9, 9E9, 9E9, 9E9]];
  CONST robtarget pPlaceUp := [[350, 150, 650], [0, 0.7071, 0, 0.7071], [0, 0, 0, 0], [9E9, 9E9, 9E9, 9E9, 9E9, 9E9]];
  CONST robtarget pPlace := [[350, 150, 500], [0, 0.7071, 0, 0.7071], [0, 0, 0, 0], [9E9, 9E9, 9E9, 9E9, 9E9, 9E9]];
  CONST jointtarget jHome := [[0, -20, 30, 0, 50, 0], [9E9, 9E9, 9E9, 9E9, 9E9, 9E9]];

  PROC main()
    VAR bool bTimeout;
    SetDO doGrip, 0;
    ! 有料才取，没料等 5 秒还不到就跳过这一次
    WaitDI diPartPresent, 1 \MaxTime:=5 \TimeFlag:=bTimeout;
    IF bTimeout THEN
      TPWrite "没料，跳过这一次";
      MoveAbsJ jHome, v1000, z50, tool0;
      RETURN;
    ENDIF;
    ! 取料：先到上方，再直线下降；靠近工件用 v200 + fine
    MoveJ pPickUp, v1000, z50, tool0;
    MoveL pPick, v200, fine, tool0;
    SetDO doGrip, 1;
    WaitTime 0.3;
    ! 抬起，空跑用 v1000 + z50
    MoveL pPickUp, v500, z50, tool0;
    MoveJ pPlaceUp, v1000, z50, tool0;
    ! 放料：直线下降，松爪
    MoveL pPlace, v200, fine, tool0;
    SetDO doGrip, 0;
    WaitTime 0.3;
    MoveL pPlaceUp, v500, z50, tool0;
    MoveAbsJ jHome, v1000, z50, tool0;
  ERROR
    ! 出错先松爪、回零，别让机器人停在半空抓着工件；处理完程序结束，不自动重试
    TPWrite "出错了，检查料、点位、IO，再重试";
    SetDO doGrip, 0;
    MoveAbsJ jHome, v500, z50, tool0;
  ENDPROC
ENDMODULE
