# 取放程序：PLC 程序号调度 + Pounce 点（草稿）

来源：R4 Ryan Bliss《Learn to Code ABB Robots to Perform Pick and Place Tasks using Rapid Programming》（19 分钟，章节表已核实：定义工件 → 三点法 → 点动 → 改点位 → 测工件 → 建 Palette B → 定义点 → 工具 → 安全点 → 程序编辑器 → 代码走读 → 应用 → 调试）；写法细节见 control.com 同主题文字教程《ABB Robot Example Programming Tutorial》（机器人编程系列第 2 篇，2022-03-01，2024-01-08 更新，作者未核实——是文字配套材料，不是视频逐字稿）。
状态：待在 RobotStudio 6.08 里照做一遍、跑通后再进正式文件。

## 1. 视频的完整流程（R4 章节表）

定义工件 → 新建工件 → 三点法 → 原点 → 点动 → 改点位 → 再改点位 → 测工件 → 建 Palette B（托盘）→ 定义点 → 工具对象 → 定义点 → 安全点 → 程序编辑器 → 代码走读 → 应用代码 → 调试。

要点：工件、点位、工具、安全点全部先在示教里定好，最后才进程序编辑器写代码、走读、应用、调试。顺序别反。

## 2. PLC 发程序号，机器人按号执行（文字教程的写法）

- PLC 通过现场总线（Ethernet/IP、PROFINET、EtherCAT）发一个程序号。
- 机器人用组信号收：`giCommand`（组输入，多个离散信号拼成一个整数）；回执用 `SetGo goCmdEcho, nCmd` 把收到的号原样发回去，PLC 对上号才把执行标志 `diExe` 置 1。
- 主循环等执行标志：

```rapid
WHILE diExe = 0 DO
  nCmd := giCommand;
  SetGo goCmdEcho, nCmd;
ENDWHILE
```

也可以用 GOTO 写法：`LoopStart:` … `IF NOT(diExe) GOTO LoopStart;`。

## 3. 按号分发（TEST/CASE）

```rapid
TEST nCmd
CASE 1:
  FuncFirst();
CASE 2:
  FuncSecond();
DEFAULT:
  TPWrite "Invalid Program" \Num:=diExe;
ENDTEST
```

非法程序号要报出来，别静默跳过。库里 `rapid/08_test_case_functions.mod` 有 TEST/CASE 基础，这里补的是“号从 PLC 来”这一层。

## 4. Pounce 点 + Offs 接近

- Pounce 点：离工装足够远、离干活区足够近的中间点，先到它再进活区，省时间；示教时确认到 Pounce 点和 Home 点的路上没有任何物理阻挡。
- 从 Pounce 点用 `Offs()` 偏移到最终点：先高速到接近点，最后一段用慢速直线（`fine`）下到取件点，停稳再合夹爪，再原路退回 Pounce 点。
- 文字教程的取件片段（`mPickPallet`）：先 `CheckGripper\Empty` 查夹爪是空的 → 开夹爪 → 按零件类型 `GetPosition(\Pick)` 取点 → `MoveL Offs(..., -20, 0, 120)` 接近 → `MoveL Offs(..., -20, 0, -5)` 下探 → `MoveL pPallet_Pick, v500, fine` 到位 → `Gripper\Close`。

## 5. 故障处理别省

- 每次关键动作后查故障位（`dnFltPend1` / `dnFltPend2`），有故障就 `FaultMsg` → `SetCmdDone` → `RETURN`，别继续往下走。
- 取件失败要能恢复：先确认故障、打开夹爪、抬起来退回接近点和 Home 点，再报错。
- 干循环（没料试跑）要单独留开关（`bDryCycle`），别把无料报警和真故障混在一起。

## 6. No Step 模块

- 只做计算、不含运动的模块可以设成 No Step：示教器上不能单步进里面，代码必须先测好再用。
- 典型放这里的：`FUNC GetPosition(\switch Pick, \switch Place)`——按零件类型（`TEST nPartType`，CASE 1/2/3）返回不同的取件点，非法类型置故障位、发 `TPWrite "Wrong Part type"`。

## 7. World Zone 告诉 PLC 机器人在哪（挂 PowerOn 事件）

```rapid
PROC WorldZones()
  WZSphDef\Inside, shp wzHome, pHome.trans, 50;
  WZDOSet\Stat, wzHome\Inside, shp wzHome, doAtHome, 1;
  WZBoxDef\Outside, shp wzDial, poswzDialLow, poswzDialHigh;
  WZDOSet\Stat, wzClearDial\Inside, shp wzClearDial, doClearDial, 1;
ENDPROC
```

- 每个 Zone 要两个数据：`wzstationary`（允许的工作范围声明）+ `shapedata`（范围形状大小）。
- 三种形状：球、盒、圆柱；进 Zone 置输出为真，出范围可停机或反转信号。
- 好处：PLC 不用中断程序流就知道机器人在哪，还能用来恢复到已知安全点。
- 详细做法见草稿 `safety-world-zones.md`（Patino Part 4 + A2）。

## 8. 模块分工（文字教程的习惯）

- 主模块：PROC + 全局变量；tooldata、夹爪数据放这里；点位不放这里。
- 运动模块：所有运动 PROC；开头先回 Home/维修点、确认夹爪状态。
- 各模块职责分开，别把点位、逻辑、运动全塞一个模块。
