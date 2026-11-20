! 04 循环和判断：FOR / WHILE / IF，计数搬运
! 例：搬 5 个工件，每搬一个计数加 1，搬完提示

MODULE LoopsConditions
  VAR num nCount;

  CONST robtarget pPick := [[350, -150, 500], [0, 0.7071, 0, 0.7071], [0, 0, 0, 0], [9E9, 9E9, 9E9, 9E9, 9E9, 9E9]];
  CONST robtarget pPlace := [[350, 150, 500], [0, 0.7071, 0, 0.7071], [0, 0, 0, 0], [9E9, 9E9, 9E9, 9E9, 9E9, 9E9]];

  PROC main()
    nCount := 0;
    ! FOR 循环搬 5 次
    FOR i FROM 1 TO 5 DO
      MoveJ pPick, v1000, z50, tool0;
      SetDO doGrip, 1;
      WaitTime 0.3;
      MoveJ pPlace, v1000, z50, tool0;
      SetDO doGrip, 0;
      WaitTime 0.3;
      nCount := nCount + 1;
    ENDFOR
    TPWrite "搬运完成，共 " + NumToStr(nCount, 0) + " 个";
    ! WHILE 例子：有料就一直搬，没料就停（实际用要加超时和急停判断）
    ! WHILE diPartPresent = 1 DO
    !   MoveJ pPick, v500, fine, tool0;
    !   SetDO doGrip, 1;
    ! ENDWHILE
  ENDPROC
ENDMODULE
