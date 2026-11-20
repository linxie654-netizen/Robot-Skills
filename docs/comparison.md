# 网上 ABB 编程 APP / 库对比学习

更新：2026-11-20。只写已核实的内容，没核实的标“未核实”，不编 Star 数和功能。
来源：GitHub 实查页面 + 官方说明。ABB 官方没有在 GitHub 放完整 RAPID 教程库。

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
