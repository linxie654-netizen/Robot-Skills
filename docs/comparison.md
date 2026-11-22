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

---

## 2.0 对比（2026-11-22 实查五家 GitHub 页面）

这次只看写法，不看内容重叠：五家里没有一家讲 ABB / RAPID / RobotStudio，拼的是 skill 怎么做得让人信、让人会用。下面 Star 数、文件数、写法细节都是 2026-11-22 打开 GitHub 页面亲眼看到的，没打开的写“没打开”。

### 总表

| 仓库 | 是什么 | Star（2026-11-22 页面） | 技能数（页面为准） | 协议 | 跟我们的关系 |
|---|---|---|---|---|---|
| arpitg1304/robotics-agent-skills | ROS1/ROS2 生产级机器人技能集 + 仿真验证 harness | 405（任务简报写 404，页面已是 405） | 17（README 徽章和技能表都是 17；第三方索引 alyn 显示 10，是旧快照，以 README 为准） | Apache-2.0 | 同类（机器人方向），内容 ROS、无 ABB；写法最值得抄 |
| graph-robots/open-robot-skills | GaP（graph as policy）操作技能 + 工具包注册表 | 74 | 31 个技能 + 8 个工具包 + policies | Apache-2.0 | 同类（机器人操作），内容是抓取/线缆/感知、无 ABB；exit_conditions 和自查命令最值得抄 |
| addyosmani/agent-skills | 工程全流程技能包（定义→计划→开发→验证→评审→发版） | 119,529 | 26（25 个生命周期技能 + 1 个元技能 using-agent-skills） | MIT | 不是机器人，是写法标杆；技能解剖结构和验证关口最值得抄 |
| mattpocock/skills | Matt Pocock 的个人工程技能库，TDD 等 | 329,578 | 约 21 个（仓库根目录 skills/ 下分 engineering / productivity 两组；第三方研究记 22 个含 4 个已废弃，以仓库为准不钉死） | MIT | 不是机器人，是写法标杆；seams（测试缝）和反模式写法最值得抄 |
| alchaincyf/nuwa-skill（女娲） | 造技能的技能：把一个人的思维方式蒸馏成独立 skill | 38,750 | 1 个元技能，已蒸馏出 14 个人 + 1 个主题（各成独立仓库） | MIT | 不是机器人，是“怎么把理解变成技能”的标杆；五步蒸馏法和保真度评分卡最值得抄 |

### 1. arpitg1304/robotics-agent-skills —— 机器人同行里写法最完整的

**页面看到的**：README 开头先讲“两部分”——`skills/` 是稳定的知识，`harness/` 是实验性的验证闭环。harness 的循环画出来了：probe the rig → 写 app.py → `rah run`（开发种子）→ 读报告 → 只改一处 → `rah verify`（没见过的种子验证）。评估器是“看不见的”——成功标准是目标关系（比如 `at(object_0,target_2)`），报告给每段进度、哪段关系断了、信念和真实值的对照、安全包线违规；还有实验账本（每个结果绑代码哈希）和 `rah replay` 重放。README 里有“First results”实数表（搬三块积木 10/10，反向 9/10，叠三块 SO-101 是 0/10），失败也照写，还写明“这些数只说明逻辑和传感器集成没问题”——诚实边界写得很直。

**SKILL.md 写法**：每个技能一个文件夹、一个 SKILL.md（第三方索引显示 robot-perception 只有 1 个文件）。README 有“Recommended Bundles”表——按任务给搭配（ROS2 应用、感知、生产机器人各是哪几个技能），不是让用户自己挑。还有“Coverage Map”树状图（架构→设计原则、中间件→ros1/ros2、行为→设计模式……），一眼看清缺哪块。README 末尾有“What Good Skills Contain”清单：触发描述要具体、给能跑的例子、写清失败模式（QoS 不匹配、坐标变换过期、不安全关机、阻塞回调）、给生产默认值（有界队列、生命周期管理、可观测性、测试）、列反模式。

**验证关口**：evals/ 目录做“同一提示、有技能 vs 没技能”对照，报告写明这是单任务单次对比、自我评估、两个产物都没在真实 ROS2 发行版上构建过，不算基准测试，只算设计意图的展示。对照表是硬数字：无技能 0 行测试 vs 有技能 601 行测试、4 个参数 vs 13 个参数。安装是 `./install.sh --target … --skills ros2 robotics-testing robot-bringup`，可按需单装。

**例子给得怎么样**：好。每个技能表里都有“关键主题”一列；harness 有完整可跑的命令序列（`rah doctor / probe / run / verify / replay`），不是空话。

**值得抄**：① harness 式闭环（我们 11-21 已补的 5 步验证闭环是文字版，它是能跑的命令版——下一步可抄的是“换没见过的条件再验”，我们 SKILL.md 第 5 步已有这句话，缺的是像它那样把“开发种子 vs 验证种子”分开写清）；② “同一提示有技能 vs 没技能”对照表（evals/ 做法，我们可以做 RAPID 版：同一段搬运需求，没技能 vs 有技能写出来的程序对照）；③ Recommended Bundles（按任务给搭配，我们只有一个技能，用不上整表，但 SKILL.md 开头的分流表可以按“任务→先读什么”再细一层）；④ “What Good Skills Contain”清单（触发描述、能跑的例子、失败模式、生产默认值、反模式——可直接当我们每次补技能的自查清单）；⑤ 失败照写、数字照写、局限写明的诚实写法（它更进一步：失败结果 0/10 也贴出来）。

**我们写得比它好的地方**：它是英文、面向会 ROS 的工程师；我们是中文大白话、面向新手，30 课教学和“每次提问都记下来”的学习循环是它没有的。它没有 ABB 内容，我们在核实范围内仍是唯一 SKILL.md 格式的 ABB 技能（见 11-20 结论）。

### 2. graph-robots/open-robot-skills —— exit_conditions 和自查命令的范本

**页面看到的**：README 开头一句话定位：“What your robot can do, one directory at a time.”（你的机器人能干什么，一个目录一件）。技能和工具严格分开：skills/ 是“机器人能做什么”（操作策略），tools/ 是“机器人能算什么”（模型-backed 的工具包，一个模型一个包，不拥有子图）。README 里技能表和工具表都是自动生成的，写明用 `uv run gap skills table --format markdown` 重新生成——表不会手写过时。

**SKILL.md 写法**：frontmatter 里除了 name、description，还有 `gap:` 扩展键：`allowed_tools`（能调哪些工具）、`exit_conditions`（退出条件，下游路由就靠它）、`required_inputs`、`produces_outputs`、`hard_rules`（硬规矩）、`canonical_scripts`（标准脚本）、`references`、`examples`、`streaming`。以 `grasping-with-planner` 为例：description 是第三人称、一句话结尾必须是“Use when…”；正文讲清主路径（Z 轴锁定的直线下探）和备用路径（直线解不出来就 fallback 到 cuRobo 规划器），还写“不要把一个 grasp 节点拆回 approach / build_world / plan / execute——脚本内部已经做了”。每个技能带 `scripts/`（图执行的标准配方）和 `examples/canonical_subgraph.json`（标准子图例子）。

**验证关口**：仓库自带三条自查命令，README“Verify a checkout”一节写清：`gap skills check` 逐包 PASS/WARN/FAIL，FAIL 就非零退出；`gap check` 回答“在这个环境里哪些包现在能跑”，每个失败给修复提示；缺模型权重只是 WARN 不是 FAIL——“nothing installs behind your back”（不会背着你装东西）。贡献指南要求：一个包 = 一个目录 = 一个 PR，脚手架自动生成 SKILL.md + scripts/ + 单元测试骨架；写 SKILL.md 前先定 frontmatter 规范（name 必须等于目录名，description 第三人称、以“Use when…”结尾）；声明运行需求用 `gap.requires:`（要不要 GPU、环境变量、权重）；模型要懒加载（import tools.py 时不许 import torch）；没硬件也能测（FakeContext + make_test_observation），交 PR 前跑 `gap skills check && gap skills test my-skill && pytest`。

**例子给得怎么样**：例子是机器可读的 JSON 子图 + 脚本，不是散文例子；对新手不友好，但对“让 agent 照着跑”是最实在的。

**值得抄**：① `exit_conditions`（每课 / 每个模式加“做到什么样算会”，11-20 已记过这条，这次看到完整形态：它是 frontmatter 里声明的、给下游路由用的，不是正文里随口一说）；② 技能与工具分离（skills/ 管策略，tools/ 管可调用的计算——对应我们：`rapid/` 例程是策略，`python/` 联动是工具，现在混在一个技能里，可以学它把分界写清）；③ 自查命令（`gap skills check` 式的一键检查——我们没有可跑的检查，下一步可抄的是给 SKILL.md 加一条“自查清单”命令式写法，哪怕先是人工逐项打勾）；④ README 表格自动生成（我们的 comparison.md 是手写的表，行数多了会过时，可学它在表头注明“此表由 XX 生成”，先从注明来源做起）；⑤ frontmatter 规范写死（name 等于目录名、description 第三人称 + “Use when…”结尾——我们 SKILL.md 的 description 已是这个写法，可以写进仓库 CONTRIBUTING 式的一小节，免得以后改乱）。

**我们写得比它好的地方**：它是给 GaP 引擎用的注册表，不教人；我们教新手。它的技能一个比一个专（31 个技能全是抓取/感知/线缆细分），没有“从 0 到 1”的整条线；我们的 full-pipeline 6 段是它没有的。

### 3. addyosmani/agent-skills —— 技能解剖结构和“验证不可协商”的标杆

**页面看到的**：119,529 星、12,422 fork、866 提交，2026-02-15 建，MIT。26 个技能（25 个生命周期技能 + 元技能 `using-agent-skills`），10 条斜杠命令（/spec、/plan、/build、/test、/constraints、/review、/webperf、/a11y、/code-simplify、/ship），5 个评审 persona（code-reviewer、test-engineer、security-auditor、web-performance-auditor、accessibility-auditor），7 份共享检查清单（references/ 下：definition-of-done、testing-patterns、security-checklist、performance-checklist、accessibility-checklist、observability-checklist、orchestration-patterns），evals/ 下 26 个案例文件（路由评估进 CI），scripts/ 13 个脚本。README 开头一张 DEFINE → PLAN → BUILD → VERIFY → REVIEW → SHIP 流程图，每个阶段一句话原则（Spec before code、Tests are proof……）。

**SKILL.md 写法**：每个技能固定解剖结构，README“ How Skills Work”一节画出来了：Frontmatter（name 小写连字符、description 写“Guides agents through [task]. Use when…”）→ Overview → When to Use → Process → Rationalizations → Red Flags → Verification。设计上写明三点：① Process, not prose——技能是 agent 照着走的工作流，不是参考文档，每步有检查点和退出标准；② Anti-rationalization——每个技能一张“常见借口 + 反驳”表（比如“我以后再补测试”）；③ Verification is non-negotiable——每个技能结尾都是证据要求（测试通过、构建输出、运行时数据），“Seems right is never sufficient”（感觉对了不算数）。还有 Progressive disclosure：SKILL.md 是入口，参考文件只在需要时加载，省 token。

**验证关口**：TDD 技能（`skills/test-driven-development/SKILL.md`）是代表：先“Discover the Stack First”（先搞清这个仓库用什么命令跑测试，再动手，不许假设是 npm test）；RED → GREEN → REFACTOR 循环，每步画状态（Test FAILS → Test PASSES → Tests still PASS）；修 bug 用 Prove-It Pattern（先写复现 bug 的测试，再修）；测试金字塔 80/15/5；“Test State, Not Interactions”（断言结果，不断言内部调用顺序）；浏览器改动要加 Chrome DevTools MCP 运行时验证。README 还坦白一个可移植短板：单装一个技能时，仓库级的 references/ 目录不会跟着复制，共享检查清单就没了，这个缺口在 issue #361 跟踪——敢把自己的短板写进 README。

**例子给得怎么样**：例子是 TypeScript 代码片段 + 流程图 + 检查清单三件套；每步都有“这一步结束时你手里应该有什么”。

**值得抄**：① 固定解剖结构 Overview / When to Use / Process / Rationalizations / Red Flags / Verification（我们 SKILL.md 有 When to use 分流表和 Verification gate，但缺 Rationalizations 和 Red Flags 两节——最该抄的就是这两节：新手最常见的借口是“仿真跑通就行了”“点位差不多就行”，每条配一句反驳）；② “Verification is non-negotiable + 感觉对了不算数”（我们已有“没跑通不算会”，可以学它把证据要求写得更死：仿真跑通要贴哪三样东西——报错截图、轨迹、碰撞检查结果）；③ definition-of-done（项目级统一标准）vs 每任务验收标准分开写（我们 simulation-checklist.md 是任务级检查，缺一个“这个库里什么叫完成”的总标准）；④ 共享检查清单放 references/、技能按需引用（我们 references/ 已有 5 个文件，缺的是像它那样在 README 里一张表列清每份清单是干什么的）；⑤ 把自己的短板写进 README（issue #361 式——我们也可以在 comparison.md 或 README 里写清已知短板，我们其实已经在 README 写了点位是教学值，继续保持）。

**我们写得比它好的地方**：它是通用工程技能，不讲机器人；我们是 ABB 专精。它的技能是给 agent 照着走的流程，26 个技能互相咬合，对新手来说门槛高；我们一个技能 + 分流表，新手一眼知道先读什么。

### 4. mattpocock/skills —— seams、反模式和“一次一小片”的范本

**页面看到的**：329,578 星、27,690 fork、559 提交，2026-02-03 建，MIT。README 开头不是功能列表，是“为什么有这些技能”——四个失败模式，每段配一句名人名言：① agent 没按你想的做（对齐问题，解法是 grill-me 追问）；② agent 太啰嗦（缺共享语言，解法是 GLOSSARY.md）；③ 代码跑不起来（缺反馈循环，解法是 TDD）；④ 搭出一团泥（缺设计，解法是每天关心模块深浅）。技能分两类：User-invoked（只有你敲命令才触发，负责编排，比如 grill-me、triage、implement）和 Model-invoked（agent 判断任务合适就自动用，比如 tdd、code-review、diagnosing-bugs），并写明“user-invoked 可以调 model-invoked，但绝不能调另一个 user-invoked”。还有路由器技能 ask-matt（问你现在的情况，告诉你该用哪个技能）和一次性配置技能 setup-matt-pocock-skills（每仓库跑一次，问你要用什么 issue 跟踪器、标签、文档放哪）。

**SKILL.md 写法**：以 tdd 为例（`skills/engineering/tdd/SKILL.md`，页面上全文只有 56 行，很薄）：开头先定“什么是好测试”（测行为，不测实现；好测试读起来像规格说明书），再讲 Seams（测试缝：你能从外面观察到行为的公开边界），然后三条反模式，最后三条循环规则。薄，但每句话都有限制力。配套参考文件 tests.md、mocking.md、refactoring.md、interface-design.md、deep-modules.md（后两个已在新版里挪进共享技能 codebase-design，tdd 只引用它的词汇）。

**验证关口**：tdd 的核心是三条反模式 + 三条规则。反模式：① Implementation-coupled（mock 内部协作者、测私有方法、走旁路验证——一重构就断的测试）；② Tautological（断言用和代码一样的算法重算期望值，永远通过，等于没测——期望值必须来自独立来源：已知正确的字面值、算好的例子、规格）；③ Horizontal slicing（先写全部测试再写全部实现——测的是想象出来的行为，要改成 vertical slices：一次一个测试、一个实现，像曳光弹一样一发一发打）。规则：Red before green（先写失败的测试，只写够通过的最少代码，不许提前写下一个测试的代码）；One slice at a time（一个缝、一个测试、一个最小实现）；Refactoring is not part of the loop（重构不属于红绿循环，归 code-review 阶段管）。还有一条硬规矩：**Test only at pre-agreed seams**——写任何测试之前，先把要测的缝写下来、跟用户确认，没确认的缝不写测试。diagnosing-bugs 技能是另一条验证链：先让反馈变红（复现 bug）→ 最小化 → 假设 → 插桩 → 修 → 回归测试，分阶段设门。implement 技能收尾必须过 code-review 再提交；pr 技能要求 PR 正文先给“最小可视化总结”，再给改前改后证据，最后给合并危险判断（单向门还是双向门、波及面）。

**例子给得怎么样**：例子少而精。tdd 全文 56 行，例子都在 tests.md 里；README 里 GLOSSARY 的例子最有名：BEFORE“一节课里的一个 lesson 被变成 real（即在文件系统里占个位置）时出问题” vs AFTER“materialization cascade 出问题”——共享语言让 agent 少说 20 个词。

**值得抄**：① Seams（测试缝）概念（对应我们：仿真验证之前，先写清“这次验证看哪几个公开点”——比如轨迹对不对、IO 对不对、碰撞有没有，而不是笼统说“跑一遍”；可写进 simulation-checklist.md 开头）；② 反模式三条要逐条有“怎么认出来”（tell：重构就断的测试就是 implementation-coupled；永远通过的就是 tautological——我们 troubleshooting.md 是报错对号表，缺的是“写错了的程序长什么样”的反模式一节）；③ Horizontal slicing 禁令（对应我们：不要一次把 10 个例程全改完再跑，一次只改一处、跑一遍——我们 SKILL.md 验证闭环第 4 步已有“一次只改一处”，可以学它给这条起个名、写清为什么）；④ 重构不属于红绿循环（对应我们：改代码和整理代码分开——仿真跑通后再整理，不要边改边整理）；⑤ GLOSSARY.md 共享语言（我们 RAPID 术语散在各文件里：tooldata、wobjdata、robtarget……可以学它单独一份术语表，让每次回答用词一致）；⑥ ask-matt 式路由器（我们 SKILL.md 开头的分流表就是个小路由器，可以学它加一句“不知道该用哪个，先问我”）。

**我们写得比它好的地方**：tdd 只有 56 行正文，靠参考文件撑着；我们 SKILL.md 是完整的一份，新手不用跳来跳去。它的技能是个人经验提炼，没写“学完怎么算会”；我们有 30 课 + 验证关口。它的 README 把“为什么”讲透了，这点我们 README 可以学——现在 README 是功能列表，缺一段“为什么要先仿真”。

### 5. alchaincyf/nuwa-skill（女娲）—— “把理解变成技能”的造技能方法

**页面看到的**：38,750 星、4,943 fork、82 提交，2026-04-05 建，MIT。仓库根目录只有一个 SKILL.md（女娲本体）+ references/（提炼方法论）+ examples/（已蒸馏的人物示例，含完整调研数据）。README 是中文主版，另有 EN/JA/KO/ES 四种语言版。开头先给效果示例（Naval、马斯克、乔布斯三段真实对话），再讲安装——例子在前、安装在后。已蒸馏 14 个人 + 1 个主题（X 导师），每人独立仓库、一行命令可装。作者花叔，另有“达尔文.skill”（让所有 skill 持续进化的实验循环：8 维度评估、棘轮机制只保留改进、自动回滚退步）。

**SKILL.md 写法**：女娲本身是个“造技能的技能”，五步流程写在 README“工作原理”一节：① 先写先验快照——调研之前，先把模型不查资料就知道的写下来，之后调研只找三种东西：推翻它的、比它深的、它没有的，模型本来就答得出的内容不占 skill 篇幅；② 采集与封存——著作、播客、访谈、社交媒体、批评者视角、决策记录、人生时间线各自存档，同时封存一批此人真实做过的决策和完整回答，不给提炼环节看，留到最后当考题；③ 提炼——5–8 个招式（遇到某类问题他具体怎么做）、3–7 个心智模型、决策启发式、带出处的案例卡、至少 2 条常见误读、声音、张力与边界；心智模型过三重验证：跨 2+ 个领域出现过、能推断对新问题的立场、不是所有聪明人都会这么想；④ 成形——产物分三层：350 行以内的 SKILL.md、案例库 references/casebook.md、原话库 references/voice.md，每个 skill 自带七条运行纪律（比如“材料里没有，不等于他没说过”“原话和推演分开说”）；⑤ 验证——独立 agent 盲测：同一组任务题，带 skill 和不带 skill 各答一遍，评审不知道哪份是哪份，再加封存题和边界题，结果写进 FIDELITY.md，输了也照写。

**验证关口**：保真度评分卡（references/fidelity-scorecard.md）：15 个官方 skill 全部通过独立双 agent 盲测（立场一致性、风格辨识度、边缘诚实度、来源透明度、结构完整度），全员 A 级（≥85 分），各人分数全公开：97 分一批（MrBeast、纳瓦尔、塔勒布、乔布斯、Karpathy、Paul Graham、张雪峰）、96 分（芒格、费曼、X 导师）、95（特朗普）、94（Ilya）、93（张一鸣）、91（孙宇晨）、89（马斯克）。每个 skill 目录内有自己的 FIDELITY.md。贡献规则也写明：SKILL.md 是核心资产，不接受外部 PR 改动；社区蒸馏的人物走 COMMUNITY.md 索引，放自己仓库（star 归你），跑一遍评分卡到 B 级以上，提一行 PR 即可收录。

**例子给得怎么样**：最好的一家。README 开头三段对话就是例子（用户问精力不够，Naval 答“每个欲望都是你跟不快乐签的合同”；问获客成本高，马斯克答“先算物理极限”；问 OpenAI 和 Anthropic 谁对，乔布斯答“这是品味竞赛”）。每个例子都先讲“他用的哪个心智模型”，不是复读语录。examples/ 里每个示例含完整调研文件，调研过程全透明。

**值得抄**：① “先写先验快照”（对应我们：补技能前先写“模型不用查就知道什么”，只补查完才知道的——我们 learned.md 现在是问答记录，可以学它加一句“这个问题不用查就能答的，就别写进来”）；② “封存考题”（对应我们：每次学新东西，留两道题不给答案，下次验证技能是不是真学会了——我们 SKILL.md“判断技能是不是真变聪明了”三点是事后判断，它是事前封题，更严）；③ 产物分三层（350 行内 SKILL.md + casebook + voice——对应我们：SKILL.md 是入口，references/ 是案例库，rapid/ 是例子，三层已经有了，缺的是像它那样写清每层的行数/作用上限）；④ 保真度评分卡（同一任务带 skill vs 不带 skill、盲测、分数公开、输了照写——对应我们：可以给 30 课做一张“学会没”评分表，不用双 agent 那么重，先从“同一问题，学前学后对照”做起）；⑤ 每个 skill 写清“诚实边界”（它每人三条：蒸馏不了直觉、捕捉不了突变、公开表达不等于真实想法——对应我们：SKILL.md 已有验证关口，可以再加一条“本技能不知道什么”）；⑥ 例子在前、安装在后（我们 README 开头是徽章和能力地图，可以学它把一段“新手问、助手答”的真实对话放前面）。

**我们写得比它好的地方**：它是造“人的思维”技能，我们是造“机器人的手艺”技能——我们的例程是真能跑的代码，它的例子是对话。我们的“边问边学”循环（记下来、找缺口、补进技能、问学会没、同步）跟它的五步蒸馏法思路相通，但我们是每问一次就转一圈，比它更勤。它的 skill 是 350 行上限的提炼，我们的 SKILL.md + references 是教学用的完整手册，目标不一样，不必照抄行数。

### 值得抄的清单（按优先级）

下面每条写清出自哪家、用到我们仓库的哪个文件。只列这次亲眼看到的写法，不列没看到的。

1. **每课 / 每个模式加“做到什么样算会”（exit_conditions）**——出自 graph-robots/open-robot-skills（frontmatter 里 `exit_conditions`，下游路由就靠它）。用到 `skill/robot-rapid/SKILL.md`（验证关口一节）和 `docs/beginner-roadmap.md`（30 课每课末尾加一行“算会的标准”，比如 01 例程：虚拟控制器跑通 + 碰撞检查通过 + 换个点位再跑通）。这是 11-20 就记过的缺口，这次看到完整形态，优先级最高。
2. **补 Rationalizations（常见借口 + 反驳）和 Red Flags（危险信号）两节**——出自 addyosmani/agent-skills（每个技能固定有这两节）。用到 `skill/robot-rapid/SKILL.md`：借口比如“仿真跑通就行了”“点位差不多就行”；危险信号比如“一次改了三处还说不清哪处起作用”“仿真没跑就说程序写好了”。我们已有分流表和验证关口，缺的就是这两节。
3. **验证关口写死“证据要求”，感觉对了不算数**——出自 addyosmani/agent-skills（Verification 一节：测试通过、构建输出、运行时数据三样证据）和 mattpocock/skills（pr 技能：改前改后证据 + 合并危险判断）。用到 `skill/robot-rapid/references/simulation-checklist.md`：跑通一次要贴三样——报错截图或“无报错”、轨迹对不对、碰撞检查结果；缺一样就不算跑通。
4. **“同一提示，有技能 vs 没技能”对照表（RAPID 版 evals）**——出自 arpitg1304/robotics-agent-skills（evals/EVAL_REPORT.md：同一段 ROS2 需求，没技能 0 行测试 vs 有技能 601 行测试）和 alchaincyf/nuwa-skill（同一组题带 skill vs 不带 skill、盲测、分数公开）。用到 `docs/comparison.md`（本文件，新起一节）或新建 `docs/evals.md`：拿一段搬运需求，没技能 vs 有技能写出来的 RAPID 对照，写清测试行数、IO 处理、报错处理三项，不夸大（arpitg 自己也写明单次对比不算基准测试）。
5. **Seams（测试缝）：验证前先写清看哪几个公开点**——出自 mattpocock/skills（tdd：Test only at pre-agreed seams，写测试前先把缝写下来跟用户确认）。用到 `skill/robot-rapid/references/simulation-checklist.md` 开头：每次仿真验证前先列“这次看什么”（轨迹、IO、速度、碰撞），不列就不跑；对应它“没确认的缝不写测试”。
6. **反模式一节：写错了的程序长什么样、怎么认出来**——出自 mattpocock/skills（tdd 三条反模式，每条有 tell：重构就断的测试、永远通过的测试）和 arpitg1304/robotics-agent-skills（What Good Skills Contain：失败模式 + 反模式）。用到 `skill/robot-rapid/references/troubleshooting.md`（现在是报错对号表，加一节“常写错的 RAPID 反模式”，比如 MoveL 一路用 fine、该用 MoveAbsJ 回零却用 MoveJ、IO 不等信号就往下走）。
7. **一次只改一处，起个名、写清为什么**——出自 mattpocock/skills（One slice at a time + 拒绝 horizontal slicing：一次写全部测试再写全部实现，测的是想象出来的行为）。用到 `skill/robot-rapid/SKILL.md` 验证闭环第 4 步：已有“一次只改一处”，补一句为什么（一次改三处，跑通了也不知道是哪处起的作用；跑不通更不知道该回退哪处）。
8. **每份参考文件在 README 里一句话说清是干什么的**——出自 addyosmani/agent-skills（Reference Checklists 表：每份清单一句话）和 graph-robots/open-robot-skills（README 技能表每行一句话描述）。用到 `README.md`（能力地图表已有一半，补 references/ 5 个文件的用途说明，和 docs/ 6 个文件的用途说明）。
9. **“先写先验快照 + 封存考题”**——出自 alchaincyf/nuwa-skill（调研前写快照、封存真实决策当考题）。用到 `skill/robot-rapid/references/learned.md`（记答案时加一句“这个问题不用查就能答吗”；每学一个新点留一道题，下次先考再讲）和 `skill/robot-rapid/SKILL.md`（“判断技能是不是真变聪明了”三点后面加一条：封存的题答对了才算会）。
10. **README 开头放一段真实问答例子**——出自 alchaincyf/nuwa-skill（README 开头三段对话）和 mattpocock/skills（README 开头讲四个失败模式）。用到 `README.md`：在能力地图前面加一段新手问、助手答的真实对话（比如“从哪开始学 ABB？”），再讲“为什么先仿真”。
11. **GLOSSARY.md 共享术语表**——出自 mattpocock/skills（GLOSSARY.md 让 agent 少说 20 个词，变量、函数、文件命名一致）。用到新建 `docs/glossary.md` 或 `skill/robot-rapid/references/glossary.md`：tooldata、wobjdata、robtarget、jointtarget、fine、z50 这些词一句话讲清，以后回答用词一致。
12. **技能与工具分界写清**——出自 graph-robots/open-robot-skills（skills/ 管策略，tools/ 管可调用的计算）。用到 `skill/robot-rapid/SKILL.md` 开头：写清 `rapid/` 例程是策略（照着抄）、`python/` 是工具（发指令），别混着讲。
13. **把已知短板写进 README（输了也照写）**——出自 arpitg1304/robotics-agent-skills（0/10 也贴出来）和 addyosmani/agent-skills（issue #361 短板写进 README）。用到 `README.md`：我们已写“点位是教学值”，保持这个做法，每次发现短板就补一句，不藏着。
14. **贡献规范一小节：name 等于目录名、description 以“Use when…”结尾**——出自 graph-robots/open-robot-skills（Contributing a bundle：name == dirname、第三人称 description）和 addyosmani/agent-skills（CONTRIBUTING：specific、verifiable、battle-tested、minimal）。用到 `README.md` 或新建 `CONTRIBUTING.md`：写清以后加技能/加课的规矩，免得改乱。

### 本次对比后要改的结论（2026-11-22）

1. 五家里没有一家讲 ABB / RAPID / RobotStudio；11-20 的结论不变——核实范围内，Robot-RAPID 仍是唯一 SKILL.md 格式的 ABB 技能，“第一个”仍无法穷尽证实，不写。
2. 我们缺的不是内容量，是“让人信的写法”：exit_conditions、借口反驳表、危险信号、证据要求、反模式、封存考题。上面清单 1–7 是写法上的缺口，8–14 是呈现上的缺口。
3. 我们比五家强的地方：中文大白话新手教学（30 课）、每次提问都记下来边问边学的循环、从 0 到 1 的整条线（full-pipeline 6 段）。这三样别丢，抄写法时别把教学改成流程图。
4. 下次对比要补的：arpitg 的 harness 跑起来要什么环境（它要 Python 3.10+、Node.js 22+、ARMATURE 模拟器，只看了 README）；addy 的 evals/ 26 个案例文件具体怎么评路由（只看了 README，没打开 evals/）；nuwa 的 SKILL.md 本体（只看了 README_EN，没打开 SKILL.md 全文）。
