# Smart 组件做法 — Robot-RAPID

Smart 组件是 RobotStudio 里会自己动的零件：信号进来 → 逻辑跑 → 动作出去。传送带、夹爪、传感器、气缸都用它搭。

## 搭一个 Smart 组件的步骤（在 RobotStudio 6.08 里点）

1. **建组件**：建模 → Smart Component，新建一个，起个名字，比如 `Gripper_SC`。
2. **加信号**：组件属性里加输入输出信号。输入：`diClose`（夹紧命令）；输出：`doClosed`（夹紧到位）。
3. **加逻辑**：用 Logic Gate、Logic SRLatch、Timer 这些现成逻辑块连起来，别一上来就写代码。
4. **绑动作**：把逻辑输出绑到 Joint Mover、Linear Mover 或 Pose Mover 上，动作就有了。
5. **连机器人程序**：RAPID 里 `SetDO` 发信号，组件收到就动；组件的输出信号回给 RAPID，用 `WaitDI` 等它到位。
6. **仿真验证**：跑仿真，看组件动没动、时序对不对、会不会撞。

## 常用组合

| 要做的事 | 组件里用什么 |
|---|---|
| 夹爪开合 | 输入信号 + Linear Mover（两指对开） |
| 传送带送件 | Linear Mover + 传感器（到位信号） |
| 气缸顶升 | Joint Mover 或 Linear Mover + Timer（延时） |
| 按钮按了才动 | Logic Gate（与门：按钮 + 安全信号都满足才动） |
| 计数、翻转 | Expression、Logic SRLatch |

## 桥上怎么加 Smart 组件（Windows 本机）

- 桥有 `POST /station/add-component`，传 `.rslib` 文件路径（机器人或 Smart 组件的库文件）。
- 机器人库文件在 `C:\ProgramData\ABB\DistributionPackages2` 下面找。
- 只在虚拟控制器上操作，别碰真机。

## 注意事项

- 信号名和 RAPID 里的信号名必须对得上，一个字母都不能差。
- 组件动作先在仿真里看三遍：动没动、方向对不对、会不会撞。
- 复杂的逻辑先在纸上画出信号流再搭，别边搭边想。
- 虚拟控制器不能靠代码从 0 新建，系统要在 Installation Manager / System Builder 里建好再加载。
