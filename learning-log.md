# ABB 学习提问记录

规则（用户 2026-11-20 定）：每次在这个窗口提问，都记下来；然后反复学习、对比网上所有 APP / 库的编程技术，做对比学习。
对比结果见 `docs/comparison.md`，随新问题持续更新。

## 提问记录

### Q1 — 2026-11-20 08:48
- 问题：这个聊天窗口是我学习 ABB 代码编程窗口，你要辅助我填好编程，教程还有 RobotStudio 教程仿真辅助，而且会代码编程吗？有没有编程库技能 skill？
- 回答要点：会 RAPID；当时没有现成的 ABB / RAPID / RobotStudio 专用 skill；可按 GitHub 优先原则查开源项目，需要就建专用 skill。
- 跟进：用户选了建 ABB 编程库。

### Q2 — 2026-11-20 08:49
- 问题：GitHub 没有？
- 回答要点：有，但没有一个大而全的官方 RAPID 教程库，都是散的小项目。
- 核实结果（2026-11-20 实查 GitHub 页面）：
  - `rpiRobotics/abb_motion_program_exec`：32 星，Python 发 MoveJ/MoveL/MoveC 指令，支持 IRC5、EGM、双机。
  - `RobotComponents/RobotComponents`：77 星，1475 提交，69 发布，Grasshopper 里画轨迹、仿真、生成 RAPID，40 多种 ABB 模型。
  - `rparak/ABB_EGM_Python`：21 星，Python 经 EGM 控制 IRB 120 / YuMi IRB 14000，带 RobotStudio 工程。
  - `FLo-ABB/Hershey-ABB-Robot-Handwriting`：Python 把字体转 RAPID 写字，带 RobotStudio 仿真。
  - 结论：ABB 官方没有在 GitHub 放 RAPID 教程库，RobotStudio 和 RAPID 手册走 ABB 官网。

### Q3 — 2026-11-20 08:50
- 问题：帮我建一个 ABB 编程库
- 执行：建 `~/workspace/abb-library/` + 自定义 Skill `abb_robot_programming`；已拉取上面 3 个仓库到 `vendor/` 做参考源，保留原仓库和协议，不冒充自己的代码。

### Q4 — 2026-11-20 08:50
- 问题：我每次向你提问，你都要记录下来，然后反复的学习对比网上所有 APP 库所有的技编程，做一个对比学习
- 执行：立本文件为提问记录；`docs/comparison.md` 为对比学习表，每次新问题都回来补记、补对比，不是一次写完就不管。

### Q5 — 2026-11-20 08:53
- 问题：ABB，每次我向我提问学习中，然后做成 skill，每次都加深一点，你上传到 GitHub 上
- 执行：新规则已记入 MEMORY.md 和 Skill；每次提问 = 记入本文件 + 更新对比表 + 加深 Skill 一步 + 同步 GitHub。仓库名待定，GitHub 账号 linxie654-netizen（同低压电工仓库账号）。
- 本次加深内容：Skill 增加“每次提问迭代 + GitHub 同步”一节；库整理成可上传的 Git 仓库，vendor 参考源不直接上传大文件，改放链接清单。

### Q6 — 2026-11-20 08:53
- 问题：网上不是有很多编程吗？你去看一下有哪些需要新手学习的，都学习一下，写进去
- 执行：已上网查完新手必学内容，写进库里。新增 `docs/beginner-roadmap.md`（12 课路线 + 6 个常犯错），新增 RAPID 例程 07 圆弧、08 TEST/CASE+函数、09 报错处理、10 模拟量 IO+WaitUntil；对比表补了 5 家新手教程来源。GitHub 已上传完成：公开仓库 https://github.com/linxie654-netizen/abb-robot-programming ，21 个文件，5 次提交，已复核仓库主页能打开、README 正常渲染。

### Q7 — 2026-11-20 10:16
- 问题：这一个有什么用啊
- 回答要点：指 GitHub 上的 ABB 编程库。它是你的 ABB 学习仓库：RAPID 例程、RobotStudio 教程、Python 联动、新手路线、速查、对比表、提问记录都在里面；换电脑、换手机也能打开，不会丢；每次提问都往里面加深，越学越全。
- 本次加深内容：README 开头加“这个库有什么用”一节，说清用途；下次同步时一起传到 GitHub。

### Q8 — 2026-11-20 10:18
- 问题：能不能接入 robotstudio 6.08 里面帮我操作
- 回答要点：不能直接接入用户电脑上的 RobotStudio 6.08 操作。Muse 在云端，没有 RobotStudio 连接器，RobotStudio 是本地 Windows 桌面软件、不是网页，不能远程点鼠标。能做的：一步步带操作、给可导入的 RAPID / 工作站文件、看截图和报错帮改。
- 本次加深内容：教程补 RobotStudio 6.08 说明（RobotWare 6 时代、IRC5，本库 RAPID 例程兼容；Wizard / OmniCore 是更新版本的功能，6.08 没有）；Skill 补“不能直连本地 RobotStudio，改用文件 + 截图指导”一条。

### Q9 — 2026-11-20 10:21
- 问题：连接器怎么搞
- 回答要点：RobotStudio 本身没有给 Muse 的现成连接器，但有 3 条路：1）MCP 服务器 + ClaudeBridge 插件，直接对 6.08（PMinhDuc204/abb-robotstudio-mcp6.08，63 个工具）；2）RWS（控制器内置 Web API，http://localhost:80，Default User / robotics），本库 Python 例程就是走这条路，最简单；3）ABB PC SDK（C#，官方）。
- 本次加深内容：新增 `docs/connectors.md`，写清 3 条路的原理、安装步骤、能干什么、不能干什么；对比表补 MCP 服务器一项。注意：MCP 是给支持 MCP 的 AI 客户端用的，Muse 这个聊天不能直接接你电脑上的 stdio MCP；先在虚拟控制器上试，别上真机。

### Q10 — 2026-11-20 10:23
- 问题：1（选了连接器第 1 条路：MCP 服务器 + ClaudeBridge 插件）
- 执行：新增 `docs/mcp-install-6.08.md`，按项目 README 原步骤写清检查、安装、启动、验证 4 步；先让用户在自己电脑上跑检查命令（node、dotnet、RobotStudio 路径），报结果再往下装，不跳步。

### Q11 — 2026-11-20 10:27
- 问题：我叫别的 ai 装，有什么说的
- 回答要点：给了一段可直接复制给另一个 AI 的安装指令：项目、路径、检查、安装、启动、验证、只在虚拟控制器上试、不碰真机、装完报结果和报错原文。
- 本次加深内容：新增 `docs/other-ai-prompt.md`，放可复制的完整指令。

### Q12 — 2026-11-20 12:37
- 问题：检查结果：Node.js v24.16.0（不是 20）、npm 11.13.0、.NET SDK 未安装（只有 8.0.22 运行时）、RobotStudio 6.08 找到、Newtonsoft.Json.dll 找到、git/网络正常、RobotStudio 未运行
- 回答要点：只差 .NET SDK 一项，其他都通。Node 24 先试，不行再降到 20；.NET 运行时不等于 SDK，必须装 .NET 8 SDK，net461 引用程序集靠 NuGet 恢复或装 4.6.1 Developer Pack。
- 本次加深内容：`docs/mcp-install-6.08.md` 补检查结果诊断和 .NET SDK 安装步骤。

### Q13 — 2026-11-20 13:10
- 问题：githup有这个mcp吗
- 回答要点：有，PMinhDuc204/abb-robotstudio-mcp6.08，Glama 页源码链接指向该仓库；直接打开 GitHub 页时报网络错误、不是 404，未能直接拉到仓库页，已如实说明。
- 本次加深内容：`docs/mcp-install-6.08.md` 补 GitHub 仓库地址和 clone 命令。

### Q14 — 2026-11-20 13:29
- 问题：用户发来本地路径 C:/Users/xie/Documents/Trae-CN/default/ABB-RobotStudio-MCP-安装报告.md
- 回答要点：我这边读不到用户 Windows 电脑本地文件，只能请用户把报告内容贴过来或在聊天里上传文件，再复核安装结果。

### Q15 — 2026-11-20 13:34
- 问题：用户把另一 AI（Trae CN）做的《ABB RobotStudio MCP Server 安装报告》全文贴过来，请复核。
- 复核结论：安装、构建、桥接、MCP 配置全部完成；6 项只读验证通过 5 项。Node 20.20.2（便携）+ .NET SDK 8.0.428（便携），系统 Node 24 未动；npm ci/build/test 5/5 通过；ClaudeBridge 插件编好、RobotStudio 带 /addin 加载成功，ping 通（stationOpen=true，ABB1115）；Trae CN 的 MCP 配置已写好；63 个工具可列。工作站 ABB1115.rsstn，虚拟控制器 ABB1，任务 T_ROB1，状态 motoron / AUTO / stopped。
- 未通过项 rs_read_module：不是安装问题，是控制器上没装载 RAPID 程序。诊断可信：SDK 直连测得 SaveProgramToFile 报 C0049004（程序名未设置）、RWS 文本端点 404（该 VC 未实现）；上游 README 也写了 6.08 模块端点不匹配是已知问题。要过这一项须在 RobotStudio 里给 ABB1 装载程序（改控制器状态，不产生运动），建议直接装库里的 01_move_basics.mod 再重试。
- 未修 bug（报告第 7 节）：#5 高——rws_get_modules 用的 RWS 端点在该 VC 返回 404，可用端点是 /rw/rapid/modules?task=T_ROB1；#6 中——rws_list_files 传 "$HOME" 被判非法；#7–#9 低——版本号三处不一致、npm audit 3 漏洞、TS 依赖放错位置。
- 启动注意事项：RWS 端口每次启动 VC 都会变（本次 19404），须跑 refresh-rws-url.ps1 刷新；脚本启动 RobotStudio 须用 WMI 脱离进程树，否则几十秒后被回收；释放 mastership 后约 3 秒内 rws_controller_status 会短暂 503，属控制器行为；TIA Administrator V3 服务崩溃重启循环（77+ 次）与安装无关，但干扰日志排查；强杀 RobotStudio 会遗留 RobVC.exe 锁工作站，须同时结束。
- 报告小出入：第 3 节说改了 3 个文件，第 9 节说“仅涉及 2 个源文件”，数对不上，不影响结论。
- 机器人型号：报告未给，只给了工作站和控制器名，仍未确认。
- 本次加深内容：docs/mcp-install-6.08.md 补实际安装结果、未通过项根因、未修 bug、启动注意事项；同步 GitHub。

### Q16 — 2026-11-20 13:44
- 问题：能不能做一个所有人都可以安装的 skill 和 mcp
- 回答要点：能，分两件。Skill：原来只存在本机，路径写死 ~/workspace/...，别人装不了；改成通用相对路径，放进公开仓库 skill/ 目录，加 INSTALL.md，任何人 clone 就能装。MCP：服务器是别人开源的项目（PMinhDuc204，MIT 协议），不能直接说成自己的；做法是 fork 到用户账号，合入另一 AI 在用户电脑上改的 3 个文件补丁，再修报告里未修的 #5、#6，加一键安装脚本。
- 本次加深内容：新增 skill/SKILL.md（通用版，相对路径，加 MCP 一节）、skill/INSTALL.md（Muse / Claude Code / 其他助手三种装法，中英双语）、README 补 skill/ 目录和安装说明。
- MCP 进展（13:48–13:53）：补丁文件已收到（261 行，3 个文件，+122/-42，与报告一致）；本地克隆上游仓库触发执行风险检查，已删本地克隆，不在本地跑补丁和构建；fork 已建（linxie654-netizen/abb-robotstudio-mcp6.08，15 次提交，HEAD a782f78）；一键安装脚本 install.ps1 与 fork 说明草稿已写好（Node / .NET 下载链接核实 200）；#5、#6 修复方案已定位代码位置并写好（FIX-5-6.md）。
- MCP 完成（14:00–14:03）：用户发来 zip（3 个改好的文件），逐项核对通过——#5 端点在 index.ts 491 行、#6 正则在 538 行、补丁关键改动（SyncModuleToStation、mastership、RWS 兜底、`$HOME/*` 已清、Content-Type）全在；另一 AI 在用户电脑上 npm run build 已通过。5 个文件传到 fork：3f7529d（addin）、8a3eccd（src 两个）、eac9090（install.ps1 + README），仓库现 18 次提交，README 顶部“本 fork 的说明”已验证。
- 未验证项：#5/#6 修复尚未在真控制器上跑过；rs_read_module 仍需装载程序后验证；install.ps1 未在实机上跑过。

### Q17 — 2026-11-20 14:02
- 问题：现在 MCP 还差什么？还能从 0 到 1 创建工作站、添加机器人、添加编程、Smart 组件吗？
- 回答要点：按 fork README 的工具表（63 个：33 个 rs_* + 30 个 rws_*）逐项核对。创建工作站：没有创建工具，只有 rs_get_station / rs_get_station_objects / rs_save_station，不行。添加机器人：没有任何加机器人工具，不行。添加编程：可以，rs_write_module、rs_validate_rapid、rs_create_path、rs_create_target、rws_write_module、rws_load_module_from_file、rws_load_program。Smart 组件：没有任何相关工具，不行。结论：MCP 只能操作已经打开的工作站，不能从 0 到 1 建站；要补建站、加机器人、Smart 组件这三件，须在 ClaudeBridge 插件（C# 端）新开发工具，不是改配置能解决的。
- 还差什么：#5/#6 修复尚未在真控制器上跑过验证；rs_read_module 仍需装载程序后验证；install.ps1 未在实机上跑过；机器人型号仍未确认；Muse 聊天仍接不进用户电脑本地的 MCP，只能由 Trae CN / Claude Code 在那台电脑上用。

### Q19 — 2026-11-20 14:19
- 问题：是从 0 到 1，从工作站创建，到机器人到示教器，到建模，组件到编程的一个全流程
- 回答要点：全流程 6 段，按顺序——工作站创建（rs_create_station 草稿已写未测）、加机器人（无工具，须先定型号；另涉虚拟控制器创建，论坛反映工作站加载后加 VC 是难点，待核实）、示教器（教目标点已有 rs_create_target、读位置已有，jog 点动无工具；虚拟示教器本身是界面，MCP 开不出来，只能做它对应的操作）、建模（无工具，SDK 可建几何/导 CAD，须核实调用）、组件（Smart 组件无工具，实例化调用待 PC 核实）、编程（已有，写模块/校验/路径/目标点/加载）。阶段图写进 docs/mcp-full-pipeline.md。
- 本次加深内容：docs/mcp-full-pipeline.md（6 段全流程，每段现有工具/缺失/待核实）。

### Q20 — 2026-11-20 14:24
- 问题：用户把“加机器人里建虚拟控制器、Smart 组件实例化、点动、建模的调用——这几处我还没核实，其中建虚拟控制器论坛上有人说做不出来”这句话贴回来，要核实
- 回答要点：4 处核实完——建模 ✅（Part.Load 导 CAD + Body.CreateSolidCone 建几何，ABB 官方示例和论坛实例）；Smart 组件 ✅（GraphicComponentLibrary.Load + RootComponent.CopyInstance + GraphicComponents.Add，ABB 论坛标准写法，CopyInstance 必须调）；点动 ⚠️（手动点动命令 SDK 里没有，ABB 工程师亲口确认；仿真侧用 Mechanism.SetJointValues 改关节角代替）；建 VC ❌（从 0 新建系统没找到 SDK 调用，建系统是 Installation Manager / System Builder 的活；启动已有 VC 已核实 RsIrc5Controller.StartAsync / RobVcFactory.StartVC）。核实结论写进 abb-mcp-fork/verification-notes.md；4 个新工具草稿写进 abb-mcp-fork/pipeline-tools/（rs_import_cad、rs_create_solid、rs_add_smart_component、rs_jog_joint），未测试。
- 本次加深内容：verification-notes.md + pipeline-tools/（handlers.cs、tools.ts、README.md）。

### Q21 — 2026-11-20 15:49（微信任务）
- 问题：微信发来 ABB RAPID 练习“牛刀小试”图片（rYuan 画圆、rFang 画方，nCount=1,3,5,7,9 画 100×60 方形，=2,4,6,8,10 画 R=40 圆，>10 停止）
- 回答要点：完整程序 mod_NiuDaoXiaoShi——main 用 WHILE nCount<=10 + MOD 2 判奇偶；rFang 用 MoveL+Offs 画 100×60 方形；rYuan 用两次 MoveC 拼 R=40 整圆；点位注明为示教值、需在 RobotStudio 重示教。文字结果 + .mod 文件已发回微信，文件在 wechat-bridge/results/7529454543215009160.mod。
- 本次加深内容：记录在案，未进 RAPID 例程库（微信任务，按需再入库）。

### Q18 — 2026-11-20 14:04
- 问题：怎么做（指补建站、加机器人、Smart 组件这三件）。
- 回答要点：三层套路，和现有工具一样——C# 插件加新端点（照 CreatePath/CreateTarget 的写法）→ MCP 服务器加新工具（调插件 HTTP 端点）→ 另一 AI 在用户电脑上编插件 + npm run build + 实测。建工作站已写出草稿 rs_create_station（new Station() + ActiveTask = DefaultTask + Project.ActiveProject，ABB 论坛实例写法，包在 UndoContext 里），未测试，待另一 AI 编测；已知坑：新工作站可能没 3D 图形窗口，论坛里的解法是加 GraphicControl + Camera（需 Stations.Forms 引用）。加机器人须先定型号，机器人库 .rslib 默认在 C:\ProgramData\ABB\DistributionPackages2，新型号要先在 RobotStudio 里下载。Smart 组件须对 SDK API 参考核实实例化调用，没编具体的调用名。顺序：工作站 → 机器人 → Smart 组件。
- 本次加深内容：station-tool/ 草稿（ClaudeBridgeAddIn.cs、index.ts、README，含编测步骤和已知不确定点）。

## 待用户确认的学习方向
- 机器人型号：未定（IRB 120 / 140 / 6700 / YuMi？）
- RobotStudio 是否已安装：已装，6.08；MCP 服务器 + ClaudeBridge 插件已通（2026-11-20，见 Q15）
- 当前水平：Python 初学；ABB 基础操作、J1-J6、空间坐标系正在学
- 下一步建议：先跑通 RobotStudio 虚拟控制器 + `abb_motion_program_exec` 的 MoveJ/MoveL 例子，再学纯 RAPID 搬运、IO、循环。

### Q21 — 2026-11-20 14:40
- 问题：做的这个 MCP 太难了，做 Skill 好一些
- 回答要点：停掉 MCP 工具开发，改做 Skill。全流程 6 段（工作站、机器人、示教器、建模、组件、编程）写成 Skill 版步骤，见 docs/full-pipeline.md：人照着在 RobotStudio 6.08 里点，助手给 RAPID 文件、检查清单、看截图改错，不用编 C# 插件、不用 Node/.NET 构建。建虚拟控制器只能走 Installation Manager / System Builder 界面建系统再加载，不能用代码从 0 建。station-tool/、pipeline-tools/ 的 MCP 草稿封存留档，不再编测。
- 本次加深内容：docs/full-pipeline.md（Skill 版 0 到 1 全流程）+ Skill 两处（本地与公开版）新增“0 到 1 全流程做 Skill、不做 MCP 工具”一节。

### Q22 — 2026-11-20 15:14
- 问题：用户发来 abb-robotstudio-bridge-merged-v1.zip，说“看看怎么搞，先说一下”，后又说“做”
- 回答要点：先按系统安全检查停下问确认，用户说“做”后才动手。核对完：包是上游 v3.1.0 + 本地修复 + 新功能 + 全局技能 robotstudio-ops 的整合版，共 50 个文件；工具从 63 个变 67 个（rs_* 37 + rws_* 30），新增 rs_new_station、rs_create_station、rs_save_station_as、rs_add_library_component；#5 已改走 /rw/rapid/modules?task=（index.ts 525 行）、#6 正则已放行裸 $HOME（565 行）；Add-In 新增 /station/new、/station/create、/station/save-as、/station/add-component、/exec；技能可用 HTTP 桥（127.0.0.1:58080）不用 MCP 客户端操作 RobotStudio。
- 本次加深内容：新增 docs/bridge-merged-v1.md（复核记录与安装步骤）；关键源文件整理上传到 fork linxie654-netizen/abb-robotstudio-mcp6.08（待浏览器上传结果）。
- 未验证项：新 4 个工具未在真控制器上跑过；新建虚拟控制器仍会失败（本机 RIM 层故障，INSTALL.md 已写明不要反复重试）；dist/ 与 artifacts/ 是构建产物，不进 GitHub。

### Q23 — 2026-11-20 15:22
- 问题：不是不要 MCP 了吗
- 回答要点：是，用户 14:40 已拍板停 MCP、改做 Skill，我错了。merged v1 包是 MCP + 技能的整合包，用户说“做”后我把 MCP 源文件也传到了 fork（第一批 src/addin 已传，3b63765、903d7f1，仓库 20 次提交），第二批正在传时用户纠正，我已立即停掉第二批浏览器任务。但停掉后浏览器任务的终态汇报说：第二批 9 个文件其实在停止前已传完，提交 35f0be7（INSTALL.md、package.json、tsconfig.json、技能 SKILL.md、recipes.md、4 个脚本均已在仓库），也就是说 MCP 的 package.json 也已上去了，无法撤回，只能在 fork 上说明或后续删。
- 教训：用户拍板停掉的决定不再做，哪怕用户后来发来含 MCP 的包、说“做”，也要先问清是不是只做技能部分，不要自己默认把 MCP 也带上。

### Q24 — 2026-11-20 15:24
- 问题：就创建一个 abbrobotstudio 的 skill，就一个就行了，其他的全部都删掉
- 回答要点：只留一个 ABB 技能 `abbrobotstudio`。新技能合并了 RAPID 教学、Python 联动、0 到 1 全流程（Skill 版）、桥操作（HTTP 桥 + 脚本 + C# 片段），MCP 新工具开发仍停掉。删掉的 ABB 技能：本地 custom-skills/abb_robot_programming、公开库 skill/ 旧 SKILL.md 与 INSTALL.md、fork 上的 skill/robotstudio-ops（待 GitHub 上删）、上传暂存 github-upload/bridge-merged-v1。非 ABB 的两个技能 verify_built_artifact、wechat_bridge_operations 不动。删掉的本地文件进了回收站，30 天内可恢复。
- 本次加深内容：新建 custom-skills/abbrobotstudio/（SKILL.md + skill.yaml）与公开库 skill/abbrobotstudio/（SKILL.md + INSTALL.md + scripts/ + references/），README  skill 一节已改指新路径；同步 GitHub 待浏览器结果。

### Q25 — 2026-11-20 15:25
- 问题：然后封面的话要搞好看点，然后要教怎么安装新手，技能有什么用
- 回答要点：封面指公开库 README 顶部。已重排：标题 + 徽章（RAPID 10 例程、RobotStudio 6.08、Skill abbrobotstudio、中文）+ 一句话说明，新增“这个技能有什么用”5 条、“新手安装：3 步”（下载库、装技能、问第一个问题，附 Muse / Claude Code / 其他助手三种装法和没装 git 时的 ZIP 下载办法），INSTALL.md 顶部也补了同样两节。
- 本次加深内容：README.md 封面重排；skill/abbrobotstudio/INSTALL.md 补“有什么用”与“新手安装 3 步”；同步 GitHub 待浏览器结果。

### Q26 — 2026-11-20 15:27
- 问题：这个 skill 用户可以边问，技能可以边学习，越来越懂，怎么做
- 回答要点：靠一个 5 步学习循环，每次提问都跑一遍：1 记下来（learning-log，原话 + 纠正也记）；2 找缺口（用户卡在哪、技能缺什么）；3 补进技能（新知识进 SKILL.md 或路线图、反复问的进 references/learned.md、新工具进 comparison.md、纠正过的写成铁规矩）；4 问一句学会没（用户回答决定继续还是再讲一遍）；5 同步 GitHub。判断标准三条：同样问题第二次不用再查、纠正过的错不再犯、新手能自己跑通 01 例程。
- 本次加深内容：SKILL.md（本地与公开版）新增“边问边学”一节；新建 skill/abbrobotstudio/references/learned.md，把 Q1–Q26 学到的东西（只留一个技能、MCP 停掉、虚拟控制器不能代码建、点动无 SDK 命令、RWS 端点、localhost 走 IPv6 等）按“问题 → 答案 → 为什么”写进去；新文件待下次同步 GitHub（当前正在跑的同步任务传的是改之前的版本）。

### Q27 — 2026-11-20 15:33
- 问题：怎么改 giithup 的头像
- 回答要点：GitHub 网页右上角点头像 → Settings → Public profile → Profile picture 点 Upload new picture，选正方形图片、裁剪、保存；直达链接 github.com/settings/profile。改完全站生效要等几分钟。
- 本次加深内容：无（与 ABB 技能无关的操作问题，只记问题与答案，不改技能）。

### Q28 — 2026-11-20 15:35
- 问题：你帮我改，就这个头像
- 回答要点：这条消息里没收到图片，助手查了上传目录也没有新图片文件，已请用户把想用的头像图发过来，收到后用浏览器在 GitHub 设置里上传更换。
- 本次加深内容：无。

### Q29 — 2026-11-20 15:35
- 问题：doraemon（接在换 GitHub 头像的话题后）
- 回答要点：按“用哆啦A梦当 GitHub 头像”理解。第一张图用户说不好看，又画了两张（经典动画脸、3D 立体版），用户选第 1 张；已转 PNG（1600×1600）经浏览器上传到 GitHub 设置更换，主页大头像已从粉色 identicon 变成哆啦A梦，右上角小头像因缓存仍显示旧图，等几分钟就同步。
- 本次加深内容：无。

### Q30 — 2026-11-20 18:01（微信）
- 问题：跟哪种语言比较像（接上一条“这种编程属于什么语言”，已答 RAPID）。
- 回答要点：最像 Pascal——结构化、强类型，MODULE/PROC、VAR 先声明类型、IF…ENDIF、WHILE…ENDWHILE、分号结尾；已核实 TryPLC 的说法“Pascal-like，closer to Pascal than to BASIC”。跟 Python 对比：逻辑相通（if/while/for/函数），差别在 Python 靠缩进、不用声明类型，RAPID 靠关键字收尾、必须声明类型；例子 nCount := nCount + 1;、IF…THEN…ENDIF。KUKA 的 KRL 作用一样但语法不同，不能通用。
- 本次加深内容：skill/abbrobotstudio/references/learned.md 新增“RAPID 最像 Pascal”一条。

### Q31 — 2026-11-20 18:13（本窗口）
- 问题：ABB编程是什么语言
- 回答要点：主语言是 RAPID，ABB 自家给 IRC5/OmniCore 控制器用的高级语言，语法像 Pascal/C 混合，在 RobotStudio 里写、下载到控制器跑；Python/C# 只能通过 RWS、EGM、PC SDK 联动，不能替代 RAPID。注：微信窗口 18:01 已有同类问题记为 Q30（RAPID 最像 Pascal），本次是本窗口重复提问，编号 Q31。
- 本次加深内容：技能已覆盖 RAPID 教学（01–10 例程），本次只补记录，不改技能；用户仍在给技能改名（rapid-mentor / abb-robot-mentor / robot-code-craftsman 三选一），未定。

### Q32 — 2026-11-20 18:12（本窗口）
- 问题：技能名不要叫 abbrobotstudio，一点都不好听，这个技能我想的是可以正确而且高效率地写出机器人编程代码，仿真问题 Smart 组件，边学习边成长的，项目能不能做好看一点，封面标准做好看，对比一下各大热门 skill
- 回答要点：查了热门技能（skills.sh 2026-11-10 数据）：find-skills 430 万、grill-me 150 万、tdd 120 万、frontend-design 110 万，规律是名字短（1–2 词）、一看就知道干什么、只做一件事；README 封面标准是居中标题 + 图 + 一句话 + 3–5 个徽章 + 第一屏给证据 + 30 秒上手。给了三个候选名（rapid-mentor / abb-robot-mentor / robot-code-craftsman），用户回“那就叫这个吧”，按第一个 rapid-mentor 改（用户没点选项卡，第一个是我排第一的推荐；若不是，改名后可一句话纠正）。已改：本地 custom-skills 与公开库 skill 目录重命名，SKILL.md/skill.yaml/INSTALL.md/README 里的名字全改，README 封面按热门标准重做（居中标题 + 机器人封面图 assets/cover.png + 一句话 + 徽章 + 四格功能表），comparison.md 补热门技能对比表。
- 本次加深内容：SKILL.md 与 skill.yaml 的定位改成“ABB 机器人导师：写 RAPID 又对又快，仿真、Smart 组件、边学边长大”；comparison.md 新增热门 Skill 对比一节与改名原因；learned.md 补改名教训。

### Q33 — 2026-11-20 18:16（本窗口）
- 问题：Robot-RAPID / 这个
- 回答要点：用户纠正技能名：不要 rapid-mentor，定名 Robot-RAPID。已改：本地 custom-skills/robot-rapid 与公开库 skill/robot-rapid（文件夹名按技能规范用小写 robot-rapid，对外显示名 Robot-RAPID），SKILL.md 标题与描述、skill.yaml 的 title、README 徽章与“叫 Robot-RAPID”、comparison.md 改名段落都已改。注意：当时正在跑的 GitHub 同步传的是 rapid-mentor 版，须等它跑完再同步一次 Robot-RAPID 版，不能中途掐断（会留半截仓库）。
- 本次加深内容：learned.md 补一条——用户定名时按用户原话，文件夹小写是规范，显示名用用户原话。

### Q34 — 2026-11-20 18:17（本窗口）
- 问题：全部核对到我这个 Robot-RAPID 仓库里，然后其他仓库就可以删掉了，然后还有一些虚拟的文件夹，还有一些重复的文件夹也全部删掉
- 回答要点：已核查账号仓库共 4 个：abb-robot-programming（留，Robot-RAPID 仓库）、abb-robotstudio-mcp6.08（fork，删的候选）、dian-gong-2026（留，电工公开站在跑）、desktop-tutorial（私有教程仓库，删的候选）。本地：abb-library 与 custom-skills 干净，skill/ 只剩 robot-rapid；github-upload/ 是空文件夹可删；abb-mcp-fork/ 是 MCP 本地稿子，含 station-tool/、pipeline-tools/ 两个封存草稿文件夹可删。删仓库不可逆，已列删单请用户点选确认，未动手删。
- 本次加深内容：无，待用户确认删单后执行。

### Q34 续 — 2026-11-20 18:18（本窗口）
- 用户点选：删 MCP fork 和 desktop-tutorial，留 ABB 和电工。
- 执行：本地 github-upload/（空文件夹）与 abb-mcp-fork/（MCP 本地稿子，含 station-tool/、pipeline-tools/ 草稿）已移进回收站，30 天内可恢复（trash_id：github-upload 为 20261120-101846-f005e7eccc304b7d80be3569ca2cc04a，abb-mcp-fork 为 20261120-101846-ef89e99ea3b440c5b76dbab09b1264c0）。GitHub 上删 abb-robotstudio-mcp6.08 与 desktop-tutorial 两个仓库已交浏览器执行，待回执核对。

### Q34 续 — 2026-11-20 18:21（本窗口）
- 删仓库完成：abb-robotstudio-mcp6.08 与 desktop-tutorial 均已删除，仓库清单核对只剩 abb-robot-programming 与 dian-gong-2026。删第一个仓库时 GitHub 要求 sudo 模式重验证，用户发来邮箱验证码 26044234 完成验证，未用密码。本地 github-upload/ 与 abb-mcp-fork/ 已进回收站（30 天可恢复）。

### Q32/Q33 续 — 2026-11-20 18:23（同步半失败，教训）
- rapid-mentor 版同步半失败：9 次提交已上（4 个脚本移到 skill/rapid-mentor/scripts/、旧 skill/abbrobotstudio 已删、assets/cover.png 已传，仓库 21→30 次提交），但 7 个文本文件（SKILL.md、INSTALL.md、recipes.md、learned.md、README.md、comparison.md、learning-log.md）上传全部失败。
- 失败原因（我的错）：文件交给浏览器后，我又在本地把 rapid-mentor 改名成 robot-rapid、还改了 README 等文件，浏览器那边按旧路径、旧大小找不到文件了（source_not_found / input_grant_size_mismatch）。教训：文件交给浏览器同步后，在它跑完之前绝不改名、绝不改内容。
- 当前仓库状态：skill/ 只剩 rapid-mentor，且只有 scripts/，缺 SKILL.md、INSTALL.md、references/；README 等仍是旧版。已重开一次同步，直接做 Robot-RAPID 版：删 skill/rapid-mentor，重建 skill/robot-rapid（8 个文件全传），换 README、comparison.md、learning-log.md；这次本地文件不再动。
