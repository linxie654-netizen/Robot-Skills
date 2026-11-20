# 草稿：传送带物理仿真做法

来源：Maurilio Patino 码垛教程 Part 2（视频 https://youtu.be/y0FjnO8AysQ，文字版全文已读）。
状态：草稿，待在 RobotStudio 6.08 里照做一遍、跑通后再进 `skill/robot-rapid/references/`。
库里现状：库里没有传送带物理仿真的内容，`references/smart-components.md` 没讲 Physics。

## 目标

做一条会动的传送带：箱子从 Source 里出来、掉到皮带上、被皮带送到头、传感器一碰到箱子皮带就停。

## 步骤

1. **导传送带**：新工作站，Home → Import Library → Equipment，选传送带（Patino 用 950×4000），Set Position 放到中间。
2. **做皮带**：Modeling → Solid → Box，画一个当皮带，起名 Belt，放到传送带顶上。
3. **做箱子**：再画两个 Box，小箱 200×200×100（橙色）、大箱 200×200×200（绿色），放到传送带一头；大箱先隐藏。
4. **移箱子本地原点**：每个箱子用 Set Local Origin + Snap End，把本地坐标系移到箱子顶部。不移的话，开了物理后箱子会穿透皮带（Patino 原话的教训）。
5. **皮带加物理**：Physics → Behavior → Fixed；再用 Surface Velocity，打开速度、方向沿 +X。
6. **建 Smart 组件**：新建 Smart Component，起名如 `SC_Conveyor`，把箱子和传送带都拖进去。再挂这些子组件：
   - 两个 Source：一个造小箱、一个造大箱（开 Transient，箱子到头就删；开 dynamic transition，箱子带物理、会受重力掉下来）
   - 一个 PhysicsControl：管皮带启停
   - 两个 Line Sensor：下传感器 X 偏移 −60 mm、Y +50 mm（到小箱中部高度）；上传感器 X 同样 −60 mm、Y +150 mm（只碰大箱）
   - 一个 Logic Gate：连信号管皮带启停
7. **接 IO**：Design 窗口里建数字输入（造小箱、造大箱）和数字输出（上传感器、下传感器）。
8. **接线**：Source 由输入信号触发；传感器输出一亮，皮带经 PhysicsControl 停下。
9. **测试**：先把箱子隐藏，保存仿真初始状态，起名 “Simulation Start”；打开 I/O Simulator，点按钮出箱，点 Play 跑，看箱子掉下来、皮带送、传感器一碰就停；停下后 Reset 回初始状态。
10. **保存工作站**：验证没问题再保存整个站。

## 容易错的地方

- 箱子本地原点不移到顶部，箱子会穿透皮带。
- 上传感器高度要够（+150 mm），不然小箱也会触发它，分拣就乱了。
- 测试前先保存 “Simulation Start” 初始状态，不然每次改完都要重摆。

## 跟库里已有的关系

- 库里没有传送带和物理仿真，这是新的。学完后 `references/smart-components.md` 可以加一节“物理仿真”。
