# World Zone 可视化：2024.1 才有的功能，6.08 没有（草稿）

来源：A2 ABB 官方《RobotStudio® Tutorial – Visualize World Zones》（视频链接已核实：https://www.youtube.com/watch?v=E0bhSQN46Os；内容靠 RobotStudio 2024.1 发布说明核实；时长未核实）。
状态：待核对后再进正式文件——关键是版本差别，别在 6.08 里找这个功能。

## 1. 这功能是什么（RobotStudio 2024.1 新增）

- RAPID 里的 World Zone 定义指令（`WZBoxDef` / `WZCylDef` / `WZSphDef`）直接在工作站里画出来：半透明形状。
- 工作站和虚拟控制器之间同步；形状能改颜色、能隐藏；用 Instruction 选择级别可以在 3D 图里直接点中指令。

## 2. 两个硬条件

- 定义体积时必须用数字字面量，不能用 `CONST pos` 变量——写成变量就不显示（社区实测：`WZBoxDef\Outside, shp, [-330,-682,10], [1134,682,1060]` 能显示，`CONST pos A := [...]; WZBoxDef\Outside, shp, A, B;` 不显示）。
- 关节坐标系的 Zone（`WZLimJointDef`、`WZHomeJointDef`）还不支持可视化。
- 控制器要 RobotWare 6.x 或以上。

## 3. 6.08 里没有，别找了

- 6.08 没有内置的 World Zone 可视化。
- 6.08 的替代办法（二选一）：
  1. WorldZones Add-in（2.0 版，2022 年）：Add-ins → Install Packages，装 `WorldZones-2.0.rspak`，重启 RobotStudio；Utilities 下有 Visualize Zones 和 Robot Position Viewer。来源：ABB 社区帖 + GitHub parasuramsarathi/ABB-WorldZones。
  2. 手工画：Modeling 里建一个盒子当 Zone，透明度约 60%，再在 Simulation 里建碰撞集，机器人碰到 Zone 就报警（社区常用土办法）。
- Zone 本身的写法（`WZSphDef` / `WZBoxDef` / `WZDOSet`、挂 PowerOn 事件）不分版本，见草稿 `safety-world-zones.md`。

## 4. 对应库里

- 草稿 `safety-world-zones.md`：Zone 写法与 QuickStop。
- 本草稿补的是版本差别：A2 这个视频讲的是 2024.1 的新界面，6.08 用户照着点是点不到的，先知道这一点再学。
