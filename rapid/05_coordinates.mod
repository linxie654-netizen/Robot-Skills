! 05 坐标系：工具 tooldata / 工件 wobjdata
! 关键概念：
! - tool0：机器人法兰默认工具，TCP 在法兰中心
! - 自定义工具：TCP 要标定，tframe 是工具相对法兰的位姿
! - wobj0：世界坐标系，机器人底座
! - 自定义工件：wobj 的 uframe 是工件相对世界的位姿，换工件位置只改 wobj，不用改每个点
! - MoveL 的最后一个参数 \WObj 可以指定工件，不写默认 wobj0

MODULE Coordinates
  ! 工具：夹爪，TCP 在法兰前方 120mm，重量 1kg，重心 [0,0,60]
  PERS tooldata tGripper := [TRUE, [[0, 0, 120], [1, 0, 0, 0]], [1, [0, 0, 60], [1, 0, 0, 0], 0, 0, 0]];
  ! 工件：工作台，相对世界平移 [500, 0, 0]，不旋转
  PERS wobjdata wTable := [FALSE, TRUE, "", [[500, 0, 0], [1, 0, 0, 0]], [[0, 0, 0], [1, 0, 0, 0]]];

  ! 这个点是相对工件坐标系的，工件一动，点跟着动
  CONST robtarget pOnTable := [[0, -100, 100], [0, 0.7071, 0, 0.7071], [0, 0, 0, 0], [9E9, 9E9, 9E9, 9E9, 9E9, 9E9]];

  PROC main()
    ! 用自定义工具 + 自定义工件走
    MoveJ pOnTable, v500, fine, tGripper \WObj := wTable;
    WaitTime 0.5;
    ! 用默认工具 + 世界坐标走
    MoveJ pOnTable, v500, fine, tool0 \WObj := wobj0;
  ENDPROC
ENDMODULE
