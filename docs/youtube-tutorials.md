# YouTube ABB RobotStudio 新手教程总目录

更新：2026-11-20（第二阶段）。学习方法：每个视频先找字幕/文字稿/作者文字版，按步骤拆解；视频本身无法逐帧播放观看，就用字幕 + 关键段落 + 作者文字版系统学，**不谎称看过没看的部分**。没核实的写“未核实”，不编标题、时长和链接。

状态说明：✅ 已学完（按文字版/字幕系统学过）｜⚠️ 部分学完/部分核实｜📋 只列目录（待学）。

## 一、第一批：已学完（第一阶段，学深写细）

### H1 ✅ ABB RobotStudio Tutorial 1: Jogging, Manipulate Views, and Motion Modes

- 作者：Aleksandar Haber PhD
- 链接：https://www.youtube.com/watch?v=Yg6RY-cGw54
- 文字版：https://aleksandarhaber.com/abb-robotstudio-tutorial-1-jogging-manipulate-views-and-motion-modes-linear-axis-and-reorient/
- 时长：未核实
- 讲什么（文字版列出的 7 点）：
  1. 视图导航和旋转
  2. 激活机器人运行模式
  3. FlexPendant 激活
  4. 机器人点动
  5. 线性运动模式
  6. 轴运动模式
  7. 重定向运动模式
- 对应新手课：L2（建站、点动 J1–J6）、L4（示教点）
- 库里对应：`rapid/06_joint_move.mod`（J1–J6）、`robotstudio/tutorial.md`
- 对比：库里已有。视频多讲了一步：先激活运行模式、激活 FlexPendant 再点动，新手容易跳过这步。

### H2 ✅ How to Move and Jog an ABB Robot Using FlexPendant

- 作者：Aleksandar Haber PhD
- 链接：https://www.youtube.com/watch?v=rClc2d2RUZw
- 文字版：https://aleksandarhaber.com/how-to-move-and-jog-an-abb-robot-using-flexpendant-teach-pendant-abb-robotics-tutorial/
- 时长：未核实
- 讲什么：三种点动模式——
  1. 轴（关节）模式：每个关节单独转
  2. 线性模式：工具点沿 X/Y/Z 直线走
  3. 重定向模式：工具点固定不动，机器人绕着它转
- 对应新手课：L2、L4
- 库里对应：`rapid/06_joint_move.mod`、`docs/beginner-roadmap.md` L2
- 对比：库里已有。视频的讲法更适合新手：三种模式先分清再动手，别一上来就混着用。

### H4 ✅ How to Correctly Define and Create Workobject Frames and Coordinate Systems

- 作者：Aleksandar Haber PhD
- 链接：https://www.youtube.com/watch?v=5fdcGGy9IzI
- 文字版：https://aleksandarhaber.com/21779-2/
- 时长：未核实
- 讲什么：
  - 在 RobotStudio 里建一个盒子的 3D 模型，调尺寸
  - 用三点法正确定义工件坐标系（workobject frame）：工件坐标系是用户自定义的坐标系，通常跟工件几何对齐
- 对应新手课：L9（坐标系）
- 库里对应：`rapid/05_coordinates.mod`（wobjdata 概念）
- 对比：**库里缺**。库里只讲了 wobjdata 是什么，没讲三点法具体怎么点（原点、X 方向、Y 方向三个点怎么取）。学法草稿在 `docs/youtube-study/drafts/workobject-three-point.md`。

### P1 ✅ ABB RobotStudio - Industrial Palletizing Robot - Sorting and Pick&Place Tutorial

- 作者：Maurilio Patino
- 链接：https://youtu.be/y0FjnO8AysQ
- 文字版（全文已读）：https://mpatino-digital-garden.vercel.app/robotics-notes/industrial-robots-courses/abb/my-notes/abb-robot-studio-industrial-palletizing-robot-sorting-and-pick-and-place-tutorial-by-maurilio-patino/
- 时长：未核实
- 目标：用 RobotStudio 选一台 ABB 机器人装吸盘夹爪，传送带上出现 3 个小橙箱（20×20×10 cm）和 3 个大绿箱（20×20×20 cm），机器人按大小分拣、码放到两侧托盘；按 ISO 10218 加安全措施。
- 4 个部分：
  - **Part 1 – 真空夹爪 Smart 组件**：导 .SAT 的 CAD 做夹爪；在 TCP 处放 Line Sensor；数字输入 DI 控制 Attach/Detach。关键数：工具底座到 TCP 的距离量出来是 184 mm；工具重心用 Snap Gravity 取；夹爪存成 `.rslib` 库复用。
  - **Part 2 – 传送带 Smart 组件**：导 950×4000 传送带；皮带用 Box 做；大小箱子各一个；箱子本地原点移到顶部（不然开物理后箱子会穿透皮带）；皮带 Physics Behavior 设 Fixed，Surface Velocity 沿 +X 方向；Smart 组件里挂两个 Source（大小箱各一）、PhysicsControl、两个 Line Sensor（下传感器 X 偏移 −60 mm、Y +50 mm 到小箱中部高度；上传感器 X 同样 −60 mm、Y +150 mm 只碰大箱）、Logic Gate；I/O Simulator 里按按钮出箱、跑仿真验证皮带遇箱停；保存仿真初始状态 “Simulation Start”。
  - **Part 3 – 取放 + 工件 + 信号**：建 3 个工件坐标系（传送带一个、大小托盘各一个）；机器人控制器起名 “Pick and Place”，建系统时开 motion events；主程序加 `while true` 循环不让仿真自己停；Home 点、取放轨迹、过渡点；同步到 RAPID；数字 IO 接传感器、造箱、真空；写 Pick and Place 两个程序 + Create Box 程序（FOR 循环先造 3 个小箱再造 3 个大箱，中间加延时）；主逻辑用 IF 判断：只有下传感器亮 → 走小箱轨迹，两个传感器都亮 → 走大箱轨迹；路径加偏移实现叠放。
  - **Part 4 – 安全（ISO 10218、QuickStop、World Zones）**：按 ISO 10218:2011 讲标准；导围栏、急停按钮、状态指示塔、Omron 光幕（.SAT）；新建信号 `StopRobotEmergency`（DI）+ 恢复信号；System Inputs 里把启动连到 Run 按钮、新建 QuickStop 信号；模拟有人进单元：触发急停信号机器人停住，手动恢复；World Zone：定义 1 m × 4 m × 2 m 的四面体禁区（红色半透明，放单元后部），RAPID 里写 `MyPowerOn` 程序定义禁区、挂到 PowerOn 事件上，TCP 一进禁区就报警停机。
- 对应新手课：L9（坐标系）、L10（IO）、L12（完整搬运）、L14（安全）
- 库里对应：`rapid/02_pick_place.mod`、`rapid/03_io_signals.mod`、`rapid/04_loops_conditions.mod`、`skill/robot-rapid/references/smart-components.md`
- 对比：**库里缺下面 5 样**（已写成草稿，见 `docs/youtube-study/drafts/`）：
  1. 真空夹爪 Smart 组件完整做法（Line Sensor + Attacher/Detacher + DI 逻辑）
  2. 传送带物理仿真（Surface Velocity、Physics、Source、PhysicsControl）
  3. 叠放偏移 + 传感器分支分拣（IF 判断大小箱）
  4. 安全：QuickStop 信号 + World Zone 四面体 + PowerOn 事件
  5. 仿真初始状态保存（“Simulation Start”）

### A1 ✅ RobotStudio® Tutorial – Modify Controller with RW7（ABB 官方）

- 作者：ABB Robotics（官方频道）
- 链接：https://www.youtube.com/watch?v=YNbxRRvjXW8
- 上传：2024-02-27
- 时长：未核实
- 讲什么：导机器人仿真模型、Add-ins 标签页、Modify Installation 功能（改控制器安装）。
- 对应新手课：L2 进阶（虚拟控制器选项）
- 库里对应：无
- 对比：**库里缺**。库里没讲虚拟控制器建好后怎么改安装选项（加 RobotWare 选项、改系统）。

### C1–C4 ✅ CMU Future CNC 官方 4 步教程

- 来源：卡内基梅隆大学 Future CNC，http://futurecnc.code.arc.cmu.edu/tutorials/robotstudio/
- 讲什么（官网列出的 4 个官方视频）：
  - Step 1 – 建站、RobotStudio 里导航（1:34）
  - Step 2 – 机器人点动、建目标和路径（3:48，无声）
  - Step 3 – 导工具并装上、导几何并摆放（2:33，无声）
  - Step 4 – 建第一个程序（3:05，无声）
- 官网还给了 10 步建第一个程序和 10 步加工具的文字步骤（Home 选 Paths & Targets → Jog Joint 拖关节 → Teach Target → 建 Path → 拖目标进路径 → 同步到虚拟控制器 → Simulation 里加进主序列；加工具：Modeling 导几何 → Create Tool → 选已导入的几何 → 定 TCP → 拖到机器人上）。
- 对应新手课：L2、L4、L9
- 库里对应：`robotstudio/tutorial.md`、`docs/full-pipeline.md`
- 对比：库里已有，CMU 的版本更短、更适合第一天跟着做。注意：CMU 页面给的下载还是 RobotStudio 5.13 学校版，版本很老，步骤通用，界面以你装的版本为准。

## 二、第二批：已学完（第二阶段）

### H3 ✅ ABB Robot Tutorial: Defining Tool Frames and Basic Modeling in ABB RobotStudio

- 作者：Aleksandar Haber PhD
- 链接：https://www.youtube.com/watch?v=k0ddlUXXHto
- 文字版：https://aleksandarhaber.com/abb-robot-tutorial-defining-tool-frames-and-basic-modeling-in-abb-robotstudio/（标题已核实；文字版只有两行——“讲怎么定义工具坐标系、做基础建模”，细节靠下面交叉材料补）
- 时长：未核实
- 讲什么：定义工具坐标系 + 在 RobotStudio 里做基础建模。
- 交叉材料（补充，非视频原文）：
  - ITAR《Hands-on with ABB Robots》（ardavan.io）：FlexPendant 上定义工具有三种方法——TCP（4 点，默认方向）、TCP + Z 方向、TCP + Z 和 X 方向；没定义工具时默认 tool0，TCP 在法兰中心。
  - CMU《10 步加工具》：Modeling 导几何 → Create Tool → Use Existing 选几何 → 填 TCP 位置姿态 → 拖到机器人上（弹窗点 No 让它自动摆正）。
- 对应新手课：L9（坐标系）
- 库里对应：`rapid/05_coordinates.mod`（tooldata 概念）
- 对比：**库里缺具体操作**。三种方法什么时候用、Create Tool 向导每一步点什么，库里原来没有。草稿在 `docs/youtube-study/drafts/tool-frames-definition.md`。

### R4 ✅ Learn to Code ABB Robots to Perform Pick and Place Tasks using Rapid Programming

- 作者：Ryan Bliss
- 链接：未核实（视频 ID 没找到，只核实了标题、作者、时长）
- 时长：19 分钟（多处来源一致）
- 讲什么（章节表，多处来源一致）：Intro → Overview → Define Work Objects → New Work Object → Three Point Method → Origin → Jogging → Modify Position → Modify Position Again → Test Work Object → Create Palette B → Define Points → Tool Object → Defining Point → Safety Point → Program Editor → Code Walkthrough → Apply Code → Debug。
- 要点：工件、点位、工具、安全点全部先在示教里定好，最后才进程序编辑器写代码、走读、应用、调试。顺序别反。
- 配套文字材料（control.com《ABB Robot Example Programming Tutorial》，机器人编程系列第 2 篇，2022-03-01，2024-01-08 更新；作者未核实——是同主题文字教程，不是视频逐字稿）：传送带取件 → 旋转分度盘放件（IRB 1600）；PLC 发程序号（`giCommand` 组输入 + `SetGo goCmdEcho` 回执 + `diExe` 执行标志），`WHILE diExe = 0` 等执行标志；`TEST nCmd` / `CASE` 按号分发，非法号报 `TPWrite "Invalid Program"`；Pounce 点（离工装远、离活区近的中间点）+ `Offs()` 接近、最后一段慢速直线 `fine` 下到取件点；每次关键动作后查夹爪故障位，有故障就报错返回；只做计算的模块设 No Step；World Zone 挂 PowerOn 事件、用 `WZDOSet` 告诉 PLC 机器人在哪。
- 对应新手课：L8、L12
- 库里对应：`rapid/02_pick_place.mod`、`rapid/08_test_case_functions.mod`
- 对比：**库里缺**：PLC 程序号调度（gi/go 回执 + 执行标志）、Pounce 点 + Offs 接近、夹爪故障处理、No Step 模块。草稿在 `docs/youtube-study/drafts/pick-place-plc-program-numbers.md`。

### R3 ✅ Easy to Understand ABB Robot Coding Tutorial (Pick and Place in Rapid Programming Language)

- 作者/频道：controlengineering
- 链接：未核实（视频 ID 没找到）
- 时长：**有争议**——两处来源说 37 分钟，一处来源说 20 分钟（标题略有不同，叫“Pick and Place Tasks”）。可能是同一教程的两个版本/剪辑，哪个是原版未核实。
- 讲什么（关键词，多处来源一致）：Tool Frame、Three Point Method、Linear Motion、Work Objects、Set the Work Object、Programming Robot Studio、Tool Data、Data Type、Work Object Data、Pick and Place Procedure、Program Editor。
- 对应新手课：L8、L12
- 库里对应：`rapid/02_pick_place.mod`
- 对比：库里已有取放例程；这个视频的价值是“从工具坐标系、三点法、直线运动一路讲到完整取放流程”，适合当 L8+L12 的串讲。时长争议记在这里，别硬定 37 分钟。

### R6 ✅ Learning RAPID Basics | Programming In RAPID ABB Robots | Robotic Systems

- 作者/频道：Robotic Systems
- 链接：未核实（视频 ID 没找到）
- 时长：7 分 52 秒（多处来源一致）
- 讲什么（章节表）：Intro → Program Structure in RAPID → General Rules → Basic Data Types → Variables and Constants → Operators → Procedures and Functions → Builtin Functions → Flow Control → Interrupts。
- 说明：这视频是系列课的入门篇，7 分钟只讲概念、不写完整程序。
- 对应新手课：L5
- 库里对应：`rapid/04_loops_conditions.mod`、`docs/cheatsheet.md`
- 对比：库里已有，视频是 7 分钟浓缩版，适合新手先看一遍再对照 cheatsheet。

### R7 ✅ Motion Instructions | Programming in RAPID ABB Robots | Robotic Systems

- 作者/频道：Robotic Systems
- 链接：未核实（视频 ID 没找到）
- 时长：7 分 06 秒（多处来源一致）
- 讲什么（简介已核实）：“讲 RAPID 里怎么用 MoveAbsJ、MoveJ、MoveL、MoveC 这几个运动指令”。
- 交叉核对：ABB《RAPID 概览》手册（RobotWare 6.08 版，3HAC050947-001 Rev H）§1.8 有同一张指令表：MoveC 圆弧、MoveJ 关节运动、MoveL 直线、MoveAbsJ 绝对关节运动、MoveExtJ 外轴。
- 对应新手课：L6
- 库里对应：`rapid/01_move_basics.mod`、`rapid/06_joint_move.mod`、`rapid/07_move_circle.mod`
- 对比：库里已有，视频是 7 分钟浓缩版，四个指令一次讲清，适合配合 01/06/07 例程看。

### R8 ✅ ABB Tutorial - Multiple Work Objects

- 作者：Mr. Domer
- 链接：未核实（视频 ID 没找到）
- 时长：30 分钟（多处来源一致）
- 讲什么（简介已核实）：“半小时视频，Domer 老师给学生演示工件怎么用、好在哪”。
- 要点：同一个程序，换个工位、换个托盘不用重示教——点位挂在工件下，工件一挪整组点跟着走；位置变了只改工件，不改程序。
- 对应新手课：L9
- 库里对应：`rapid/05_coordinates.mod`、Patino Part 3（3 个工件实战）
- 对比：**库里缺“为什么用多个工件”这个讲法**。库里只讲了 wobjdata 是什么，没讲复用思路。草稿在 `docs/youtube-study/drafts/multiple-workobjects.md`。注意：忘了写 `\WObj`，点位默认挂 wobj0，工件挪了点位不动，会走到错的地方。

### R5 ✅ Introduction to ABB Robot Coding - Write a Simple Code for Moving and Closing the Gripper

- 作者/频道：controlengineering（标签 abbrobotics / controlengineering）
- 链接：未核实（视频 ID 没找到）
- 时长：14 分 16 秒（多处来源一致）
- 讲什么（章节表）：Introduction → Getting Started → Defining Points → Writing the Code → Running the Code。
- 解说词片段：松开使能按钮、推摇杆、直线模式下动机器人、保持工具姿态、按工件坐标系 XYZ 动、对齐工具与工件——讲的是 FlexPendant 点动 + 写第一段“移动 + 合夹爪”代码。
- 对应新手课：L3、L12
- 库里对应：`rapid/02_pick_place.mod`
- 对比：库里已有。这是“第一段代码”最短路径：定义点 → 写代码 → 跑起来，新手先跑通这个再学完整取放。

### C5 ✅ Creating Single Robot System in ABB Robotstudio

- 作者/频道：cnctrain
- 文章：https://cnctrain.com/blogs/post/creating-single-robot-system-in-abb-robotstudio（2024-04-04）
- 链接：https://www.youtube.com/watch?v=TDjzO5AMOmk
- 时长：未核实
- 讲什么：
  - 机器人系统 = 一台独立机器人 + 自己的控制器 + 自己的 I/O 系统；本教程用 IRC5。
  - Home → Robot System，三种加系统的方法：基于已有布局创建（视频演示这种，布局里 IRC5 已加好）、创建新系统并加到工作站、加一个已有的系统。
  - 加完系统配 I/O：Controller 标签页 → Configuration Editor，看和改系统参数（Communication、I/O 系统）；配出来的信号名就是程序里 `SetDO` / `WaitDI` 用的名字。
- 对应新手课：L2
- 库里对应：`docs/full-pipeline.md`（从头建系统）
- 对比：**库里缺“从已有布局建”这条路 + 建完去 Configuration Editor 配 I/O 这一步**。草稿在 `docs/youtube-study/drafts/create-system-from-layout.md`。

### A2 ✅ RobotStudio® Tutorial – Visualize World Zones（ABB 官方）

- 作者：ABB Robotics（官方频道）
- 链接：https://www.youtube.com/watch?v=E0bhSQN46Os
- 时长：未核实
- 讲什么（内容靠 ABB 官方发布说明核实）：`WZBoxDef` / `WZCylDef` / `WZSphDef` 定义的 World Zone 直接在工作站里画成半透明形状；工作站和虚拟控制器之间同步；形状能改颜色、能隐藏；用 Instruction 选择级别可以在 3D 图里直接点中指令。
- 两个硬条件：定义体积时必须用数字字面量（写成 `CONST pos` 变量就不显示）；关节坐标系的 Zone（`WZLimJointDef`、`WZHomeJointDef`）还不支持可视化。
- **可视化做法（通用，三种都行）**：工作站里直接显示定义好的 Zone；或用 WorldZones Add-in（Add-ins → Install Packages 装 `WorldZones-2.0.rspak`，GitHub parasuramsarathi/ABB-WorldZones），带 Visualize Zones 和 Robot Position Viewer；或手工画盒子（透明度约 60%）+ 建碰撞集，机器人碰到 Zone 就报警。
- 对应新手课：L14（安全）
- 库里对应：无（Zone 写法见草稿 `safety-world-zones.md`）
- 对比：**库里缺可视化做法**。Zone 本身的写法（`WZSphDef` / `WZBoxDef` / `WZDOSet`、挂 PowerOn 事件）通用，不分版本。草稿在 `docs/youtube-study/drafts/world-zones-visualization.md`。

### E1 ✅ ABB Robot Programming with RobotStudio and RAPID（免费课，EDWartens）

- 来源：EDWartens，https://edwartens.co.uk/free/abb-robotstudio-rapid
- 规模：16 模块、60 课、约 17 小时视频；免费学，证书 £19 自选；最后更新 2026-10-28。
- 16 模块大纲（官网已核实）：
  1. RobotStudio: Getting Started（6 课）
  2. Navigating and Jogging in the Station（3 课，Lab）
  3. The FlexPendant（3 课，Lab）
  4. Tool and Work-Object Frames（4 课，Lab）
  5. Grippers and End Effectors（3 课）
  6. Paths and Targets（4 课，Lab）
  7. RAPID: Introduction（2 课）
  8. Pick and Place in RAPID（4 课，Lab）
  9. Collision Avoidance and Checking（5 课）
  10. Signals, Events and the Signal Analyzer（2 课）
  11. Physics, Mechanisms and Cables（4 课）
  12. Sharing Stations and Add-Ins（5 课）
  13. RobotStudio Cloud（8 课）
  14. Kinematics Background（2 课）
  15. Recording, Envelopes and AR（4 课）
  16. Final Assessment（1 课）
- 视频来源：ABB Robotics 官方教程 + Aleksandar Haber；学习计划、笔记、测验、期末考是 EDWartens 写的。
- 浏览器里也能练：EDWartens Lab（免费，不用装软件），ROB-02 点动、ROB-03 示教运行、ROB-04 取放、ROB-05 码垛。
- 覆盖 IRC5 + OmniCore，RobotWare 6 和 7；RAPID 语言一样。
- 对应新手课：L1–L15（整条新手路线都能对上）
- 库里对应：`docs/beginner-roadmap.md`（12 课新手路线）
- 对比：**库里缺这几个模块的内容**：碰撞检查深入（模块 9）、Pack and Go 与 Add-ins（模块 12）、RobotStudio Cloud（模块 13）、录制/包络/AR（模块 15）、信号分析仪（模块 10）。只核实了大纲，这些模块要学深得看具体视频，列进待学。

## 三、部分学完

### R1 ⚠️ ABB ROBOT PROGRAMMING TUTORIAL PART 1

- 链接、作者：未核实
- 时长：4 小时 36 分（多处来源一致）
- 课程简介（已核实）：“这门课教：机器人、点动；基础程序结构；怎么创建、修改、保存、加载程序；用 ABB Flex（后半截被截断，应为 FlexPendant）……”
- 多版本情况（已核实有多个剪辑，是否为同一课未核实）：同名课程还有 2 小时 58 分版（R2）、1 小时 36 分版、4 小时 22 分版。学的时候先确认看的是哪个剪辑，别按错时长做计划。
- 状态：只核实了课程简介和版本情况，**未逐段拆解**。这课最长，下阶段分段学。

### R9 ⚠️ General Robot Studio Routines

- 链接、作者：未核实
- 时长：20 分钟
- 只有一句解说词片段：“还是手动加载……按播放，仿真在跑，重力是生效的……启动机器人”——讲的是仿真里重力生效、手动加载后启动。
- 状态：只有片段，不够算学完，**未逐段拆解**。

## 四、目录：待学（只核实了标题/链接/时长）

### RAPID 入门

| 编号 | 标题 | 作者/频道 | 链接 | 时长 | 对应新手课 | 库里对应 |
|---|---|---|---|---|---|---|
| R2 | ABB ROBOT PROGRAMMING TUTORIAL | 未核实 | 未核实 | 2 小时 58 分（简介与 R1 相同，是否为同一课的不同剪辑未核实） | L3–L12 | 全部例程 |
| R10 | ABB ROBOT PROGRAMMING PART 1 / PART 2 (PLAYLIST IN DESCRIPTION) | 未核实 | 未核实 | 5 分 37 秒 / 11 分 44 秒 | L1 | 未核实 |

### 建站与系统

| 编号 | 标题 | 作者/频道 | 链接 | 时长 | 对应新手课 | 库里对应 |
|---|---|---|---|---|---|---|
| H5 | Haber 作业 2 配套视频之二 | Aleksandar Haber PhD | https://www.youtube.com/watch?v=igJmGmmN7xo | 未核实 | 未核实 | 未核实 |
| H6 | Haber 作业 2 配套视频之三 | Aleksandar Haber PhD | https://www.youtube.com/watch?v=ng_R2LRGL8o | 未核实 | 未核实 | 未核实 |
| H7 | TCP 方向（Patino 笔记引用） | 未核实 | https://www.youtube.com/watch?v=vsSfa-enwgw | 未核实 | L9 | `rapid/05_coordinates.mod` |
| H8 | How to Easy Program ABB Robots to Follow a Path by Using RAPID Programming Language | Aleksandar Haber PhD | https://www.youtube.com/watch?v=zZXk-TW2iCE | 未核实 | L4、L6 | `rapid/01_move_basics.mod` |

- H5/H6 说明（第二阶段新核实）：这两个是 Haber《Homework Assignment 2》的配套视频，和 H1、H3 同批。作业内容：建一个旋转立方体、建一个圆锥末端执行器、装到机器人法兰上、定义工具坐标系、定义工件坐标系；做之前先看这 4 个视频。各自标题仍未核实。
- H8 说明（第二阶段新发现）：Haber 还有一个视频不在第一阶段目录里——导机器人模型、装末端执行器、点动到各点记下目标点、建路径、用 RAPID 写程序让机器人沿路径走。已补进目录。

### 课程包与播放清单

| 编号 | 标题 | 来源 | 链接 | 规模 | 对应新手课 |
|---|---|---|---|---|---|
| P2 | Patino 推荐播放清单（西班牙语） | Patino 笔记推荐 | https://youtube.com/playlist?list=PLVdvHpsfqw1bX194j7Slup6ri5se2668p | 标题未核实 | 待学 |
| P3 | Patino 推荐播放清单（西班牙语） | Patino 笔记推荐 | https://youtube.com/playlist?list=PLpyjNmi6BTHusr5sPuC7RiRZgZpHAPruR | 标题未核实 | 待学 |
| P4 | Patino 推荐播放清单（西班牙语） | Patino 笔记推荐 | https://youtube.com/playlist?list=PLkEmFyPTnhOmGDFKSvOlJuuxh4c4sVpTy | 标题未核实 | 待学 |
| P5 | Patino 推荐播放清单（英语） | Patino 笔记推荐 | https://youtube.com/playlist?list=PL2R1JB3M1MkSZiqPzbhG92LY6UbQRnNn5 | 标题未核实 | 待学 |
| P6 | Patino 推荐播放清单（英语） | Patino 笔记推荐 | https://youtube.com/playlist?list=PLE1CU6EebvTAA2FVjCcvMgkqXY8OtvDPd | 标题未核实 | 待学 |

**目录总计：32 条**（学完 19 条：第一阶段 9 条 H1、H2、H4、P1、A1、C1–C4，第二阶段 10 条 H3、R3–R8、C5、A2、E1；部分学完 2 条 R1、R9；待学 11 条 R2、R10、H5–H8、P2–P6；其中 H3、A2 在第一阶段只列目录、第二阶段学完；H8 是第二阶段新发现补进目录的）。

## 五、库里缺什么（两阶段结论）

第一阶段的 10 样：

1. 三点法定义工件坐标系的具体步骤（H4）→ 草稿 `drafts/workobject-three-point.md`
2. 工具标定完整步骤：TCP 量测、Create Tool 向导、重心 Snap Gravity（P1 Part 1）→ 草稿 `drafts/vacuum-gripper-smart-component.md`
3. 真空夹爪 Smart 组件：Line Sensor + Attacher/Detacher + DI 逻辑（P1 Part 1）→ 同上
4. 传送带物理仿真：Surface Velocity、Physics、Source、PhysicsControl（P1 Part 2）→ 草稿 `drafts/conveyor-physics.md`
5. 叠放偏移 + 传感器分支分拣（P1 Part 3）→ 草稿 `drafts/pick-place-offsets-sorting.md`
6. 安全：QuickStop 信号 + World Zone + PowerOn 事件（P1 Part 4、A2）→ 草稿 `drafts/safety-world-zones.md`
7. 虚拟控制器改安装选项（A1）→ 待学深
8. 从已有布局创建单机器人系统 + 配置 I/O（C5）→ 第二阶段已学，草稿 `drafts/create-system-from-layout.md`
9. 仿真初始状态保存（P1 Part 2）→ 已写进草稿 `drafts/conveyor-physics.md`
10. EDWartens 16 模块课程包的结构（E1）→ 第二阶段已学大纲，见上面 E1 一节

第二阶段新发现的缺口：

11. 工具坐标系定义三种方法（TCP 4 点 / TCP+Z / TCP+Z+X）+ Create Tool 向导步骤（H3）→ 草稿 `drafts/tool-frames-definition.md`
12. PLC 程序号调度（gi/go 回执 + 执行标志）+ Pounce 点 + Offs 接近 + 夹爪故障处理 + No Step 模块（R4）→ 草稿 `drafts/pick-place-plc-program-numbers.md`
13. 多个工件坐标系复用讲法：一个程序多处用，换工位只改工件不改程序（R8）→ 草稿 `drafts/multiple-workobjects.md`
14. World Zone 可视化做法：工作站里直接显示、WorldZones Add-in、手工画透明盒子 + 碰撞集（A2）→ 草稿 `drafts/world-zones-visualization.md`
15. EDWartens 模块里库里没有的内容：碰撞检查深入（模块 9）、Pack and Go 与 Add-ins（模块 12）、RobotStudio Cloud（模块 13）、录制/包络/AR（模块 15）、信号分析仪（模块 10）→ 待学深（只核实了大纲）
16. R1 多版本问题：4h36m / 2h58m / 1h36m / 4h22m 几个剪辑是否为同一课未核实 → 待核实
