! 03 IO 信号：SetDO / WaitDI / IF 判断
! doGrip：输出，1=合爪，0=松爪
! diPartPresent：输入，1=有料，0=无料
! diStart：输入，启动按钮

MODULE IOSignals
  CONST robtarget pWork := [[400, 0, 550], [0, 0.7071, 0, 0.7071], [0, 0, 0, 0], [9E9, 9E9, 9E9, 9E9, 9E9, 9E9]];

  PROC main()
    ! 等启动信号，超时 10 秒没来就报错停下
    WaitDI diStart, 1;
    ! 有料才做，没料就跳过并亮灯/报警（这里用 TPWrite 在示教器上提示）
    IF diPartPresent = 1 THEN
      MoveJ pWork, v500, fine, tool0;
      SetDO doGrip, 1;
      WaitTime 0.5;
      TPWrite "已夹取";
    ELSE
      TPWrite "无料，跳过本次";
    ENDIF
    ! 做完松爪，回到安全位
    SetDO doGrip, 0;
    MoveJ pWork, v500, z50, tool0;
  ENDPROC
ENDMODULE
