! 01 基础移动：MoveJ / MoveL / MoveAbsJ
! 教学例程，点位是示意值，仿真里要重新示教
! MoveJ：关节插补，走得快，路径不直，适合空跑
! MoveL：直线插补，路径直，适合靠近工件、焊接、涂胶
! MoveAbsJ：直接给 J1-J6 角度，适合回零、换姿态

MODULE MoveBasics
  ! 目标点：位置 [x,y,z] + 姿态四元数 + 机器人姿态 + 外轴
  CONST robtarget pHome := [[400, 0, 600], [0, 0.7071, 0, 0.7071], [0, 0, 0, 0], [9E9, 9E9, 9E9, 9E9, 9E9, 9E9]];
  CONST robtarget pA := [[400, -200, 500], [0, 0.7071, 0, 0.7071], [0, 0, 0, 0], [9E9, 9E9, 9E9, 9E9, 9E9, 9E9]];
  CONST robtarget pB := [[400, 200, 500], [0, 0.7071, 0, 0.7071], [0, 0, 0, 0], [9E9, 9E9, 9E9, 9E9, 9E9, 9E9]];

  ! 关节目标：J1-J6 角度（度），外轴 9E9 表示不用
  CONST jointtarget jHome := [[0, -30, 30, 0, 60, 0], [9E9, 9E9, 9E9, 9E9, 9E9, 9E9]];

  PROC main()
    ! 先回关节零位姿态
    MoveAbsJ jHome, v1000, z50, tool0;
    ! 关节运动到 A 点附近，快，不要求直线
    MoveJ pA, v1000, z50, tool0;
    ! 直线运动到 B 点，fine 表示精确定位、停稳再走下一步
    MoveL pB, v500, fine, tool0;
    ! 直线回 A，再关节回 Home
    MoveL pA, v500, z50, tool0;
    MoveJ pHome, v1000, fine, tool0;
  ENDPROC
ENDMODULE
