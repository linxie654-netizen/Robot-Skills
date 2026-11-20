! 08 TEST/CASE 多路选择 + FUNC 函数返回值
! TEST 是多路选择，比一串 IF 更清楚
! FUNC 返回一个值，PROC 只做动作不返回值

MODULE TestCaseFunctions
  VAR num nMode;

  ! FUNC 例子：算两个数的和，返回 num
  FUNC num AddTwo(num a, num b)
    RETURN a + b;
  ENDFUNC

  ! FUNC 例子：判断有没有料，返回 bool
  FUNC bool HasPart()
    IF diPartPresent = 1 THEN
      RETURN TRUE;
    ELSE
      RETURN FALSE;
    ENDIF
  ENDFUNC

  PROC main()
    nMode := 2;
    ! 按模式走不同分支
    TEST nMode
      CASE 1:
        TPWrite "模式 1：单件搬运";
      CASE 2:
        TPWrite "模式 2：批量搬运";
      CASE 3:
        TPWrite "模式 3：回零";
      DEFAULT:
        TPWrite "未知模式，停下检查";
    ENDTEST
    ! 用 FUNC 的返回值
    IF HasPart() THEN
      TPWrite "有料，开始搬";
    ELSE
      TPWrite "无料";
    ENDIF
    TPWrite "1+2=" + NumToStr(AddTwo(1, 2), 0);
  ENDPROC
ENDMODULE
