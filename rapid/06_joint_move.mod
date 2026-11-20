! 06 J1-J6 关节运动：MoveAbsJ + jointtarget
! J1：底座旋转，左右摆
! J2：大臂前后摆
! J3：小臂前后摆
! J4：腕部旋转
! J5：腕部摆动
! J6：法兰旋转
! 关节运动不怕奇异点，适合回零、换姿态、躲障碍

MODULE JointMove
  ! 每个 jointtarget 是 [J1, J2, J3, J4, J5, J6]，单位度
  CONST jointtarget jZero := [[0, 0, 0, 0, 0, 0], [9E9, 9E9, 9E9, 9E9, 9E9, 9E9]];
  CONST jointtarget jPoseA := [[30, -20, 40, 0, 50, 0], [9E9, 9E9, 9E9, 9E9, 9E9, 9E9]];
  CONST jointtarget jPoseB := [[-30, -20, 40, 0, 50, 90], [9E9, 9E9, 9E9, 9E9, 9E9, 9E9]];

  PROC main()
    ! 回零
    MoveAbsJ jZero, v500, fine, tool0;
    ! 只转 J1 和 J6，看单轴怎么动
    MoveAbsJ jPoseA, v500, fine, tool0;
    MoveAbsJ jPoseB, v500, fine, tool0;
    ! 回零
    MoveAbsJ jZero, v500, fine, tool0;
  ENDPROC
ENDMODULE
