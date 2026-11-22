! 没技能时通常会给的搬运程序（纸面例子，按 evals.md 例 1 的“缺几步”写）
! 同一提示：“帮我写一段 RAPID，从 A 点取箱子放到 B 点。”
! 点位是教学值。

MODULE NoSkillPickPlace
  CONST robtarget pPick := [[350, -150, 500], [0, 0.7071, 0, 0.7071], [0, 0, 0, 0], [9E9, 9E9, 9E9, 9E9, 9E9, 9E9]];
  CONST robtarget pPlace := [[350, 150, 500], [0, 0.7071, 0, 0.7071], [0, 0, 0, 0], [9E9, 9E9, 9E9, 9E9, 9E9, 9E9]];

  PROC main()
    MoveJ pPick, v1000, fine, tool0;
    SetDO doGrip, 1;
    MoveJ pPlace, v1000, fine, tool0;
    SetDO doGrip, 0;
  ENDPROC
ENDMODULE
