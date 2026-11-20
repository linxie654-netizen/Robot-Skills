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
| pixel-robotics/bt-rosbag-analysis（ROS 2） | ROS 2 行为树排障 skill + MCP | skill 本身就是一份可执行手册：标准查询都写好了（常坏节点、时间线），配好 MCP 就能跑 | 手册要能直接照着跑 → 已补：`references/rapid-patterns.md` 每个模式配代码和对应例程 |
| RavenClaude robotics 插件 | 机器人与自主系统工程插件 | 3 个专家 agent + 决策树知识库 + 模板 + 最佳实践；版本号、日期都钉死，写明“用前再核实” | 版本钉死 + 用前核实 → 已补：README 加版本行（RobotStudio 6.08、RobotWare 6、IRC5），数字都标核实日期 |
| awesome-gamedev-agent-skills | 79 个游戏开发 skill + 路由器 | 按引擎/学科/类型/流程分类编目，路由器按项目文件自动挑 skill；每个 skill 按官方文档写、钉死引擎版本、有 validator 和 evals | 编目 + 路由 → 本库只有一个 skill，不拆；改成 SKILL.md 内的分流表，相当于一个小路由器 |

**补完后的本库结构**：SKILL.md（11.8KB）+ references 6 个文件（learned、recipes、troubleshooting、rapid-patterns、smart-components、simulation-checklist）+ scripts 4 个 + INSTALL.md；库里另有 RAPID 例程 10 个、Python 2 个、docs 8 个。跟 PLC 那个插件比还是少（人家是多 skill + 校验器），下一步可补的是一个 RAPID 语法自查清单，但那要先有真机验证，暂时不写。

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

## 连接器：MCP 服务器（2026-11-20 查的，Q9）
- ABB RobotStudio MCP Server（PMinhDuc204/abb-robotstudio-mcp6.08，v3.1.0）：TypeScript MCP 服务器 + ClaudeBridge C# 插件，63 个工具（33 个 `rs_*` + 30 个 `rws_*`），明确针对 Windows 上 RobotStudio 6.08【6070933143947009701†L7-L11】。`rs_*` 经 HTTP 到插件 127.0.0.1:58080 再调 RobotStudio SDK，能查工作站、读/写 RAPID、控制仿真、截图；`rws_*` 到控制器 RWS，能启停程序、读写变量和 IO【6070933143947009701†L36-L41】。
- 另两个同类：zhou-zhichao/robotstudio-mcp（论文里的桥，16 个工具，插件本地 HTTP API 走 8080 端口）【3692441608099880613†L48-L54】；Lagun271 RobotStudioMCP（55 个工具，针对 RobotStudio 2026，不是 6.08）。
- RWS 本身：IRC5/RobotWare 6 是 RWS 1.0，HTTP Digest，端口 80；OmniCore/RobotWare 7 是 RWS 2.0，HTTPS，端口 443；默认账号 Default User / robotics【6070933143947009701†L129-L136】。
- 结论：想让 AI 操作 6.08，路 1 的 MCP 是唯一对口 6.08 的；但它是给支持 MCP 的 AI 客户端用的，Muse 这个聊天不能直接接你电脑上的 stdio MCP。最简单的连接器仍是 RWS，本库 Python 例程已在用。

## 新手教程来源（2026-11-20 查的，Q6）
- plcprogramming.io《ABB Robot Programming Tutorial 2026》：RAPID 结构、4 种编程方法、RobotStudio 离线流程、MoveJ/MoveL、工具/工件。【9018129499109220005†L9-L16】
- RobotIndus3 RAPID 教程：15 课、6 小时+，从 MODULE、变量、IF/FOR/WHILE/TEST、MoveJ/MoveL/MoveC/MoveAbsJ、IO、函数、报错处理到生产程序；免费、带浏览器 3D 模拟器。【9018129499109220005†L78-L86】
- TryPLC ABB RAPID：RAPID 是 Pascal 风格强类型语言，模块 + PROC main 入口，Move 一行包含目标、速度、区域、工具；IRC5 到 OmniCore 大部分 RAPID 通用。【4507421519131795109†L112-L115】
- CMU Future CNC RobotStudio 教程：10 步建基础程序（Jog Joint、Teach Target、建 Path、同步到虚拟控制器、仿真播放），另有加工具的 10 步。【8932007933019643557†L19-L29】
- AYE Tech Hub Lesson 04：IRB 系列、IRC5、RobotStudio、RAPID、MoveL/MoveJ、IO、速度/区域/工件/工具。【4507421519131795109†L15-L17】
- 共识路线已写进 `docs/beginner-roadmap.md`，共 12 课 + 6 个新手常犯错。

## 下次对比要补的
- 每个库的最近更新时间、是否还在维护。
- RobotStudio 最新版本号和下载链接复核。
- 用户定下机器人型号后，按型号补“该型号在各库里的支持情况”。
