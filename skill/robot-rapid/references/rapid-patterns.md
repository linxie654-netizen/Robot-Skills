# 常用 RAPID 模式 — Robot-RAPID

每个模式都对应库里一个例程，先抄例程，再改自己的点位和信号。点位都是教学值，在仿真里重新示教。

## 1. 基础移动：先回原点，再干活

对应 `rapid/01_move_basics.mod`。

```
MoveAbsJ jHome, v1000, z50, tool0;
MoveJ pApproach, v1000, z50, tool0;
MoveL pPick, v500, fine, tool0;
```

- `MoveAbsJ`：按 J1–J6 角度走，回原点、换姿态用它。
- `MoveJ`：关节插补，空跑、走大段路用它，快。
- `MoveL`：直线插补，靠近工件、抓放用它，准。
- `fine` 是停准，`z50` 及以上是拐弯不减速；抓放那一下用 `fine`。

## 2. 搬运：取料 → 搬 → 放料 → 夹爪

对应 `rapid/02_pick_place.mod`。

```
MoveJ pPickApproach, v1000, z50, tool0;
MoveL pPick, v500, fine, tool0;
SetDO doGrip, 1;
WaitTime 0.5;
MoveL pPickApproach, v500, z50, tool0;
```

- 夹爪是数字输出 `SetDO`，抓上等半秒再走，别一夹就抬。
- 放料是反过来：到位 → `SetDO doGrip, 0` → 等半秒 → 抬走。

## 3. 等信号再动：别用死等，用 WaitDI / WaitUntil

对应 `rapid/03_io_signals.mod`、`rapid/10_analog_io_wait.mod`。

```
WaitDI diPartReady, 1;
! 模拟量：等传感器值到了再动
WaitUntil aiForce > 5;
```

- 数字信号用 `WaitDI`，模拟量用 `WaitUntil`。
- 等不到就卡住，先查信号名对不对、传感器有没有来，再查程序。

## 4. 循环搬运：计数，别写死 10 遍

对应 `rapid/04_loops_conditions.mod`。

```
FOR nCount FROM 1 TO 10 DO
    ! 一次搬运动作
ENDFOR
```

- 次数会变就用变量，不写死；中途要停用 `IF` + `BREAK` 思想，先判断再跳出。

## 5. 坐标系：工具和工件分开管

对应 `rapid/05_coordinates.mod`。

- `tooldata` 是工具中心点和负载，换了夹具就重设工具。
- `wobjdata` 是工件坐标系，换了工件摆放位置就重设工件，别一个一个改点位。
- `robtarget` 是笛卡尔目标，`jointtarget` 是关节目标；点位变了先问“工具变了还是工件变了”，再决定重示教哪边。

## 6. 圆弧：MoveC 要两个点

对应 `rapid/07_move_circle.mod`。

```
MoveC pMid, pEnd, v500, z50, tool0;
```

- `MoveC` 要中间点 + 终点两个点，缺一个画不出弧。
- 大圆弧先仿真看轨迹。

## 7. 分支和函数：TEST/CASE + FUNC

对应 `rapid/08_test_case_functions.mod`。

```
TEST nMode
CASE 1:
    ! 模式 1 的动作
CASE 2:
    ! 模式 2 的动作
DEFAULT:
    ! 都不是，走这里
ENDTEST
```

- 多模式切换用 `TEST/CASE`，别写一串 `IF` 套 `IF`。
- 算东西用 `FUNC` 返回值，别把计算和动作混在一个 `PROC` 里。

## 8. 报错处理：ERROR 里写后路

对应 `rapid/09_error_handling.mod`。

```
ERROR
    IF ERRNO = ERR_SGNL THEN
        ! 信号丢了的处理：停住、报警、等信号回来
        RETRY;
    ENDIF
```

- 先想“错了怎么办”，再写正常流程；`RETRY` 是修好条件后重来，`RAISE` 是把错抛出去。
- 没写 `ERROR` 的程序，错一次就停在原地。

## 9. 关节运动：J1–J6 直接给角度

对应 `rapid/06_joint_move.mod`。

- `MoveAbsJ` 直接给六个关节角，适合回原点、换姿态、避开奇异点附近。
- 关节角超出限位会报不可达，先查限位和姿态。
