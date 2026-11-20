! 09 报错处理：ERROR 陷阱
! 思路：正常走，错了跳到 ERROR 段处理，不要让程序直接崩在工件中间
! 常见错：目标不可达、IO 超时、夹爪没夹到料

MODULE ErrorHandling
  VAR errnum errNoPart;
  CONST robtarget pPick := [[350, -150, 500], [0, 0.7071, 0, 0.7071], [0, 0, 0, 0], [9E9, 9E9, 9E9, 9E9, 9E9, 9E9]];

  PROC main()
    ! 试着搬一次，错了进 ERROR 段
    MoveJ pPick, v500, fine, tool0;
    SetDO doGrip, 1;
    WaitTime 0.3;
    ! 夹完检查有没有料，没料就主动报错
    IF diPartPresent = 0 THEN
      RAISE errNoPart;
    ENDIF
    TPWrite "搬运正常";
  ERROR
    ! 这里按错误号分开处理，教学版先统一提示
    TPWrite "出错了，检查料、点位、IO，再重试";
    SetDO doGrip, 0;
  ENDPROC
ENDMODULE
