# YouTube ABB RobotStudio 新手教程总目录

更新：2026-11-20（第四阶段完成，32/32 全部学完，草稿 30 篇）。学习方法：每个视频配合字幕、文字稿、作者文字版和课程大纲，按步骤拆解；标题、时长、链接照原页面写。

状态说明：✅ 已学完｜⚠️ 片段教程。

## 一、第一批：已学完（第一阶段，学深写细）

### H1 ✅ ABB RobotStudio Tutorial 1: Jogging, Manipulate Views, and Motion Modes

- 作者：Aleksandar Haber PhD
- 链接：https://www.youtube.com/watch?v=Yg6RY-cGw54
- 文字版：https://aleksandarhaber.com/abb-robotstudio-tutorial-1-jogging-manipulate-views-and-motion-modes-linear-axis-and-reorient/
- 时长：9 分 51 秒
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
- 讲什么：
  - 在 RobotStudio 里建一个盒子的 3D 模型，调尺寸
  - 用三点法正确定义工件坐标系（workobject frame）：工件坐标系是用户自定义的坐标系，通常跟工件几何对齐
- 对应新手课：L9（坐标系）
- 库里对应：`rapid/05_coordinates.mod`（wobjdata 概念）
- 对比：**补进库里**：三点法具体怎么点（原点、X 方向、Y 方向三个点怎么取）。学法草稿在 `docs/youtube-study/drafts/workobject-three-point.md`。

### P1 ✅ ABB RobotStudio - Industrial Palletizing Robot - Sorting and Pick&Place Tutorial

- 作者：Maurilio Patino
- 链接：https://youtu.be/y0FjnO8AysQ
- 文字版（全文已读）：https://mpatino-digital-garden.vercel.app/robotics-notes/industrial-robots-courses/abb/my-notes/abb-robot-studio-industrial-palletizing-robot-sorting-and-pick-and-place-tutorial-by-maurilio-patino/
- 目标：用 RobotStudio 选一台 ABB 机器人装吸盘夹爪，传送带上出现 3 个小橙箱（20×20×10 cm）和 3 个大绿箱（20×20×20 cm），机器人按大小分拣、码放到两侧托盘；按 ISO 10218 加安全措施。
- 4 个部分：
  - **Part 1 – 真空夹爪 Smart 组件**：导 .SAT 的 CAD 做夹爪；在 TCP 处放 Line Sensor；数字输入 DI 控制 Attach/Detach。关键数：工具底座到 TCP 的距离量出来是 184 mm；工具重心用 Snap Gravity 取；夹爪存成 `.rslib` 库复用。
  - **Part 2 – 传送带 Smart 组件**：导 950×4000 传送带；皮带用 Box 做；大小箱子各一个；箱子本地原点移到顶部（不然开物理后箱子会穿透皮带）；皮带 Physics Behavior 设 Fixed，Surface Velocity 沿 +X 方向；Smart 组件里挂两个 Source（大小箱各一）、PhysicsControl、两个 Line Sensor（下传感器 X 偏移 −60 mm、Y +50 mm 到小箱中部高度；上传感器 X 同样 −60 mm、Y +150 mm 只碰大箱）、Logic Gate；I/O Simulator 里按按钮出箱、跑仿真验证皮带遇箱停；保存仿真初始状态 “Simulation Start”。
  - **Part 3 – 取放 + 工件 + 信号**：建 3 个工件坐标系（传送带一个、大小托盘各一个）；机器人控制器起名 “Pick and Place”，建系统时开 motion events；主程序加 `while true` 循环不让仿真自己停；Home 点、取放轨迹、过渡点；同步到 RAPID；数字 IO 接传感器、造箱、真空；写 Pick and Place 两个程序 + Create Box 程序（FOR 循环先造 3 个小箱再造 3 个大箱，中间加延时）；主逻辑用 IF 判断：只有下传感器亮 → 走小箱轨迹，两个传感器都亮 → 走大箱轨迹；路径加偏移实现叠放。
  - **Part 4 – 安全（ISO 10218、QuickStop、World Zones）**：按 ISO 10218:2011 讲标准；导围栏、急停按钮、状态指示塔、Omron 光幕（.SAT）；新建信号 `StopRobotEmergency`（DI）+ 恢复信号；System Inputs 里把启动连到 Run 按钮、新建 QuickStop 信号；模拟有人进单元：触发急停信号机器人停住，手动恢复；World Zone：定义 1 m × 4 m × 2 m 的四面体禁区（红色半透明，放单元后部），RAPID 里写 `MyPowerOn` 程序定义禁区、挂到 PowerOn 事件上，TCP 一进禁区就报警停机。
- 对应新手课：L9（坐标系）、L10（IO）、L12（完整搬运）、L14（安全）
- 库里对应：`rapid/02_pick_place.mod`、`rapid/03_io_signals.mod`、`rapid/04_loops_conditions.mod`、`skills/robot-rapid/references/smart-components.md`
- 对比：**补进库里下面 5 样**（已写成草稿，见 `docs/youtube-study/drafts/`）：
  1. 真空夹爪 Smart 组件完整做法（Line Sensor + Attacher/Detacher + DI 逻辑）
  2. 传送带物理仿真（Surface Velocity、Physics、Source、PhysicsControl）
  3. 叠放偏移 + 传感器分支分拣（IF 判断大小箱）
  4. 安全：QuickStop 信号 + World Zone 四面体 + PowerOn 事件
  5. 仿真初始状态保存（“Simulation Start”）

### A1 ✅ RobotStudio® Tutorial – Modify Controller with RW7（ABB 官方）

- 作者：ABB Robotics（官方频道）
- 链接：https://www.youtube.com/watch?v=YNbxRRvjXW8
- 上传：2024-02-27
- 讲什么：导机器人仿真模型、Add-ins 标签页、Modify Installation 功能（改控制器安装）。
- 对应新手课：L2 进阶（虚拟控制器选项）
- 库里对应：无
- 对比：**补进库里**：虚拟控制器建好后怎么改安装选项（加 RobotWare 选项、改系统），用在 `projects/welding/`、`projects/conveyor-tracking/`、`projects/multi-robot/` 的搭建步骤里。

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
- 讲什么：定义工具坐标系 + 在 RobotStudio 里做基础建模。
- 交叉材料（补充，非视频原文）：
  - ITAR《Hands-on with ABB Robots》（ardavan.io）：FlexPendant 上定义工具有三种方法——TCP（4 点，默认方向）、TCP + Z 方向、TCP + Z 和 X 方向；没定义工具时默认 tool0，TCP 在法兰中心。
  - CMU《10 步加工具》：Modeling 导几何 → Create Tool → Use Existing 选几何 → 填 TCP 位置姿态 → 拖到机器人上（弹窗点 No 让它自动摆正）。
- 对应新手课：L9（坐标系）
- 库里对应：`rapid/05_coordinates.mod`（tooldata 概念）
- 对比：**补进库里**：三种方法什么时候用、Create Tool 向导每一步点什么。草稿在 `docs/youtube-study/drafts/tool-frames-definition.md`。

### R4 ✅ Learn to Code ABB Robots to Perform Pick and Place Tasks using Rapid Programming

- 作者：Ryan Bliss
- 时长：19 分钟（多处来源一致）
- 讲什么（章节表，多处来源一致）：Intro → Overview → Define Work Objects → New Work Object → Three Point Method → Origin → Jogging → Modify Position → Modify Position Again → Test Work Object → Create Palette B → Define Points → Tool Object → Defining Point → Safety Point → Program Editor → Code Walkthrough → Apply Code → Debug。
- 要点：工件、点位、工具、安全点全部先在示教里定好，最后才进程序编辑器写代码、走读、应用、调试。顺序别反。
- 配套文字材料（control.com《ABB Robot Example Programming Tutorial》，机器人编程系列第 2 篇，2022-03-01，2024-01-08 更新；同主题文字教程）：传送带取件 → 旋转分度盘放件（IRB 1600）；PLC 发程序号（`giCommand` 组输入 + `SetGo goCmdEcho` 回执 + `diExe` 执行标志），`WHILE diExe = 0` 等执行标志；`TEST nCmd` / `CASE` 按号分发，非法号报 `TPWrite "Invalid Program"`；Pounce 点（离工装远、离活区近的中间点）+ `Offs()` 接近、最后一段慢速直线 `fine` 下到取件点；每次关键动作后查夹爪故障位，有故障就报错返回；只做计算的模块设 No Step；World Zone 挂 PowerOn 事件、用 `WZDOSet` 告诉 PLC 机器人在哪。
- 对应新手课：L8、L12
- 库里对应：`rapid/02_pick_place.mod`、`rapid/08_test_case_functions.mod`
- 对比：**补进库里**：PLC 程序号调度（gi/go 回执 + 执行标志）、Pounce 点 + Offs 接近、夹爪故障处理、No Step 模块。草稿在 `docs/youtube-study/drafts/pick-place-plc-program-numbers.md`。

### R3 ✅ Easy to Understand ABB Robot Coding Tutorial (Pick and Place in Rapid Programming Language)

- 作者/频道：controlengineering
- 时长：37 分钟。同一作者另有一版《Easy to Understand ABB Robot Coding Tutorial - Pick and Place Tasks》，20 分钟。
- 讲什么（关键词，多处来源一致）：Tool Frame、Three Point Method、Linear Motion、Work Objects、Set the Work Object、Programming Robot Studio、Tool Data、Data Type、Work Object Data、Pick and Place Procedure、Program Editor。
- 对应新手课：L8、L12
- 库里对应：`rapid/02_pick_place.mod`
- 对比：库里已有取放例程；这个视频的价值是“从工具坐标系、三点法、直线运动一路讲到完整取放流程”，适合当 L8+L12 的串讲。

### R6 ✅ Learning RAPID Basics | Programming In RAPID ABB Robots | Robotic Systems

- 作者/频道：Robotic Systems
- 时长：7 分 52 秒（多处来源一致）
- 讲什么（章节表）：Intro → Program Structure in RAPID → General Rules → Basic Data Types → Variables and Constants → Operators → Procedures and Functions → Builtin Functions → Flow Control → Interrupts。
- 说明：这视频是系列课的入门篇，7 分钟只讲概念、不写完整程序。
- 对应新手课：L5
- 库里对应：`rapid/04_loops_conditions.mod`、`docs/cheatsheet.md`
- 对比：库里已有，视频是 7 分钟浓缩版，适合新手先看一遍再对照 cheatsheet。

### R7 ✅ Motion Instructions | Programming in RAPID ABB Robots | Robotic Systems

- 作者/频道：Robotic Systems
- 时长：7 分 06 秒（多处来源一致）
- 讲什么（简介已核实）：“讲 RAPID 里怎么用 MoveAbsJ、MoveJ、MoveL、MoveC 这几个运动指令”。
- 交叉核对：ABB《RAPID 概览》手册（RobotWare RobotStudio 版，3HAC050947-001 Rev H）§1.8 有同一张指令表：MoveC 圆弧、MoveJ 关节运动、MoveL 直线、MoveAbsJ 绝对关节运动、MoveExtJ 外轴。
- 对应新手课：L6
- 库里对应：`rapid/01_move_basics.mod`、`rapid/06_joint_move.mod`、`rapid/07_move_circle.mod`
- 对比：库里已有，视频是 7 分钟浓缩版，四个指令一次讲清，适合配合 01/06/07 例程看。

### R8 ✅ ABB Tutorial - Multiple Work Objects

- 作者：Mr. Domer
- 时长：30 分钟（多处来源一致）
- 讲什么（简介已核实）：“半小时视频，Domer 老师给学生演示工件怎么用、好在哪”。
- 要点：同一个程序，换个工位、换个托盘不用重示教——点位挂在工件下，工件一挪整组点跟着走；位置变了只改工件，不改程序。
- 对应新手课：L9
- 库里对应：`rapid/05_coordinates.mod`、Patino Part 3（3 个工件实战）
- 对比：**补进库里**：“为什么用多个工件”的复用思路。草稿在 `docs/youtube-study/drafts/multiple-workobjects.md`。注意：忘了写 `\WObj`，点位默认挂 wobj0，工件挪了点位不动，会走到错的地方。

### R5 ✅ Introduction to ABB Robot Coding - Write a Simple Code for Moving and Closing the Gripper

- 作者/频道：controlengineering（标签 abbrobotics / controlengineering）
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
- 讲什么：
  - 机器人系统 = 一台独立机器人 + 自己的控制器 + 自己的 I/O 系统；本教程用 IRC5。
  - Home → Robot System，三种加系统的方法：基于已有布局创建（视频演示这种，布局里 IRC5 已加好）、创建新系统并加到工作站、加一个已有的系统。
  - 加完系统配 I/O：Controller 标签页 → Configuration Editor，看和改系统参数（Communication、I/O 系统）；配出来的信号名就是程序里 `SetDO` / `WaitDI` 用的名字。
- 对应新手课：L2
- 库里对应：`docs/full-pipeline.md`（从头建系统）
- 对比：**补进库里：“从已有布局建”这条路 + 建完去 Configuration Editor 配 I/O 这一步**。草稿在 `docs/youtube-study/drafts/create-system-from-layout.md`。

### A2 ✅ RobotStudio® Tutorial – Visualize World Zones（ABB 官方）

- 作者：ABB Robotics（官方频道）
- 链接：https://www.youtube.com/watch?v=E0bhSQN46Os
- 讲什么（内容靠 ABB 官方发布说明核实）：`WZBoxDef` / `WZCylDef` / `WZSphDef` 定义的 World Zone 直接在工作站里画成半透明形状；工作站和虚拟控制器之间同步；形状能改颜色、能隐藏；用 Instruction 选择级别可以在 3D 图里直接点中指令。
- 两个硬条件：定义体积时必须用数字字面量（写成 `CONST pos` 变量就不显示）；关节坐标系的 Zone（`WZLimJointDef`、`WZHomeJointDef`）还不支持可视化。
- **可视化做法（通用，三种都行）**：工作站里直接显示定义好的 Zone；或用 WorldZones Add-in（Add-ins → Install Packages 装 `WorldZones-2.0.rspak`，GitHub parasuramsarathi/ABB-WorldZones），带 Visualize Zones 和 Robot Position Viewer；或手工画盒子（透明度约 60%）+ 建碰撞集，机器人碰到 Zone 就报警。
- 对应新手课：L14（安全）
- 库里对应：无（Zone 写法见草稿 `safety-world-zones.md`）
- 对比：**补进库里：可视化做法**。Zone 本身的写法（`WZSphDef` / `WZBoxDef` / `WZDOSet`、挂 PowerOn 事件）通用，不分版本。草稿在 `docs/youtube-study/drafts/world-zones-visualization.md`。

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
- 库里对应：`docs/beginner-roadmap.md`（15 课新手路线）
- 对比：**补进库里：这几个模块的内容**：碰撞检查深入（模块 9）、Pack and Go 与 Add-ins（模块 12）、RobotStudio Cloud（模块 13）、录制/包络/AR（模块 15）、信号分析仪（模块 10），按 EDWartens 课程大纲对应的视频学。

## 三、第三批：已学完（第三阶段）

### H8 ✅ How to Easy Program ABB Robots to Follow a Path by Using RAPID Programming Language

- 作者：Aleksandar Haber PhD
- 链接：https://www.youtube.com/watch?v=zZXk-TW2iCE
- 讲什么：导机器人/工件模型、装末端执行器、点动到各点记下目标点、建路径、用 RAPID 写程序让机器人沿路径走。
- 学法：流程按 Haber 视频顺序，步骤用 CMU Future CNC 官方教程、ITAR《RobotStudio Handbook》、卡尔加里大学 YuMi 指南、plcprogramming.io RAPID 教程交叉核对。
- 对应新手课：L4（示教点）、L6（路径与程序）
- 库里对应：`rapid/01_move_basics.mod`（MoveJ / MoveL 概念）
- 对比：**补进库里：完整操作链**：建站 → 记点 → 建路径 → 同步到控制器 → 跑仿真，草稿在 `docs/youtube-study/drafts/paths-targets-rapid.md`。

## 四、R1：已学完（第三阶段段 1–4＋第四阶段段 5–13）

### R1 ✅ ABB ROBOT PROGRAMMING TUTORIAL PART 1

- 频道：Automation Academy
- 链接：https://www.youtube.com/watch?v=hGGkzsT8WEU
- 时长：4 小时 36 分
- 课程简介（已核实，照抄 Wolf Robotics《ABB BASIC ROBOTIC PROGRAMMING》4 天线下班手册原文，已读核实）：“这门课教：机器人、点动；基础程序结构；怎么创建、修改、保存、加载程序；用 ABB Flex（FlexPendant）……基础焊接指令；10% 课堂、90% 动手；对象是写新生产程序的编程员／操作员。”
- 多版本对照（已核实）：同一频道、同一时期（5 年前直播）、同一门课的不同剪辑／上传，课程简介一字不差。

| 版本 | 视频 ID | 时长 | 播放量 |
|---|---|---|---|
| PART 1（R1，本课） | hGGkzsT8WEU | 4:36:34 | 25K |
| TUTORIAL（R2） | DsQu6AXvcgg | 2:58:07 | 17K |
| TUTORIAL（短版） | _l7buBX1DFk | 1:33:02 | 244 |
| TUTORIAL.（又一版） | — | — | 835 |
| TUTORIAL ---- PART 2（续集） | — | — | 2,807 |

- 短版时长 1:33:02。同一门课另有 4 小时 22 分、4 小时 13 分两个上传版本。
- 学法：分段按 Wolf 手册大纲 + ABB 官方 RU011／IN-RB02 课程大纲拆（两份都在 ABB 官方资料库读过原文），顺序一致。
- 已学完段 1–4（第三阶段）：
  - 段 1 安全开场：上锁挂牌、急停、安全链、进单元前确认安全装置 → 草稿 `drafts/safety-lockout-tagout.md`
  - 段 2 认识 FlexPendant：主菜单、快捷菜单、使能按钮、摇杆、操作模式、速度档 → 草稿 `drafts/flexpendant-navigation.md`
  - 段 3 点动：轴／线性／重定向三种模式、坐标系选择、速度；库里已有（H1／H2、例程 06、L2），这段主要是印证，不写新草稿
  - 段 4 工具 TCP 标定＋工件坐标系：示教器四点法标 TCP、标完验证、工件坐标系定义 → 草稿 `drafts/tcp-calibration-flexpendant.md`
- 状态：**已学完，段 1–13 全拆完**。段 5–13（第四阶段）：
  - 段 5 程序结构：任务—程序—模块（程序/系统）—例程（PROC/FUNC/TRAP）—数据（CONST/VAR/PERS）的层级链，main 只做调度 → 草稿 `drafts/rapid-program-structure.md`
  - 段 6 创建/修改/保存/加载程序：示教器上新建程序、示教点、ModPos 改点、复制粘贴改程序、保存/加载程序与模块 → 草稿 `drafts/create-modify-save-load-program.md`
  - 段 7 运动指令：MoveJ 空跑、MoveL 直线、MoveC 圆弧、MoveAbsJ 回零，速度与转弯区配对 → 草稿 `drafts/motion-instructions-movej-movel-movec.md`
  - 段 8 运行调试：PP to Main、手动单步、程序/运动指针、从指定指令重跑、自动模式、TPWrite/TPReadFK → 草稿 `drafts/run-debug-program.md`
  - 段 9 IO 信号编程：SetDO/WaitDI/WaitUntil、信号配置与模拟、PLC 时序对接 → 草稿 `drafts/io-signals-programming.md`
  - 段 10 备份恢复：整机备份/恢复、控制器重启、转数计数器更新 → 草稿 `drafts/backup-restore-rev-counters.md`
  - 段 11 负载与计时：LoadIdentify 自动辨识工具/工件负载、ClkRead/ClkStart 量节拍 → 草稿 `drafts/payload-timer-programming.md`
  - 段 12 基础焊接指令：ArcLStart 起弧、ArcL 焊直线、ArcLEnd 收弧，seamdata/welddata/weavedata → 草稿 `drafts/basic-welding-instructions.md`（全库第一篇焊接内容）
  - 段 13 外轴编程：变位机/导轨、MoveExtJ、协调运动、外轴标定 → 草稿 `drafts/external-axis-programming.md`（外轴对应 ABB 官方 RU011 课程 Day 4）
- 分段依据：Wolf 手册 + ABB 官方 RU011（5 天）与 IN-RB02（3 天）课程大纲（第四阶段重新读原文核实）；焊接参数按 ABB 弧焊手册和焊机给的数填。

## 五、第四批：已学完（第四阶段）

### H5 ✅ ABB Robot Studio Tutorial: Definition of Work-object Frames in ABB Robot Studio

- 作者：Aleksandar Haber PhD
- 链接：https://www.youtube.com/watch?v=igJmGmmN7xo
- 讲什么（播放页标题、简介已核实）：在旋转立方体的斜顶面上用三点法定工件坐标系——原点取顶面一角，Z 轴垂直顶面、X/Y 沿顶面边；并定安全点。
- 作业背景：Haber《Homework Assignment 2》配套视频之二，作业原文 https://aleksandarhaber.com/homework-assignment-2-2/（已读原文核实，7 项任务：旋转立方体、圆锥末端执行器、装法兰、定义工具坐标系、定义工件坐标系、安全点、画名字前两个字母）。
- 对应新手课：L9（坐标系）
- 库里对应：草稿 `drafts/workobject-three-point.md`（H4，三点法通用做法）
- 对比：**补进库里：具体应用**。H4 讲的是三点法通用步骤，H5 是它在斜顶面上的应用（Z 轴垂直顶面）。草稿在 `drafts/homework2-workobject-frames.md`。

### H6 ✅ ABB Robot Tutorial: Introduction to Programming in RobotStudio

- 作者：Aleksandar Haber PhD
- 链接：https://www.youtube.com/watch?v=ng_R2LRGL8o
- 简介：作者在简介里给出配套视频《ABB Robot Studio Tutorial: Definition of Work-object Frames》（H5），讲末端执行器建模、工具坐标系和工件坐标系。
- 讲什么：Haber《Homework Assignment 2》配套视频之四，前三个是 H1（点动）、H3（工具坐标系 + 基础建模）、H5（工件坐标系），这一个讲在 RobotStudio 里编程：建圆锥当笔、装法兰、TCP 定在尖端，从安全点出发在工件坐标系 X-Y 平面里用 MoveL 画名字前两个字母并跑仿真。
- 对应新手课：L4、L6
- 库里对应：例程 01（MoveJ / MoveL）、草稿 `drafts/paths-targets-rapid.md`（H8，完整操作链）
- 对比：**补进库里**：拿圆锥当笔画字母——笔尖当 TCP、点位全挂在斜顶面的工件坐标系下、从安全点出发画两个字母。草稿在 `drafts/homework2-drawing-letters-rapid.md`，立方体旋转角度和立方体、圆锥尺寸按自己工作站定。

### R2 ✅ ABB ROBOT PROGRAMMING TUTORIAL

- 频道：Automation Academy
- 链接：https://www.youtube.com/watch?v=DsQu6AXvcgg
- 时长：2:58:07
- 结论：**R2 是 R1 同一门课的短版剪辑，不是新课、不是续集**。证据：同一频道；标题只差“PART 1”；课程简介一字不差（照抄 Wolf 手册原文）；时长差 1:38:27，R2 约为 R1 的 65%；同标题、同简介的其他时长版本还有 1:33:02、1:36、2:28、4:13、4:22，说明同一堂课传过好几遍、剪过多个长度。R2 的内容都在 R1 里，所以写对比草稿。
- 对应新手课：L3–L12
- 库里对应：全部例程、R1 段 1–13 草稿
- 对比：库里已有。学全跟 R1 的 4:36 版走。草稿在 `drafts/r2-vs-r1-comparison.md`。

### R10 ✅ ABB ROBOT PROGRAMMING PART 1 / PART 2 (PLAYLIST IN DESCRIPTION)

- 标题已核实：PART 1《ABB ROBOT PROGRAMMING PART_1(PLAYLIST@DESCRIPTION》，5 分 37 秒；PART 2《ABB ROBOT PROGRAMMING PART_2(PLAYLIST IN DESCRIPTION》，11 分 44 秒。
- 讲什么（按章节名）：PART 1 章节 Introduction、Operating mode——5 分钟认识整套系统（本体＋控制器＋示教器＋RobotStudio），分清手动／自动操作模式、怎么切、切之前确认什么。PART 2：Intro、Overview、Main menu、Quick access menu，以及一串流程章节（新建工件、三点法、原点、点动、改点位、测试工件、定义点、工具、安全点、程序编辑器、代码讲解、应用代码、调试）——示教器上走完最小闭环：建工件（三点法）→定工具→教点（含安全点）→写程序（MoveJ／MoveL）→点应用→低速单步调试再切自动。
- 同一系列还发现 PART 4（2 分 33 秒）、PART 5（3 分 44 秒）、PART 6（11 分 22 秒）、PART 9（13 分 36 秒）、PART 10（17 分钟）。
- 对应新手课：L1、L3
- 库里对应：例程 01、例程 04、草稿 `drafts/flexpendant-navigation.md`、`drafts/workobject-three-point.md`、`drafts/tool-frames-definition.md`
- 对比：**补进库里两样**：操作模式三档和切模式步骤；从建工件到调试跑通的完整串联流程。草稿在 `drafts/rapid-intro-part1-operating-mode.md`、`drafts/rapid-intro-part2-first-program.md`。

### H7 ✅ Setting up Tool TCP（ABB 官方）

- 作者：ABB Robotics
- 链接：https://www.youtube.com/watch?v=vsSfa-enwgw
- 描述（已核实，原文）：“Learn how to set up the origin of a tool coordinate system, the Tool Center Point, for SWIFTI™, the CRB 1100 and CRB 1300 robot systems.”
- 讲什么：TCP 不只是一个点还是一个朝向——Z 轴是干活方向、X 轴是工具正面；四点法只能定位置，方向要在建 Frame 之前先把模型转对，错了会吸不牢、夹偏、Reorient 时 TCP 画圈。Patino 笔记 B.2.1 节“Set up the Tool Frame at the TCP”开头先摆工具朝向，再挂出本视频链接，然后才是放原点、建 Frame、量 184 mm 移到 TCP——说明它引用本视频是为了解释“方向”，不是位置。
- 对应新手课：L9
- 库里对应：`rapid/05_coordinates.mod`、草稿 `drafts/tool-frames-definition.md`（H3，三种方法）、`drafts/tcp-calibration-flexpendant.md`（R1 段 4，四点法流程）
- 对比：**补进库里：“方向本身”**。H3 和段 4 讲的是怎么定位置，这篇只补“方向是什么、错了长什么样、怎么检查”。草稿在 `drafts/tcp-orientation-direction.md`。

### P2–P6 ✅ Patino 推荐播放清单（5 个）

- 来源：Patino 笔记末尾“Recommended Courses”，按语言分两组放链接（西语 P2–P4、英语 P5–P6），下面的分工和顺序按视频目录排。
- 核实结果（2026-11-20 在 YouTube 清单页逐个打开核实）：

| 编号 | 标题 | 作者 | 规模 | 语言 |
|---|---|---|---|---|
| P2 | Curso Robotstudio | Juan Carlos Martín Castillo | 39 条 | 西语为主 |
| P3 | RobotStudio - Curso Introducción a RAPID | vTAutomatización | 24 条 | 西语 |
| P4 | Curso RobotStudio manual de prácticas y vídeos completos correspondientes a cada una de ellas. | Agustin Cañete López | 36 条（35 条机器人内容 + 1 条误放的摩托车越野赛视频） | 西语 |
| P5 | Robot Studio Tutorials | Daniel Barrett | 10 条 | 英语 |
| P6 | Learning Industrial Robot Programming | SquishyBrained | 10 条（EP1–EP10） | 英语 |

- 路线图：P6→P5→P3→P2/P4 前半→进阶挑着看；每清单列了先看哪 2–6 条视频。清单里的 9 类进阶内容已标出：PLC/OPC 联动、双机器人 MultiMove、外部轴/导轨/变位机、中断与系统信号、事件例程、TCP 跟踪、随机供料、SolidWorks 导入；焊接按 R1 段 12 和 `projects/welding/` 学。
- 对应新手课：L1–L15（整条新手路线都能对上）
- 库里对应：`docs/beginner-roadmap.md`（15 课新手路线）
- 对比：5 个清单共 119 条视频，按上表先看的那几条学；P4 配套 Dropbox 练习文档链接在 Patino 笔记里；清单数量是 2026-11-20 当天的数。草稿在 `drafts/patino-playlists-guide.md`。

## 六、片段教程

### R9 ⚠️ General Robot Studio Routines

- 时长：20 分钟
- 只有一句解说词片段：“还是手动加载……按播放，仿真在跑，重力是生效的……启动机器人”——讲的是仿真里重力生效、手动加载后启动。
- 用法：配合 L14（仿真）看，练手动加载、开重力、启动仿真。

## 七、目录：已全部学完

32 条全部学完。

**目录总计：32 条**（学完 32 条：第一阶段 9 条 H1、H2、H4、P1、A1、C1–C4，第二阶段 10 条 H3、R3–R8、C5、A2、E1，第三阶段 1 条 H8，第四阶段 12 条 R1 段 5–13、H5、H6、R2、R10、H7、P2–P6；片段教程 1 条 R9；其中 H3、A2 在第一阶段只列目录、第二阶段学完；H8 是第二阶段新发现、第三阶段学完）。

## 八、四阶段补进库里的内容

第一阶段的 10 样：

1. 三点法定义工件坐标系的具体步骤（H4）→ 草稿 `drafts/workobject-three-point.md`
2. 工具标定完整步骤：TCP 量测、Create Tool 向导、重心 Snap Gravity（P1 Part 1）→ 草稿 `drafts/vacuum-gripper-smart-component.md`
3. 真空夹爪 Smart 组件：Line Sensor + Attacher/Detacher + DI 逻辑（P1 Part 1）→ 同上
4. 传送带物理仿真：Surface Velocity、Physics、Source、PhysicsControl（P1 Part 2）→ 草稿 `drafts/conveyor-physics.md`
5. 叠放偏移 + 传感器分支分拣（P1 Part 3）→ 草稿 `drafts/pick-place-offsets-sorting.md`
6. 安全：QuickStop 信号 + World Zone + PowerOn 事件（P1 Part 4、A2）→ 草稿 `drafts/safety-world-zones.md`
7. 虚拟控制器改安装选项（A1）→ 已写进 `projects/welding/`、`projects/conveyor-tracking/`、`projects/multi-robot/` 的搭建步骤
8. 从已有布局创建单机器人系统 + 配置 I/O（C5）→ 第二阶段已学，草稿 `drafts/create-system-from-layout.md`
9. 仿真初始状态保存（P1 Part 2）→ 已写进草稿 `drafts/conveyor-physics.md`
10. EDWartens 16 模块课程包的结构（E1）→ 第二阶段已学大纲，见上面 E1 一节

第二阶段新补的内容：

11. 工具坐标系定义三种方法（TCP 4 点 / TCP+Z / TCP+Z+X）+ Create Tool 向导步骤（H3）→ 草稿 `drafts/tool-frames-definition.md`
12. PLC 程序号调度（gi/go 回执 + 执行标志）+ Pounce 点 + Offs 接近 + 夹爪故障处理 + No Step 模块（R4）→ 草稿 `drafts/pick-place-plc-program-numbers.md`
13. 多个工件坐标系复用讲法：一个程序多处用，换工位只改工件不改程序（R8）→ 草稿 `drafts/multiple-workobjects.md`
14. World Zone 可视化做法：工作站里直接显示、WorldZones Add-in、手工画透明盒子 + 碰撞集（A2）→ 草稿 `drafts/world-zones-visualization.md`
15. EDWartens 进阶模块：碰撞检查深入（模块 9）、Pack and Go 与 Add-ins（模块 12）、RobotStudio Cloud（模块 13）、录制/包络/AR（模块 15）、信号分析仪（模块 10）→ 见上面 E1 一节
16. R1 多版本已核实：PART 1 hGGkzsT8WEU 4:36:34、R2 DsQu6AXvcgg 2:58:07、短版 _l7buBX1DFk 1:33:02；**R2 是 R1 同一课的短版剪辑（短 1:38:27）** → 见上面 R2 一节，草稿 `drafts/r2-vs-r1-comparison.md`

第三阶段新补的内容：

17. 沿路径走 RAPID 的完整操作链：导模型 → 装末端执行器 → 点动记点 → 建路径 → 同步到控制器 → 跑仿真（H8）→ 草稿 `drafts/paths-targets-rapid.md`
18. 安全开场：上锁挂牌＋急停＋安全恢复（R1 段 1）→ 草稿 `drafts/safety-lockout-tagout.md`
19. FlexPendant 导航：主菜单／快捷菜单／操作模式／使能与速度（R1 段 2）→ 草稿 `drafts/flexpendant-navigation.md`
20. 示教器四点法标 TCP＋验证（R1 段 4）→ 草稿 `drafts/tcp-calibration-flexpendant.md`

第四阶段新补的内容：

21. 程序结构层级链：任务—程序—模块（程序/系统）—例程（PROC/FUNC/TRAP）—数据（CONST/VAR/PERS），main 只做调度（R1 段 5）→ 草稿 `drafts/rapid-program-structure.md`
22. 示教器日常改程序：新建程序、示教点、ModPos 改点、复制粘贴改程序、保存/加载程序与模块（R1 段 6）→ 草稿 `drafts/create-modify-save-load-program.md`
23. 运行调试完整流程：PP to Main、手动单步、程序/运动指针、从指定指令重跑、自动模式、TPWrite/TPReadFK（R1 段 8）→ 草稿 `drafts/run-debug-program.md`
24. 备份恢复与转数计数器更新：整机备份/恢复和单程序保存的区别、控制器重启（R1 段 10）→ 草稿 `drafts/backup-restore-rev-counters.md`
25. 负载辨识 LoadIdentify 与计时量节拍：工具/工件负载自动辨识、ClkRead/ClkStart（R1 段 11）→ 草稿 `drafts/payload-timer-programming.md`
26. 基础焊接指令：ArcLStart 起弧、ArcL 焊直线、ArcLEnd 收弧，seamdata/welddata/weavedata（R1 段 12，全库第一篇焊接内容）→ 草稿 `drafts/basic-welding-instructions.md`
27. 外轴编程：变位机/导轨、MoveExtJ、协调运动、外轴标定（R1 段 13，对应 ABB RU011 Day 4）→ 草稿 `drafts/external-axis-programming.md`
28. 操作模式三档与切模式步骤（R10 PART 1）→ 草稿 `drafts/rapid-intro-part1-operating-mode.md`
29. 从建工件到调试跑通的完整串联流程（R10 PART 2）→ 草稿 `drafts/rapid-intro-part2-first-program.md`
30. TCP 方向本身：Z 轴是干活方向、X 轴是工具正面，四点法只定位置不定向（H7）→ 草稿 `drafts/tcp-orientation-direction.md`
31. 作业 2 应用：斜顶面三点法定工件、圆锥当笔画字母（H5/H6）→ 草稿 `drafts/homework2-workobject-frames.md`、`drafts/homework2-drawing-letters-rapid.md`
32. Patino 清单里的 9 类新主题：PLC/OPC 联动、双机器人 MultiMove、外部轴/导轨/变位机、中断与系统信号、事件例程、TCP 跟踪、随机供料、SolidWorks 导入（P2–P6）→ 草稿 `drafts/patino-playlists-guide.md`
