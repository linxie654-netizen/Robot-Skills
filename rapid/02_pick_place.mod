! 02 搬运：取料 -> 搬运 -> 放料，带夹爪 IO
! 信号名要和你控制器里的 IO 配置对上，这里用 doGrip / diPartPresent 做例子
! 流程：到取料上方 -> 下降 -> 合爪 -> 等 0.3 秒 -> 抬起 -> 到放料上方 -> 下降 -> 松爪 -> 抬起

MODULE PickPlace
  CONST robtarget pPickUp := [[350, -150, 650], [0, 0.7071, 0, 0.7071], [0, 0, 0, 0], [9E9, 9E9, 9E9, 9E9, 9E9, 9E9]];
  CONST robtarget pPick := [[350, -150, 500], [0, 0.7071, 0, 0.7071], [0, 0, 0, 0], [9E9, 9E9, 9E9, 9E9, 9E9, 9E9]];
  CONST robtarget pPlaceUp := [[350, 150, 650], [0, 0.7071, 0, 0.7071], [0, 0, 0, 0], [9E9, 9E9, 9E9, 9E9, 9E9, 9E9]];
  CONST robtarget pPlace := [[350, 150, 500], [0, 0.7071, 0, 0.7071], [0, 0, 0, 0], [9E9, 9E9, 9E9, 9E9, 9E9, 9E9]];

  PROC main()
    ! 确保夹爪一开始是松开的
    SetDO doGrip, 0;
    ! 取料：先到上方，再直线下降
    MoveJ pPickUp, v1000, z50, tool0;
    MoveL pPick, v200, fine, tool0;
    ! 合爪，夹紧
    SetDO doGrip, 1;
    WaitTime 0.3;
    ! 抬起，搬运
    MoveL pPickUp, v500, z50, tool0;
    MoveJ pPlaceUp, v1000, z50, tool0;
    ! 放料：直线下降，松爪
    MoveL pPlace, v200, fine, tool0;
    SetDO doGrip, 0;
    WaitTime 0.3;
    MoveL pPlaceUp, v500, z50, tool0;
  ENDPROC
ENDMODULE
