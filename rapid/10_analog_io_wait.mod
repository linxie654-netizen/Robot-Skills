! 10 模拟量 IO + WaitUntil 等条件
! SetDO / WaitDI 是数字量，只有 0/1
! SetAO / WaitAI 是模拟量，比如调速、调压力、读温度
! WaitUntil 是等一个条件成立，比 WaitDI 更灵活

MODULE AnalogIOWait
  CONST robtarget pPick := [[350, -150, 500], [0, 0.7071, 0, 0.7071], [0, 0, 0, 0], [9E9, 9E9, 9E9, 9E9, 9E9, 9E9]];

  PROC main()
    ! 等启动按钮，并且有料，两个条件都满足才走
    WaitUntil diStart = 1 AND diPartPresent = 1;
    TPWrite "启动 + 有料，开始";
    ! 模拟量输出：把速度信号设到 50%，对应 AO 值按你系统标定
    SetAO aoSpeed, 5;
    MoveJ pPick, v500, fine, tool0;
    ! 等模拟量输入超过阈值，比如压力到了
    WaitUntil aiPressure > 3;
    TPWrite "压力到了，夹紧";
    SetDO doGrip, 1;
    WaitTime 0.3;
  ENDPROC
ENDMODULE
