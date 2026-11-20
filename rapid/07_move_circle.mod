! 07 圆弧运动：MoveC
! MoveC 圆弧点, 终点, 速度, 区域, 工具;
! 圆弧点是圆弧中间经过的点，终点是圆弧结束的点
! 适合：画圆、圆弧焊接、圆弧涂胶

MODULE MoveCircle
  CONST robtarget pStart := [[400, -200, 500], [0, 0.7071, 0, 0.7071], [0, 0, 0, 0], [9E9, 9E9, 9E9, 9E9, 9E9, 9E9]];
  CONST robtarget pMid := [[400, 0, 500], [0, 0.7071, 0, 0.7071], [0, 0, 0, 0], [9E9, 9E9, 9E9, 9E9, 9E9, 9E9]];
  CONST robtarget pEnd := [[400, 200, 500], [0, 0.7071, 0, 0.7071], [0, 0, 0, 0], [9E9, 9E9, 9E9, 9E9, 9E9, 9E9]];

  PROC main()
    ! 先直线到起点
    MoveL pStart, v500, fine, tool0;
    ! 圆弧经 pMid 到 pEnd，速度放慢，精确定位
    MoveC pMid, pEnd, v200, fine, tool0;
    ! 直线回去
    MoveL pStart, v500, fine, tool0;
  ENDPROC
ENDMODULE
