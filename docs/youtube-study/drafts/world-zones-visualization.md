# World Zone 可视化做法（草稿）

来源：A2 ABB 官方《RobotStudio® Tutorial – Visualize World Zones》（视频链接已核实：https://www.youtube.com/watch?v=E0bhSQN46Os；内容靠 ABB 官方发布说明核实；时长未核实）。
状态：待在 RobotStudio 里照做一遍、跑通后再进正式文件。

## 1. 这功能是什么

- RAPID 里的 World Zone 定义指令（`WZBoxDef` / `WZCylDef` / `WZSphDef`）直接在工作站里画出来：半透明形状。
- 工作站和虚拟控制器之间同步；形状能改颜色、能隐藏；用 Instruction 选择级别可以在 3D 图里直接点中指令。

## 2. 两个硬条件

- 定义体积时必须用数字字面量，不能用 `CONST pos` 变量——写成变量就不显示（社区实测：`WZBoxDef\Outside, shp, [-330,-682,10], [1134,682,1060]` 能显示，`CONST pos A := [...]; WZBoxDef\Outside, shp, A, B;` 不显示）。
- 关节坐标系的 Zone（`WZLimJointDef`、`WZHomeJointDef`）还不支持可视化。

## 3. 三种可视化做法（通用，任选一种）

1. 工作站里直接显示：定义好的 Zone 在 3D 图里画成半透明形状。
2. WorldZones Add-in：Add-ins → Install Packages，装 `WorldZones-2.0.rspak`，重启 RobotStudio；Utilities 下有 Visualize Zones 和 Robot Position Viewer。来源：ABB 社区帖 + GitHub parasuramsarathi/ABB-WorldZones。
3. 手工画：Modeling 里建一个盒子当 Zone，透明度约 60%，再在 Simulation 里建碰撞集，机器人碰到 Zone 就报警（社区常用土办法）。

Zone 本身的写法（`WZSphDef` / `WZBoxDef` / `WZDOSet`、挂 PowerOn 事件）通用，见草稿 `safety-world-zones.md`。World Zone 是 RobotWare 的老选项（608-1），`WZBoxDef` 等指令在 RobotWare 5/6 的手册里就有，不是新功能。

## 4. 对应库里

- 草稿 `safety-world-zones.md`：Zone 写法与 QuickStop。
- 本草稿补的是可视化做法：三种方法任选一种，都能看见 Zone。
