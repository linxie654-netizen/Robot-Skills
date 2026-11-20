# RAPID 速查表

## 移动
| 指令 | 意思 | 什么时候用 |
|---|---|---|
| `MoveJ p, v1000, z50, tool0;` | 关节插补到点 | 空跑、换姿态，快 |
| `MoveL p, v500, fine, tool0;` | 直线插补到点 | 靠近工件、焊接、涂胶 |
| `MoveC p1, p2, v500, z10, tool0;` | 圆弧经 p1 到 p2 | 画圆、圆弧轨迹 |
| `MoveAbsJ j, v1000, fine, tool0;` | 直接给 J1-J6 角度 | 回零、换姿态、躲奇异点 |

## 速度和区域
- 速度：`v5, v10, v50, v100, v500, v1000, v2000, vmax`，数字是 mm/s。
- 区域：`fine` = 精确定位停稳；`z50` = 50mm 圆角不停；`z100` 更圆滑更快。
- 新手：靠近工件用 `v200 + fine`，空跑用 `v1000 + z50`。

## 数据类型
- `robtarget`：笛卡尔目标点，位置 + 姿态 + 机器人姿态 + 外轴。
- `jointtarget`：关节目标，J1-J6 角度 + 外轴。
- `tooldata`：工具，TCP + 重量 + 重心。
- `wobjdata`：工件坐标系。
- `speeddata` / `zonedata`：速度 / 区域。
- `num` / `bool` / `string`：数字 / 真假 / 文字。

## IO 和流程
- `SetDO doGrip, 1;` 输出置 1；`SetDO doGrip, 0;` 置 0。
- `WaitDI diStart, 1;` 等输入变 1。
- `WaitTime 0.5;` 等 0.5 秒。
- `IF ... THEN ... ELSE ... ENDIF`
- `FOR i FROM 1 TO 5 DO ... ENDFOR`
- `WHILE ... DO ... ENDWHILE`
- `TPWrite "提示文字";` 在示教器上显示。

## 坐标系
- `wobj0`：世界坐标，机器人底座。
- `tool0`：法兰默认工具。
- 换工具要标 TCP，换工件位置改 `wobj`，不要重示教每个点。

## J1-J6
- J1 底座旋转，J2 大臂，J3 小臂，J4 腕转，J5 腕摆，J6 法兰转。
- 关节角超限、目标不可达、奇异点，先看这三项。
