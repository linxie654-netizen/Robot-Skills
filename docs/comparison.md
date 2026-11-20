# 网上 ABB 编程 APP / 库对比学习

更新：2026-11-20。只写已核实的内容，没核实的标“未核实”，不编 Star 数和功能。
来源：GitHub 实查页面 + 官方说明。ABB 官方没有在 GitHub 放完整 RAPID 教程库。

## 热门 Skill 对比（2026-11-20 查 skills.sh，2026-11-10 数据）

热门技能的共同点：名字短（1–2 个词）、一看就知道干什么、只做一件事；结构都是一个文件夹，`SKILL.md` + 脚本/参考文件，描述不超过 1536 字符，安装一条命令。

| 热门 Skill | 安装量 | 名字规律 | 结构 / 做法 | 给本库的启发 |
|---|---|---|---|---|
| find-skills | 430 万 | 动词 + 名词 | 帮你找已有的技能，别重复造轮子 | 先查 GitHub 再写，本库已照做 |
| grill-me | 150 万 | 动词 + 代词，短好记 | 先问清方案再动手 | 问清型号、场景再给代码 |
| agent-browser | 150 万 | 领域 + 工具 | 薄薄一层包住一个 CLI | 桥操作走脚本，不在 SKILL.md 里堆命令 |
| tdd | 120 万 | 3 字母缩写 | 一套固定流程：红绿重构 | 仿真先跑通再上真机，也是固定流程 |
| frontend-design | 110 万 | 领域 + 动作 | 给出品标准，不只给代码 | RAPID 也要给“对”的标准：先仿真、查碰撞、低速验证 |
| systematic-debugging | 32 万 | 副词 + 动词 | 一步步找根因，不猜 | 报错先查手腕姿态和工件坐标系，别乱改点位 |
| skill-creator | 42 万 | 动作 + 名词 | 教你写技能、测技能 | 边问边学循环就是本库的 skill-creator |

**本库技能的改名**：2026-11-20，用户说 `abbrobotstudio` 不好听——三个词拼在一起，只说了软件名，没说能干什么。先改成 `rapid-mentor`，用户随即纠正，定名 **`Robot-RAPID`**（文件夹名按技能规范用小写 `robot-rapid`）：短、直接说出机器人 + RAPID 语言，符合上面热门技能的命名规律。备选曾考虑 `abb-robot-mentor`、`robot-code-craftsman`、`rapid-mentor`，用户最后定的是 Robot-RAPID。

## 工科类 Skill 对比（2026-11-20 查，学它们的结构）

用户说我们的 skill 跟别的比还是太少。薄的不是 SKILL.md 本身（Anthropic 的 frontend-design 只有 71 行、9.4KB，照样 110 万安装），薄的是配套的东西：工科 skill 都有报错手册、按任务分流、检查清单和版本钉死。我们按这个补。

| 工科 Skill | 是什么 | 结构上有什么 | 学到什么，用在哪 |
|---|---|---|---|
| SmailG/plc-programming（PLC，离我们最近） | Siemens TIA / Schneider / CODESYS 等 PLC 编程插件 | 不止一个 skill：develop（立项→需求→设计→代码→验证→测试）、debug（先取证再修 + 故障模式目录）、convert、siemens、schneider、iec-61131-3；还带 stdlib 校验器、离线工程文件读取器 | 按任务分流 + 故障模式目录 → 已补：SKILL.md 开头加“要干什么先读什么”分流表，`references/troubleshooting.md` 就是故障模式目录 |
| robot-validator（ROS 2 机器人） | 机器人系统健康检查 skill | 7 步工作流（定范围 → 验 URDF → 验 TF 树 → … → 出报告），frontmatter 带 version / keywords / category | 固定步骤 + 出报告 → 已补：`references/simulation-checklist.md` 逐项打勾，修好要说清验证结果 |
| pixel-robotics/bt-rosbag-analysis（ROS 2） | ROS 2 行为树排障 skill | skill 本身就是一份可执行手册：标准查询都写好了（常坏节点、时间线） | 手册要能直接照着跑 → 已补：`references/rapid-patterns.md` 每个模式配代码和对应例程 |
| RavenClaude robotics 插件 | 机器人与自主系统工程插件 | 3 个专家 agent + 决策树知识库 + 模板 + 最佳实践；版本号、日期都钉死，写明“用前再核实” | 版本钉死 + 用前核实 → 曾补 README 版本行，2026-11-21 用户要求删掉（公开仓库内容按通用写，不钉死版本） |
| awesome-gamedev-agent-skills | 79 个游戏开发 skill + 路由器 | 按引擎/学科/类型/流程分类编目，路由器按项目文件自动挑 skill；每个 skill 按官方文档写、钉死引擎版本、有 validator 和 evals | 编目 + 路由 → 本库只有一个 skill，不拆；改成 SKILL.md 内的分流表，相当于一个小路由器 |

**补完后的本库结构**：SKILL.md + references 5 个文件（learned、troubleshooting、rapid-patterns、smart-components、simulation-checklist）+ INSTALL.md；库里另有 RAPID 例程 10 个、Python 2 个、docs 根目录 6 个文件。跟 PLC 那个插件比还是少（人家是多 skill + 校验器），下一步可补的是一个 RAPID 语法自查清单，但那要先有真机验证，暂时不写。

## 对比表

| APP / 库 | 是什么 | 语言 / 入口 | 能干什么 | 适合谁 | 费用 / 协议 | 核实 |
|---|---|---|---|---|---|---|
| ABB RobotStudio（官方） | ABB 官方离线编程 + 仿真软件 | 图形界面 + RAPID | 建站、选机器人、示教点、跑轨迹、仿真、查碰撞、连虚拟控制器 | 所有人必装，学习起点 | 免费版可下载（非商业），以 ABB 官网为准 | 官方下载页已确认存在，版本以官网为准 |
| ABB RAPID（官方语言） | ABB 机器人编程语言，跑在 IRC5 / OmniCore 控制器上 | RAPID `.mod` | MoveJ/MoveL/MoveC/MoveAbsJ、IO、循环、判断、坐标系、工具/工件 | 必须学，核心 | 随控制器 / RobotStudio | 语法见本库 `rapid/` 例程和官方 RAPID 手册 |
| rpiRobotics/abb_motion_program_exec | Python 发运动指令的库 | Python | Python 写 MoveAbsJ/MoveJ/MoveL/MoveC/WaitTime，下发到控制器执行；支持 EGM、双机联动 | Python 初学者 + 想做 Python 联动的人，最推荐入手 | Apache-2.0，PyPI 可装 | 32 星，2026-11-20 实查 GitHub 页面 |
| RobotComponents | Grasshopper 插件，直观编 ABB 机器人 | Grasshopper + Python/C# API | 40+ ABB 模型、正逆解、画轨迹、仿真、生成 RAPID、实时连 IRC5/OmniCore | 有 Rhino 基础、做轨迹设计的人 | GPL-3.0 | 77 星，1475 提交，69 发布，2026-11-20 实查 |
| rparak/ABB_EGM_Python | Python 经 EGM 控制 ABB 臂 | Python + EGM | 关节/笛卡尔位置实时下发，测 IRB 120 和 YuMi IRB 14000，带 RobotStudio 工程 | 想学 EGM 实时控制的人 | MIT | 21 星，2026-11-20 实查 |
| FLo-ABB/Hershey-ABB-Robot-Handwriting | Python 生成 RAPID 写字程序 | Python 生成 RAPID | 矢量字体转 RAPID 轨迹，RobotStudio 仿真写字 | 学“Python 生成 RAPID”思路的好例子 | MIT | 2026-11-20 实查 README |
| RoboDK + Industrial-Robots-VSCode | 离线编程软件 + VS Code 语法高亮 | RoboDK / VS Code | 多品牌机器人离线编程、仿真；VS Code 给 RAPID 等语言加高亮 | 想跨品牌、想在 VS Code 写 RAPID 的人 | RoboDK 有免费版，插件开源 | 搜索结果确认，未逐项核实版本号 |
| RAPID Live for ABB Robots / abb-rws-client | VS Code 直连真机 / 虚拟控制器 | TypeScript + RWS | RAPID 补全、悬停、推拉 `.mod`、连 RWS 1.0/2.0 | 进阶：想在 VS Code 里直接改控制器程序的人 | Apache-2.0（按扩展页） | 扩展页确认支持 RobotWare 8.2.1 / 7.21.4 / 6.16.03 虚拟控制器 |
| abb_wrapper / abb_libegm + abb_librws | C++ 库，连 EGM 和 RWS | C++ | EGM 实时引导 + RWS 读写控制器，配 StateMachine Add-In | 进阶 C++ 开发，不适合入门 | 未核实协议，以仓库为准 | 搜索结果确认，未逐项核实 |
| Autodesk Mimic | Maya 插件，控制工业机器人 | Python 3 + Maya | Maya 里仿真、编 6 轴机器人，生成 RAPID 等后处理 | 有 Maya 基础的人 | MIT | 搜索结果确认，未逐项核实 |

## 对比结论（给初学者的建议）

1. 必学主线：RobotStudio + RAPID。其他库都是围绕这两样做“生成 RAPID”或“发指令”。
2. Python 联动主线：先用 `abb_motion_program_exec`，它最贴近你的目标（Python + ABB 联动），安装最简单，例子直接能跑虚拟控制器。
3. EGM 是进阶：实时控制要开 EGM 选项（RobotWare 选项），先别碰，等 MoveJ/MoveL 跑通再说。
4. Grasshopper / Maya / C++ 都是旁支：除非你本来就用 Rhino 或 Maya，否则先不动。
5. 不要抄别人的代码当自己的：上面仓库都是别人的开源项目，本库只引用、学习思路，RAPID 例程是我按官方语法重写的教学版。

## 新手教程来源（2026-11-20 查的，Q6）
- plcprogramming.io《ABB Robot Programming Tutorial 2026》：RAPID 结构、4 种编程方法、RobotStudio 离线流程、MoveJ/MoveL、工具/工件。【9018129499109220005†L9-L16】
- RobotIndus3 RAPID 教程：15 课、6 小时+，从 MODULE、变量、IF/FOR/WHILE/TEST、MoveJ/MoveL/MoveC/MoveAbsJ、IO、函数、报错处理到生产程序；免费、带浏览器 3D 模拟器。【9018129499109220005†L78-L86】
- TryPLC ABB RAPID：RAPID 是 Pascal 风格强类型语言，模块 + PROC main 入口，Move 一行包含目标、速度、区域、工具；IRC5 到 OmniCore 大部分 RAPID 通用。【4507421519131795109†L112-L115】
- CMU Future CNC RobotStudio 教程：10 步建基础程序（Jog Joint、Teach Target、建 Path、同步到虚拟控制器、仿真播放），另有加工具的 10 步。【8932007933019643557†L19-L29】
- AYE Tech Hub Lesson 04：IRB 系列、IRC5、RobotStudio、RAPID、MoveL/MoveJ、IO、速度/区域/工件/工具。【4507421519131795109†L15-L17】
- 共识路线已写进 `docs/beginner-roadmap.md`，共 12 课 + 6 个新手常犯错。

## 2026-11-20 别的 AI 搜到的 7 个相关项目（对比学习）

背景：别的 AI 在 GitHub 上按 "SKILL.md + ABB/RAPID/RobotStudio" 搜，没找到我们的仓库，只找到下面 7 个。2026-11-20 晚逐个打开 GitHub 页面核实。各项目最近更新时间页面没显示，一律写未核实。

| 项目 | 是什么 | 星数 | 是 Agent Skill（SKILL.md）吗 | 有 ABB 内容吗 |
|---|---|---|---|---|
| zhou-zhichao/robotstudio-mcp（另一 AI 给的地址） | 地址不存在（404） | — | — | — |
| PMinhDuc204/abb-robotstudio-mcp6.08（真正的 RobotStudio MCP 服务） | RobotStudio MCP 服务，63 个工具 | 0 | 不是 | 有 |
| Hollis36/abb-offline-coder | 离线 AI 助手，中文需求生成 RAPID 喷涂程序 | 0 | 不是 | 有 |
| dtpisanty/abblender | Blender 插件，动画导出 RAPID .mod | 7 | 不是 | 有 |
| ABB-RARO/rapid-modbus-tcp | OmniCore 的 Modbus TCP RAPID 库 | 3 | 不是 | 有 |
| ABB RAPID Pack（VS Code 扩展） | RAPID 语法、跳转、引用、重构、诊断 | 约 2.3K 安装 | 不是 | 有 |
| graph-robots/open-robot-skills | Anthropic Agent Skills 格式的操作技能集 | 74 | 是 | 没有 |
| arpitg1304/robotics-agent-skills | Agent Skills 格式的机器人技能集 | 404 | 是 | 没有 |

### 1. robotstudio-mcp —— 另一 AI 给的地址是错的

**是什么**：`zhou-zhichao/robotstudio-mcp` 打开是 404，仓库不存在。另一 AI 把名字记混了：Zhichao Zhou 是论文《Retrieval-grounded robot program generation and simulation-based correction via Model Context Protocol》（arXiv:2505.03275）的作者，讲的是 RAG + MCP 生成并仿真验证 ABB RAPID 程序，论文里没有这个仓库地址。真正的 RobotStudio MCP 服务是 `PMinhDuc204/abb-robotstudio-mcp6.08`：TypeScript MCP 服务 + ClaudeBridge C# 插件，63 个工具（33 个 `rs_*` + 30 个 `rws_*`），v3.1.0，面向 RobotStudio 6.08，0 星、15 提交、建于 2026-10-26，MIT 协议。

**跟我们有什么关系**：就是用户 Windows 机上装过的那个 MCP（63 个工具），用户 2026-11-20 14:40 已拍板停掉 MCP 路线、改做 Skill，20:27 又让把桥和 MCP 的东西全删了。它不是 Agent Skill（根目录没有 SKILL.md）。

**借鉴点**：① `rs_validate_rapid` 先做结构校验再上传的思路；② 工具按风险分级（工具名后缀 A/B/C/D 标危险程度）。但 MCP 路线用户已拍板停掉，这些不往技能里加。

### 2. Hollis36/abb-offline-coder —— 离线 AI 助手，专做喷涂

**是什么**：本地 LLM（Qwen2.5-Coder-7B + Ollama）+ 官方手册 RAG，用中文描述需求生成 ABB 喷涂机器人 RAPID 程序，约 25 秒/程序，IRC5/IRC5P 双模式（IRC5P 用 PaintL/PaintC + brushdata 原生工艺），Pack&Go 一键交付可直接上控制器的目录，0 星、24 提交、建于 2026-05-16。许可证：README 写 MIT，GitHub 未检测到许可证类型（NOASSERTION）。不是 Agent Skill，是命令行工具，无 SKILL.md。

**跟我们有什么关系**：思路最近的一个 ABB AI 项目，但只做喷涂一个场景，不教新手、不讲 RobotStudio 操作。

**借鉴点**：① 喷涂是我们的空白——30 课大白话教学里只有第 24 课基础焊接，喷涂一个字没有；PaintL/PaintC、brushdata 是可补的方向；② 手册做 RAG 知识库的思路值得学；③ 它也要求生成代码必须先在 RobotStudio 里仿真验证再上机，跟我们的红线一致；④ Pack&Go 一键交付的思路好。

### 3. dtpisanty/abblender —— Blender 插件，动画导出 RAPID

**是什么**：Blender 插件，在 Blender 里给 ABB 机器人做动画，导出成 RAPID 模块（.mod，jointtarget），只在 6 轴 IRB-1600/10Kg/145 上测过，7 星、3 fork、30 提交、建于 2020-02-19，MIT。不是 Agent Skill。

**跟我们有什么关系**：另一条“生成 RAPID”的路子——先在别处把轨迹画出来，再转成 RAPID。但 Blender 不是用户在学的工具，跟新手主线关系不大。

**借鉴点**：“轨迹先可视化、再转代码”的思路；我们的技能没有 Blender 导出这一块，也不必补。

### 4. ABB-RARO/rapid-modbus-tcp —— OmniCore 的 Modbus TCP 库

**是什么**：ABB 机器人控制器用的 Modbus/TCP 客户端/服务端 RAPID 库，分 Server、Client、夹爪模板三部分，要求 RobotWare 7.13+、Server 需 3114-1 多任务选项，带西门子 PLC（SCL）对接示例，3 星、1 fork、35 提交、建于 2025-09-08，MIT，1 个 Release。不是 Agent Skill。

**跟我们有什么关系**：PLC 联动是用户的目标（Python + PLC + ABB 结合），Modbus TCP 是 PLC 和机器人联动的一种现实做法；但它是 OmniCore 专属，我们的技能按通用写、不钉死版本。

**借鉴点**：① 可在技能里提一句 Modbus TCP 联动、给个链接，不必展开；② 它的中英双语 README、SCL 示例值得学。

### 5. ABB RAPID Pack —— VS Code 扩展，写 RAPID 的好帮手

**是什么**：VS Code 扩展，作者 Maxime Cesare-Zurek（Maxzurek.abb-rapid-pack），约 2.3K 安装量，免费；RAPID 语法高亮、跳转定义、查引用、重构、诊断、格式化、文档，全部本地处理、无遥测；独立社区项目，与 ABB 无关。不是 Agent Skill。

**跟我们有什么关系**：不教编程，只让写 RAPID 的编辑器更好用。

**借鉴点**：写 RAPID 时在 VS Code 里装它，比记事本强得多；可写进技能的工具推荐里（INSTALL.md 或 troubleshooting）。我们的技能没有编辑器层面的支持，这是可补的一小块。

### 6. graph-robots/open-robot-skills —— 真 Skill 格式，但无 ABB

**是什么**：Anthropic Agent Skills 格式的操作技能集（skills/ 下每个包一个 SKILL.md，31 个技能 + 8 个工具包），74 星、9 fork、64 提交、建于 2026-06-11，Apache-2.0。内容是 GaP（graph as policy）操作技能：抓取、线缆布线、感知、VLA 策略——没有 ABB、没有 RAPID、没有 RobotStudio。

**跟我们有什么关系**：格式上是同类（SKILL.md 封装），内容上完全不重叠。

**借鉴点**：① “一个包一个 SKILL.md、一个 PR”的贡献规范；② 技能带 exit_conditions（退出条件）的设计——我们的技能可以借鉴，给每课加“做到什么样算会”；③ 工具包与技能分离（tools/ vs skills/）的结构。

### 7. arpitg1304/robotics-agent-skills —— 真 Skill 格式，ROS 方向，借鉴最多

**是什么**：Agent Skills 格式的机器人技能集（skills/ 17 个技能 + 一个 agent harness），404 星、51 fork、25 提交、建于 2026-02-26，Apache-2.0。ROS1/ROS2 方向：节点、QoS、生命周期、测试、Docker、bringup、安全等，没有 ABB。

**跟我们有什么关系**：格式上是同类，内容上是 ROS，没有 ABB；但它是 7 个里星数最高的，结构最值得学。

**借鉴点**：① evals/ 对比：同一提示，有技能 vs 无技能的效果对比（带数据）；② harness 闭环：写代码 → 仿真里跑 → 看评估报告 → 改 → 用没见过的种子验证——这正是我们的“验证关口”缺的闭环形式，RobotStudio 验证跑通后可以照着做；③ install.sh 按需安装单个技能；④ “What Good Skills Contain”清单：触发描述、工作示例、失败模式、生产默认值、反模式。

## 对比结论（2026-11-20 晚核实）

1. 7 个项目里，**没有一个是“SKILL.md 格式的 ABB 技能”**。两个真正的 Agent Skill 仓库（open-robot-skills、robotics-agent-skills）都是 ROS / 通用操作方向，无 ABB；四个 ABB 项目（MCP 服务、离线喷涂助手、Blender 插件、Modbus 库、VS Code 扩展）都不是 Skill 格式。
2. 按本次核实的 7 个项目 + 此前搜索（2026-11-20），**我们的 Robot-RAPID 是核实范围内唯一一个按 SKILL.md 格式封装的 ABB 技能**。但“GitHub 上第一个”无法穷尽证实——GitHub 全量检索做不到，只能说“目前核实到的范围内没有第二个，‘第一个’未核实”。
3. 值得补进我们技能的三样（按优先级）：① harness 式验证闭环（写代码 → 仿真跑 → 看报告 → 改 → 换种子再验）→ 已补：2026-11-21 SKILL.md 验证关口 + simulation-checklist.md，只在仿真里做，不上真机（用户 2026-11-21 定）；② 喷涂内容（PaintL/PaintC、brushdata），我们的 30 课里没有；③ VS Code 里装 ABB RAPID Pack 的工具推荐 → 已补：2026-11-21 SKILL.md 分流表 + INSTALL.md 已推荐安装。
4. 另一 AI 的报告本身有一处错：`zhou-zhichao/robotstudio-mcp` 这个地址不存在，真正的 MCP 服务是 PMinhDuc204/abb-robotstudio-mcp6.08。

## 下次对比要补的
- 每个库的最近更新时间、是否还在维护。
- RobotStudio 最新版本号和下载链接复核。
- 用户定下机器人型号后，按型号补“该型号在各库里的支持情况”。
