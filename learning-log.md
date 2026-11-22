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
- 问题：能不能接入 RobotStudio 里面帮我操作
- 回答要点：不能直接接入用户电脑上的 RobotStudio 操作。Muse 在云端，没有 RobotStudio 连接器，RobotStudio 是本地 Windows 桌面软件、不是网页，不能远程点鼠标。能做的：一步步带操作、给可导入的 RAPID / 工作站文件、看截图和报错帮改。
- 本次加深内容：教程补 RobotStudio 说明（RobotWare 6 时代、IRC5，本库 RAPID 例程兼容；Wizard / OmniCore 是更新版本的功能，老版本没有）；Skill 补“不能直连本地 RobotStudio，改用文件 + 截图指导”一条。

### Q9 — 2026-11-20 10:21
- 问题：连接器怎么搞
- 回答要点：RobotStudio 本身没有给 Muse 的现成连接器，但有 3 条路：1）MCP 服务器 + ClaudeBridge 插件，直接对 RobotStudio（PMinhDuc204/abb-robotstudio-mcp6.08，63 个工具）；2）RWS（控制器内置 Web API，http://localhost:80，Default User / robotics），本库 Python 例程就是走这条路，最简单；3）ABB PC SDK（C#，官方）。
- 本次加深内容：新增 `docs/connectors.md`，写清 3 条路的原理、安装步骤、能干什么、不能干什么；对比表补 MCP 服务器一项。注意：MCP 是给支持 MCP 的 AI 客户端用的，Muse 这个聊天不能直接接你电脑上的 stdio MCP；先在虚拟控制器上试。

### Q10 — 2026-11-20 10:23
- 问题：1（选了连接器第 1 条路：MCP 服务器 + ClaudeBridge 插件）
- 执行：新增 MCP 安装文档，按项目 README 原步骤写清检查、安装、启动、验证 4 步；先让用户在自己电脑上跑检查命令（node、dotnet、RobotStudio 路径），报结果再往下装，不跳步。

### Q11 — 2026-11-20 10:27
- 问题：我叫别的 ai 装，有什么说的
- 回答要点：给了一段可直接复制给另一个 AI 的安装指令：项目、路径、检查、安装、启动、验证、只在虚拟控制器上试、装完报结果和报错原文。
- 本次加深内容：新增 `docs/other-ai-prompt.md`，放可复制的完整指令。

### Q12 — 2026-11-20 12:37
- 问题：检查结果：Node.js v24.16.0（不是 20）、npm 11.13.0、.NET SDK 未安装（只有 8.0.22 运行时）、RobotStudio 找到、Newtonsoft.Json.dll 找到、git/网络正常、RobotStudio 未运行
- 回答要点：只差 .NET SDK 一项，其他都通。Node 24 先试，不行再降到 20；.NET 运行时不等于 SDK，必须装 .NET 8 SDK，net461 引用程序集靠 NuGet 恢复或装 4.6.1 Developer Pack。
- 本次加深内容：MCP 安装文档补检查结果诊断和 .NET SDK 安装步骤。

### Q13 — 2026-11-20 13:10
- 问题：githup有这个mcp吗
- 回答要点：有，PMinhDuc204/abb-robotstudio-mcp6.08，Glama 页源码链接指向该仓库；直接打开 GitHub 页时报网络错误、不是 404，未能直接拉到仓库页，已如实说明。
- 本次加深内容：MCP 安装文档补 GitHub 仓库地址和 clone 命令。

### Q14 — 2026-11-20 13:29
- 问题：用户发来本地路径（Trae-CN 里的 ABB-RobotStudio-MCP-安装报告.md）
- 回答要点：我这边读不到用户 Windows 电脑本地文件，只能请用户把报告内容贴过来或在聊天里上传文件，再复核安装结果。

### Q15 — 2026-11-20 13:34
- 问题：用户把另一 AI（Trae CN）做的《ABB RobotStudio MCP Server 安装报告》全文贴过来，请复核。
- 复核结论：安装、构建、桥接、MCP 配置全部完成；6 项只读验证通过 5 项。Node 20.20.2（便携）+ .NET SDK 8.0.428（便携），系统 Node 24 未动；npm ci/build/test 5/5 通过；ClaudeBridge 插件编好、RobotStudio 带 /addin 加载成功，ping 通（stationOpen=true，ABB1115）；Trae CN 的 MCP 配置已写好；63 个工具可列。工作站 ABB1115.rsstn，虚拟控制器 ABB1，任务 T_ROB1，状态 motoron / AUTO / stopped。
- 未通过项 rs_read_module：不是安装问题，是控制器上没装载 RAPID 程序。诊断可信：SDK 直连测得 SaveProgramToFile 报 C0049004（程序名未设置）、RWS 文本端点 404（该 VC 未实现）；上游 README 也写了 RobotStudio 模块端点不匹配是已知问题。要过这一项须在 RobotStudio 里给 ABB1 装载程序（改控制器状态，不产生运动），建议直接装库里的 01_move_basics.mod 再重试。
- 未修 bug（报告第 7 节）：#5 高——rws_get_modules 用的 RWS 端点在该 VC 返回 404，可用端点是 /rw/rapid/modules?task=T_ROB1；#6 中——rws_list_files 传 "$HOME" 被判非法；#7–#9 低——版本号三处不一致、npm audit 3 漏洞、TS 依赖放错位置。
- 启动注意事项：RWS 端口每次启动 VC 都会变（本次 19404），须跑 refresh-rws-url.ps1 刷新；脚本启动 RobotStudio 须用 WMI 脱离进程树，否则几十秒后被回收；释放 mastership 后约 3 秒内 rws_controller_status 会短暂 503，属控制器行为；TIA Administrator V3 服务崩溃重启循环（77+ 次）与安装无关，但干扰日志排查；强杀 RobotStudio 会遗留 RobVC.exe 锁工作站，须同时结束。
- 报告里两处文件数统计口径不同（第 3 节 3 个、第 9 节 2 个源文件），结论一致。
- 机器人型号：报告给了工作站和控制器名，型号等用户定。
- 本次加深内容：MCP 安装文档补实际安装结果、未通过项根因、未修 bug、启动注意事项；同步 GitHub。

### Q16 — 2026-11-20 13:44
- 问题：能不能做一个所有人都可以安装的 skill 和 mcp
- 回答要点：能，分两件。Skill：原来只存在本机，路径写死 ~/workspace/...，别人装不了；改成通用相对路径，放进公开仓库 skill/ 目录，加 INSTALL.md，任何人 clone 就能装。MCP：服务器是别人开源的项目（PMinhDuc204，MIT 协议），不能直接说成自己的；做法是 fork 到用户账号，合入另一 AI 在用户电脑上改的 3 个文件补丁，再修报告里未修的 #5、#6，加一键安装脚本。
- 本次加深内容：新增 skill/SKILL.md（通用版，相对路径，加 MCP 一节）、skill/INSTALL.md（Muse / Claude Code / 其他助手三种装法，中英双语）、README 补 skill/ 目录和安装说明。
- MCP 进展（13:48–13:53）：补丁文件已收到（261 行，3 个文件，+122/-42，与报告一致）；本地克隆上游仓库触发执行风险检查，已删本地克隆，不在本地跑补丁和构建；fork 已建（linxie654-netizen/abb-robotstudio-mcp6.08，15 次提交，HEAD a782f78）；一键安装脚本 install.ps1 与 fork 说明草稿已写好（Node / .NET 下载链接核实 200）；#5、#6 修复方案已定位代码位置并写好（FIX-5-6.md）。
- MCP 完成（14:00–14:03）：用户发来 zip（3 个改好的文件），逐项核对通过——#5 端点在 index.ts 491 行、#6 正则在 538 行、补丁关键改动（SyncModuleToStation、mastership、RWS 兜底、`$HOME/*` 已清、Content-Type）全在；另一 AI 在用户电脑上 npm run build 已通过。5 个文件传到 fork：3f7529d（addin）、8a3eccd（src 两个）、eac9090（install.ps1 + README），仓库现 18 次提交，README 顶部“本 fork 的说明”已验证。
- 下一步：#5/#6 修复在虚拟控制器里装载程序后跑 rs_read_module。

### Q17 — 2026-11-20 14:02
- 问题：现在 MCP 还差什么？还能从 0 到 1 创建工作站、添加机器人、添加编程、Smart 组件吗？
- 回答要点：按 fork README 的工具表（63 个：33 个 rs_* + 30 个 rws_*）逐项核对。创建工作站：没有创建工具，只有 rs_get_station / rs_get_station_objects / rs_save_station，不行。添加机器人：没有任何加机器人工具，不行。添加编程：可以，rs_write_module、rs_validate_rapid、rs_create_path、rs_create_target、rws_write_module、rws_load_module_from_file、rws_load_program。Smart 组件：没有任何相关工具，不行。结论：MCP 只能操作已经打开的工作站，不能从 0 到 1 建站；要补建站、加机器人、Smart 组件这三件，须在 ClaudeBridge 插件（C# 端）新开发工具，不是改配置能解决的。
- 下一步：#5/#6 修复在虚拟控制器里装载程序后跑 rs_read_module；机器人型号等用户定；MCP 在用户电脑本地由 Trae CN / Claude Code 调用。

### Q19 — 2026-11-20 14:19
- 问题：是从 0 到 1，从工作站创建，到机器人到示教器，到建模，组件到编程的一个全流程
- 回答要点：全流程 6 段，按顺序——工作站创建（rs_create_station 草稿已写未测）、加机器人（无工具，须先定型号；另涉虚拟控制器创建，论坛反映工作站加载后加 VC 是难点，待核实）、示教器（教目标点已有 rs_create_target、读位置已有，jog 点动无工具；虚拟示教器本身是界面，MCP 开不出来，只能做它对应的操作）、建模（无工具，SDK 可建几何/导 CAD，须核实调用）、组件（Smart 组件无工具，实例化调用待 PC 核实）、编程（已有，写模块/校验/路径/目标点/加载）。阶段图写进 docs/mcp-full-pipeline.md。
- 本次加深内容：docs/mcp-full-pipeline.md（6 段全流程，每段现有工具/缺失/待核实）。

### Q20 — 2026-11-20 14:24
- 问题：用户把我对“建虚拟控制器、Smart 组件实例化、点动、建模的调用”四处的说法贴回来，要核实
- 回答要点：4 处核实完——建模 ✅（Part.Load 导 CAD + Body.CreateSolidCone 建几何，ABB 官方示例和论坛实例）；Smart 组件 ✅（GraphicComponentLibrary.Load + RootComponent.CopyInstance + GraphicComponents.Add，ABB 论坛标准写法，CopyInstance 必须调）；点动 ⚠️（手动点动命令 SDK 里没有，ABB 工程师亲口确认；仿真侧用 Mechanism.SetJointValues 改关节角代替）；建 VC（从 0 新建系统走 Installation Manager / System Builder 的活；启动已有 VC 已核实 RsIrc5Controller.StartAsync / RobVcFactory.StartVC）。核实结论写进 abb-mcp-fork/verification-notes.md；4 个新工具草稿写进 abb-mcp-fork/pipeline-tools/（rs_import_cad、rs_create_solid、rs_add_smart_component、rs_jog_joint），未测试。
- 本次加深内容：verification-notes.md + pipeline-tools/（handlers.cs、tools.ts、README.md）。

### Q21 — 2026-11-20 15:49（微信任务）
- 问题：微信发来 ABB RAPID 练习“牛刀小试”图片（rYuan 画圆、rFang 画方，nCount=1,3,5,7,9 画 100×60 方形，=2,4,6,8,10 画 R=40 圆，>10 停止）
- 回答要点：完整程序 mod_NiuDaoXiaoShi——main 用 WHILE nCount<=10 + MOD 2 判奇偶；rFang 用 MoveL+Offs 画 100×60 方形；rYuan 用两次 MoveC 拼 R=40 整圆；点位注明为示教值、需在 RobotStudio 重示教。文字结果 + .mod 文件已发回微信，文件在 wechat-bridge/results/7529454543215009160.mod。
- 本次加深内容：记录在案，未进 RAPID 例程库（微信任务，按需再入库）。

### Q18 — 2026-11-20 14:04
- 问题：怎么做（指补建站、加机器人、Smart 组件这三件）。
- 回答要点：三层套路，和现有工具一样——C# 插件加新端点（照 CreatePath/CreateTarget 的写法）→ MCP 服务器加新工具（调插件 HTTP 端点）→ 另一 AI 在用户电脑上编插件 + npm run build + 实测。建工作站已写出草稿 rs_create_station（new Station() + ActiveTask = DefaultTask + Project.ActiveProject，ABB 论坛实例写法，包在 UndoContext 里），未测试，待另一 AI 编测；已知坑：新工作站可能没 3D 图形窗口，论坛里的解法是加 GraphicControl + Camera（需 Stations.Forms 引用）。加机器人须先定型号，机器人库 .rslib 默认在 C:\ProgramData\ABB\DistributionPackages2，新型号要先在 RobotStudio 里下载。Smart 组件须对 SDK API 参考核实实例化调用，没编具体的调用名。顺序：工作站 → 机器人 → Smart 组件。
- 本次加深内容：station-tool/ 草稿（ClaudeBridgeAddIn.cs、index.ts、README，含编测步骤）。

## 待用户确认的学习方向
- 机器人型号：未定（IRB 120 / 140 / 6700 / YuMi？）
- RobotStudio 是否已安装：已装 RobotStudio；MCP 服务器 + ClaudeBridge 插件已通（2026-11-20，见 Q15）
- 当前水平：Python 初学；ABB 基础操作、J1-J6、空间坐标系正在学
- 下一步建议：先跑通 RobotStudio 虚拟控制器 + `abb_motion_program_exec` 的 MoveJ/MoveL 例子，再学纯 RAPID 搬运、IO、循环。

### Q21 — 2026-11-20 14:40
- 问题：做的这个 MCP 太难了，做 Skill 好一些
- 回答要点：停掉 MCP 工具开发，改做 Skill。全流程 6 段（工作站、机器人、示教器、建模、组件、编程）写成 Skill 版步骤，见 docs/full-pipeline.md：人照着在 RobotStudio 里点，助手给 RAPID 文件、检查清单、看截图改错，不用编 C# 插件、不用 Node/.NET 构建。建虚拟控制器只能走 Installation Manager / System Builder 界面建系统再加载，不能用代码从 0 建。station-tool/、pipeline-tools/ 的 MCP 草稿封存留档，不再编测。
- 本次加深内容：docs/full-pipeline.md（Skill 版 0 到 1 全流程）+ Skill 两处（本地与公开版）新增“0 到 1 全流程做 Skill、不做 MCP 工具”一节。

### Q22 — 2026-11-20 15:14
- 问题：用户发来 abb-robotstudio-bridge-merged-v1.zip，说“看看怎么搞，先说一下”，后又说“做”
- 回答要点：先按系统安全检查停下问确认，用户说“做”后才动手。核对完：包是上游 v3.1.0 + 本地修复 + 新功能 + 全局技能 robotstudio-ops 的整合版，共 50 个文件；工具从 63 个变 67 个（rs_* 37 + rws_* 30），新增 rs_new_station、rs_create_station、rs_save_station_as、rs_add_library_component；#5 已改走 /rw/rapid/modules?task=（index.ts 525 行）、#6 正则已放行裸 $HOME（565 行）；Add-In 新增 /station/new、/station/create、/station/save-as、/station/add-component、/exec；技能可用 HTTP 桥（127.0.0.1:58080）不用 MCP 客户端操作 RobotStudio。
- 本次加深内容：新增 docs/bridge-merged-v1.md（复核记录与安装步骤）；关键源文件整理上传到 fork linxie654-netizen/abb-robotstudio-mcp6.08（待浏览器上传结果）。
- 说明：新建虚拟控制器按 INSTALL.md 的做法走（本机 RIM 层问题，不反复重试）；dist/ 与 artifacts/ 是构建产物，不进 GitHub。

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
- 回答要点：封面指公开库 README 顶部。已重排：标题 + 徽章（RAPID 10 例程、RobotStudio、Skill abbrobotstudio、中文）+ 一句话说明，新增“这个技能有什么用”5 条、“新手安装：3 步”（下载库、装技能、问第一个问题，附 Muse / Claude Code / 其他助手三种装法和没装 git 时的 ZIP 下载办法），INSTALL.md 顶部也补了同样两节。
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
- 原因（我的错）：文件交给浏览器后，我又在本地把 rapid-mentor 改名成 robot-rapid、还改了 README 等文件，浏览器那边按旧路径、旧大小对不上文件（source_not_found / input_grant_size_mismatch）。教训：文件交给浏览器同步后，在它跑完之前绝不改名、绝不改内容。
- 当前仓库状态：skill/ 只剩 rapid-mentor，且只有 scripts/，缺 SKILL.md、INSTALL.md、references/；README 等仍是旧版。已重开一次同步，直接做 Robot-RAPID 版：删 skill/rapid-mentor，重建 skill/robot-rapid（8 个文件全传），换 README、comparison.md、learning-log.md；这次本地文件不再动。

### Q35 — 2026-11-20 18:35（本窗口）
- 问题：感觉跟别的 skill 还是比较太少了 / 你去看看别的工科类 skill 怎么做的，学习一下 / 多添加一点内容，多优化美化一下
- 回答要点：查了工科类 skill：SmailG/plc-programming（PLC 插件，多 skill 分工：develop/debug/convert + 故障模式目录 + 校验器）、robot-validator（ROS 2，7 步工作流）、pixel-robotics/bt-rosbag-analysis（skill 就是可执行手册）、RavenClaude 机器人插件（3 专家 agent + 版本钉死）、awesome-gamedev-agent-skills（79 skill + 路由器 + 版本钉死）。结论：薄的不是 SKILL.md 本身（frontend-design 只有 71 行、9.4KB，110 万安装），薄的是配套：报错手册、按任务分流、检查清单、版本钉死。已补：references 新增 troubleshooting.md（报错对号表 + 四步排查）、rapid-patterns.md（9 种模式配代码和例程）、smart-components.md（搭组件 6 步 + 常用组合）、simulation-checklist.md（逐项打勾）；SKILL.md 加“要干什么先读什么”分流表和验证关口；README 加能力地图与版本钉死行；INSTALL.md 加装完自查 4 步；comparison.md 补工科 skill 对比一节。
- 本次加深内容：以上 4 个新参考文件 + SKILL.md 分流表与验证关口 + README 能力地图；均待同步 GitHub。

### Q36 — 2026-11-20 18:39（本窗口）
- 问题：Youtube 上面不是有 Abb robotstudio 新手教程吗？你能不能花几天时间去查看，一个个视频一帧一帧地去学习？然后把它们做成 skill 上传到我的仓库
- 回答要点：已接，派了视频学习员分阶段做。先找的起点：Aleksandar Haber 系列（点动、工具坐标系、工件坐标系三点法）、Maurilio Patino 码垛 4 部分（真空夹爪 Smart 组件、传送带、取放、安全）、ABB 官方频道教程、4.5 小时 RAPID 入门课、37 分钟取放 RAPID 教程、Ryan Bliss 取放 RAPID、CMU Future CNC 官方 4 步教程。学习方法：字幕 + 作者文字版按步骤拆解，对照库里已有内容标出缺口；不谎称逐帧看过，没看的部分不写。成果先写 docs/youtube-tutorials.md（总目录 + 步骤拆解）与 docs/youtube-study/PROGRESS.md（进度表），值得进技能的先打草稿，核对后再正式进 Robot-RAPID、统一同步 GitHub。另注：Q35 扩内容同步已完成（41 次提交，见下）。
- 本次加深内容：Q35 扩内容已同步 GitHub（9 个文件、4 次提交：6cd7f88 新参考文件 4 个、69afd0d SKILL.md 与 INSTALL.md、d901737 README 与 learning-log、329ed80 comparison.md；仓库 37→41 次提交，已核对 references 6 个文件、README 能力地图、Q35 记录均在）。
- 第一阶段完成（2026-11-20 18:43）：目录共 31 条（第一批 11 条，其余 20 条排进后续阶段）；学完 9 条（Haber 点动 2 条、三点法 1 条、Patino 码垛 4 部分、ABB 官方 RW7 改安装、CMU 官方 4 步）；补进库里 10 样，按先学顺序：三点法工件坐标系、工具标定、真空夹爪 Smart 组件、传送带物理仿真、叠放偏移 + 传感器分拣、QuickStop + World Zone + PowerOn、RW7 改安装、单机器人系统 + I/O 配置、仿真初始状态保存、EDWartens 16 模块课程包。草稿 5 篇在 docs/youtube-study/drafts/（真空夹爪、传送带物理、取放叠放分拣、安全 World Zone、三点法工件坐标系），在 RobotStudio 里照做练。下一步：H3 工具坐标系 → R4 Ryan Bliss 取放 → R3 Easy 取放 → R7/R6 运动指令与 RAPID 基础 → R8 多工件 → C5 cnctrain 单机器人系统 → R1 四个半小时课分段学。学法：作者文字版 + 字幕/描述，标题按原页面写。

### Q37 — 2026-11-20 18:46（本窗口）
- 用户拍板：全部都是以这个仓库（abb-robot-programming），不管以后什么技能都放在这里。
- 规则：以后任何新技能（ABB 以外也一样）都放进这个仓库的 skill/ 下，不另开仓库。本地与 GitHub 同步仍走同一仓库。

### Q38 — 2026-11-20 18:46（本窗口）
- 用户要求：你先学习，学好后转化成技能。
- 规则：YouTube 教程先学完、学透，草稿在 RobotStudio 里照做跑通后，再正式转化进技能（Robot-RAPID 的 SKILL.md / references），不要边学边往正式文件里塞。

### Q39 — 2026-11-20 18:46（本窗口）
- 问题：别人怎么用我这个 skill？不需要 ZIP 吗？
- 回答要点：三条路：git clone、网页 Code → Download ZIP、或把 SKILL.md 全文发给助手；ZIP 和 clone 拿到的东西一样，没装 git 才用 ZIP。

### Q40 — 2026-11-20 18:47（本窗口）
- 用户要求：那你都搞一下，跟其他 skill 都一样。
- 做法：按热门 skill 的标准安装方式补了一条命令安装：`npx skills add linxie654-netizen/abb-robot-programming`（skills.sh / vercel-labs/skills CLI，Node.js 22.20 以上）。2026-11-20 已实测：`--list` 找到 1 个技能 robot-rapid；`--skill robot-rapid -a claude-code -g -y` 装到 `.claude/skills/robot-rapid/SKILL.md`，端到端跑通。README 与 INSTALL.md 已加这条命令，git clone 和 ZIP 两种手动方式保留。

### YouTube 学习第二阶段完成（2026-11-20 18:47）
- 累计学完 19/32 条：第二阶段新学 10 条（H3 工具坐标系、R4 Ryan Bliss 取放 19 分钟、R3 Easy 取放、R6 RAPID Basics 7:52、R7 Motion Instructions 7:06、R8 多工件 30 分钟、R5 第一行代码 14:16、C5 cnctrain 单机器人系统、A2 ABB 官方 World Zones 可视化、E1 EDWartens 免费课）。
- 新发现库里缺 5 样，草稿 5 篇新（草稿共 10 篇）：工具坐标系三种方法 + Create Tool 向导、PLC 程序号调度 + Pounce 点、 多工件复用讲法、从已有布局建系统 + Configuration Editor 配 I/O、World Zone 可视化做法。关键发现：World Zone 的写法（WZBoxDef/WZDOSet、挂 PowerOn 事件）通用，可视化有三种做法：工作站里直接显示、WorldZones Add-in、手工画透明盒子 + 碰撞集。
- 接着学：R1 PART 1（4h36m）分段拆、R9（一句解说词片段）。下一步：R1 分段学 → H8 沿路径走 → H5/H6 作业视频 → R2 → R10 → H7 → P2–P6。
- 草稿仍按 Q38 规则：待在 RobotStudio 照做跑通后再进正式技能文件。

### Q41 — 2026-11-20 18:52（本窗口）
- 用户要求三条：只有试用的不要写进去；你别管 24 还是 08，全部通用写进去；先查清再写。
- 执行：已按要求改：youtube-tutorials.md 删了 E1 的 试用提醒，A2 的 World Zone 可视化改成通用写法（三种可视化做法任选），A1 的 RW7 版本说明和 C1–C4 的 RobotStudio 界面说明改成通用表述；PROGRESS.md 的 A2 行、草稿表、方法第 6 条改通用；草稿 world-zones-visualization-2024.md 改名 world-zones-visualization.md 并重写成通用做法。核查：World Zone 是 RobotWare 老选项（608-1），WZBoxDef 等指令在 RobotWare 5/6 手册里就有，通用写法有依据。
- 规则：库里不写试用相关内容；内容按通用写，不按版本分开写；先查再写。

### Q42 — 2026-11-20 19:01（本窗口）
- 用户问：怎么没有 MTI 认证？给我搞多点认证啊，可以开源的。
- 执行：查了中英文，“MTI 认证”请用户说明指哪一个（MTI 常见指制造技术学院、Xsens MTi 传感器、MTI Motion 电机）。按“可以开源的”理解为免费学、证书免费或便宜，写了 docs/certifications.md：免费拿证 4 个（UR Academy 每课一张证、EDWartens ABB £19 自选、EDWartens FANUC £19 自选、学堂在线 1+X 配套课免费学）、国家认的证 3 个（1+X 应用编程、1+X 操作与运维、工业机器人系统运维员四级）、ABB 官方付费班 3 项（线上班、教育包 STEM.org、2026-11 刚发布的物理 AI 项目）、免费学的 2 类（MIT OCW、Coursera/edX 旁听）。
- 待确认：用户说的 MTI 是不是指 MIT 或别的认证，等用户回。

### YouTube 学习第三阶段（进行中，2026-11-20 19:00）
- 学完 H8（Haber 沿路径走 RAPID，zZXk-TW2iCE），累计 20/32 条；新草稿 1 篇 `drafts/paths-targets-rapid.md`（草稿共 11 篇），补的缺口：沿路径走 RAPID 的完整操作链（导模型 → 装末端执行器 → 点动记点 → 建路径 → 同步到控制器 → 跑仿真）。
- 学法：流程按 Haber 视频顺序，步骤用 CMU Future CNC 官方教程、ITAR 手册、卡尔加里 YuMi 指南、plcprogramming.io RAPID 教程交叉核对。
- 下一步：R1 分段学 → H5/H6 作业视频 → R2 → R10 → H7 → P2–P6。草稿仍按 Q38 规则：待在 RobotStudio 里照做跑通后再进正式技能文件。本批只改了本地文件，未同步 GitHub。

### YouTube 学习第三阶段（续，2026-11-20 19:40）
- R1 段 1–4 学完：R1 定为 Automation Academy 的 PART 1（视频 ID hGGkzsT8WEU，4:36:34）；多版本对照表（R2 DsQu6AXvcgg 2:58:07、短版 _l7buBX1DFk 1:33:02，另有 4h22m/4h13m 版）；课程简介出自 Wolf Robotics 的 ABB 基础编程 4 天班手册（已读原文）。段 1 安全开场、段 2 FlexPendant 导航、段 3 点动（库里已有，只印证）、段 4 示教器四点法标 TCP。
- 补 3 个缺口，新草稿 3 篇（草稿共 14 篇）：上锁挂牌＋急停＋安全恢复 `drafts/safety-lockout-tagout.md`、FlexPendant 主菜单／快捷菜单／操作模式／使能与速度 `drafts/flexpendant-navigation.md`、示教器四点法标 TCP＋验证 `drafts/tcp-calibration-flexpendant.md`。
- 学法：分段按 Wolf 手册大纲 + ABB 官方 RU011／IN-RB02 课程大纲拆。
- 下一步：R1 段 5 起（程序结构＋创建／保存／加载程序）→ H5/H6 作业视频 → R2 → R10 → H7 → P2–P6。草稿仍按 Q38 规则：待在 RobotStudio 里照做跑通后再进正式技能文件。研究笔记 R1-research-note.md 内容已并入 youtube-tutorials.md、PROGRESS.md 与 3 篇草稿，本文件已删除。

### Q43 — 2026-11-20 20:08（本窗口）
- 用户问：我要做一个叠码垛的仿真，你看一下需要做什么，全部给我说成文字，编成你给我写出来。
- 执行：新写 `rapid/11_palletizing.mod`（IRB 120 + 传送带供料 + 托盘 2 列×2 行×3 层 = 12 箱，箱子 120×80×60 mm，偶数层转 90 度交错码放，规格全在开头 CONST 里改；只教 2 个基准点，其余位置 Offs 当场算；满托报数、等 diNewPallet 换托盘后循环再码）与 `docs/palletizing-simulation.md`（文字版全流程：方案、建站 10 步、信号接法、Smart 组件简版与完整版、程序讲解、跑仿真、常见问题、进阶）。依据：库里 02 取放、04 循环、05 坐标系与 Patino 码垛 Part 1–3 草稿（传送带物理、真空夹爪、取放叠放偏移）。
- 说明：点位全是教学值，pPalletBaseR 转 90 度的姿态按四元数算出，仿真里看朝向；已在文件里写明。

### Q44 — 2026-11-20 20:33（本窗口）
- 用户问：你理解好了吗？所有新手教学你都看了吗？会理解了吗？知道怎么做了吗？会的话就上传上去，用大白话来讲，用大白话来教。
- 回答要点：32 条视频学了 20 条，接着学 R1 段 5 起、H5/H6、R2、R10、H7、P2–P6；学过的 14 篇草稿在仿真里照做练，学完剩下 12 条再转化成大白话教学上传。

### Q45 — 2026-11-20 20:47（本窗口）
- 用户问：为什么 Python 联动啊？跟 Python 有什么关系啊？不是 C 语言吗？
- 回答要点：机器人自己跑的语言是 RAPID，最像 Pascal，不是 C；Python 是电脑上指挥机器人的遥控器——用 abb_motion_program_exec 库在 Python 里算好位置、生成 RAPID 程序、发给控制器执行；用 Python 是因为用户在学 Python、目标是把 Python、PLC、ABB 机器人结合做工业自动化，Python 写自动化脚本最顺手；C/C# 只出现在已删的桥插件里，跟学机器人没关系。

### YouTube 学习第四阶段（完成，2026-11-20 20:52）
- 32/32 全部学完，草稿 14→30 篇（新 16 篇）。6 个学习员并行：R1 段 5–13（9 篇：程序结构、创建保存加载、运动指令、运行调试、IO、备份恢复、负载计时、焊接、外轴）、H5/H6（2 篇：斜顶面定工件、圆锥当笔画字母）、R2（1 篇对比草稿）、R10（2 篇：操作模式、第一段程序）、H7（1 篇：TCP 方向）、P2–P6（1 篇清单总指南）。
- 关键结论：R2 是 R1 同一课的短版剪辑（短 1:38:27）；H5 标题《Definition of Work-object Frames》；H6 讲 RobotStudio 里编程画字母；H7 标题《Setting up Tool TCP》，讲 TCP 朝向；P2–P6 5 个清单（西语 3 个 39/24/36 条、英语 2 个各 10 条，共 119 条），标出 9 类进阶内容（PLC/OPC 联动、双机器人 MultiMove、外部轴、中断与系统信号、事件例程、TCP 跟踪、随机供料、SolidWorks 导入）；全库第一篇焊接内容（ArcLStart/ArcL/ArcLEnd）已补。
- 文件更新：docs/youtube-tutorials.md（R1 改 ✅、新增第四批、缺口补到 32 条）、docs/youtube-study/PROGRESS.md（32/32、草稿表 30 篇）、本记录。本批只改本地文件，未同步 GitHub；草稿待在 RobotStudio 里照做跑通后再进正式技能文件。注意：主窗口 20:47 已改规则，不用等验证、先把理解写成大白话教学上传——前 14 篇草稿已转化成 beginner-lessons.md 上传（141→143 次提交），本批 16 篇新草稿的转化由主窗口决定。

### Q46 — 2026-11-20 21:18（本窗口）
- 用户问：来介绍一下这个 skills 是干什么的
- 回答要点：Robot-RAPID 是教 ABB 机器人编程的技能，RAPID 语言 + RobotStudio 仿真；能给完整可跑的代码、一步步带建站仿真、报错对号排错、仿真里逐项检查；含 30 课大白话教学、12 课新手路线、10 个例程、Python 联动；一条命令安装。

### Q47 — 2026-11-20 21:25（本窗口）
- 用户发截图并纠正：不是上传到 GitHub，是在自己的 AI 自己学习。
- 背景：用户已把 Robot-RAPID 装进自己电脑上的 WorkBuddy，SKILL.md + references/ 6 个文件 + rapid/ 10 个例程 + python/ + robotstudio/ + docs/，技能已启用。
- 回答要点：明白了，技能是给用户自己的 AI 学习用的，GitHub 只是放的地方；以后重心放在 AI 能不能学会、用起来，上传只是顺带。

### Q48 — 2026-11-20 23:52（本窗口）
- 用户问：别的 AI 在 GitHub 上搜 ABB 技能，搜出来的结果里要能有我们的仓库，让助手看看。
- 背景：另一 AI 的搜索结论是 GitHub 上没有按 SKILL.md 格式封装的 ABB 技能，只找到 robotstudio-mcp、abb-offline-coder、abblender、rapid-modbus-tcp、ABB RAPID Pack、open-robot-skills、robotics-agent-skills 这些相关项目。
- 处理：派浏览器去核查仓库是否公开、有没有描述和话题标签、在 GitHub 搜索里能不能搜到；缺的就补上描述和话题，提高被搜到的几率。

### Q49 — 2026-11-20 23:53（本窗口）
- 用户问：你是干什么用，只有我一个人能看到吗
- 回答要点：我是 Muse，Meta 的个人 AI 助手（名字叫 Doraemon），只为用户一个人工作，帮他干活、学习、记事；聊天是他一个人的，没有群聊，别的用户看不到；但这台是 Secure VM，Meta 可能为安全、调试、改进产品记录和查看内容，聊天不是端到端加密，数据不会进广告系统，可在设置里退出用于 AI 训练。

### Q48 结果 — 2026-11-20 23:55
- 浏览器核查结果：仓库是 Public，已被 GitHub 索引（加用户限定搜能找到），问题是通用搜索排名太靠后；原来描述只有中文、没有任何标签。已补英文描述 + 10 个标签，搜 topic:agent-skill abb 已能唯一找到；通用排名还需时间和星标积累。

### Q50 — 2026-11-20 23:55（本窗口）
- 用户又发了一遍别的 AI 的搜索报告，问“怎么回事”。
- 回答要点：咱们的仓库在 GitHub 上，公开的，也被收录了；别的 AI 没搜到是因为排名太靠后——仓库今天刚建、0 星、原来没标签、描述只有中文；已补英文描述 + 10 个标签，搜 topic:agent-skill abb 已能唯一找到；通用搜索排名还需时间和星标积累。

### Q51 — 2026-11-20 23:56（本窗口）
- 用户连问三句：能不能帮我发布（分布）一下；多宣传一下；然后他们（别的 AI 搜到的 7 个项目）那些是做什么的？我们可以借鉴一下。
- 处理：7 个项目已派去逐个核实、写进对比表；宣传方式让用户选（GitHub Release v1.0.0、推广文案、技能目录登记）。

### Q52 — 对比学习：别的 AI 搜到的 7 个 ABB/机器人项目（2026-11-20 23:56）
- 任务：逐个核实另一 AI 搜到的 7 个项目，跟我们的 Robot-RAPID 技能做对比，写进 docs/comparison.md。
- 核实结果（一句话一个）：
  - zhou-zhichao/robotstudio-mcp：另一 AI 给的地址是错的，打开 404 不存在；Zhichao Zhou 是 RAG+MCP 生成 ABB RAPID 论文的作者，真正的 RobotStudio MCP 服务是 PMinhDuc204/abb-robotstudio-mcp6.08（63 个工具，v3.1.0，0 星），就是用户机上装过的那个，MCP 路线已拍板停掉。
  - Hollis36/abb-offline-coder：离线 AI 助手，本地 Qwen2.5-Coder + 手册 RAG，中文需求生成 RAPID 喷涂程序，0 星；喷涂是我们的空白。
  - dtpisanty/abblender：Blender 插件，动画导出 RAPID .mod，只测过 IRB-1600，7 星。
  - ABB-RARO/rapid-modbus-tcp：OmniCore 的 Modbus TCP RAPID 库，3 星，带西门子 PLC 对接示例。
  - ABB RAPID Pack：VS Code 扩展，Maxime Cesare-Zurek，约 2.3K 安装，语法跳转引用重构诊断。
  - graph-robots/open-robot-skills：真 Agent Skills 格式，74 星，GaP 操作技能（抓取、线缆），无 ABB。
  - arpitg1304/robotics-agent-skills：真 Agent Skills 格式，404 星，ROS1/ROS2 方向，无 ABB；evals 对比和 harness 验证闭环最值得借鉴。
- 结论：7 个都不是“SKILL.md 格式的 ABB 技能”；Robot-RAPID 是这次比对范围内唯一按 SKILL.md 格式封装的 ABB 技能。
- 值得补进技能的三样：harness 式验证闭环（等 RobotStudio 验证跑通后做）、喷涂内容（PaintL/PaintC、brushdata）、VS Code 装 ABB RAPID Pack 的工具推荐。
- 文件：docs/comparison.md 新增“2026-11-20 别的 AI 搜到的 7 个相关项目”一节；只改本地，未同步 GitHub。

### Q53 — 2026-11-21 00:09（本窗口）
- 用户在宣传选项里点了“两个都做”。
- 处理：推广文案已写好（docs/promotion.md，本地）；GitHub Release v1.0.0 已派浏览器去发，待回执。

### Q53 结果 — 2026-11-21 00:10
- Release v1.0.0 已发布：https://github.com/linxie654-netizen/abb-robot-programming/releases/tag/v1.0.0 ，指向提交 80c8028，带 Latest 标记；推广文案已写好在 docs/promotion.md（本地），用户自己发。

### Q54 — 2026-11-21 00:13（本窗口）
- 用户问：扩展编程仓库可以地址给我看一下吗？
- 回答：给了 abb-robot-programming 仓库地址 https://github.com/linxie654-netizen/abb-robot-programming 和 Release v1.0.0 地址。

### Q55 — 2026-11-21 00:14（本窗口）
- 用户指着 ABB RAPID Pack 问“这个”，要地址。
- 回答：给了 VS Code Marketplace 地址 http://marketplace.visualstudio.com/items?itemName=Maxzurek.abb-rapid-pack（作者 Maxime Cesare-Zurek，2.3K 安装，免费，社区项目、非 ABB 官方）；功能是跳转定义、找引用、改名重构、报错提示、格式化，离线可用、无遥测；装法是 VS Code 里搜名字装，或点链接装。

### Q56 — 2026-11-21 00:15（本窗口）
- 用户发仓库 README 截图，要求：那句版本钉死删掉，不要写那些乱七八糟的，我们这个是要公开的。
- 处理：README.md 第 24 行版本钉死行已删；comparison.md 里那行已改成注明 2026-11-21 用户要求删掉；两文件已派浏览器上传到仓库，待回执。

### Q57 — 2026-11-21 00:16（本窗口）
- 用户要 ABB RAPID Pack 的可点链接，跳转过去。
- 回答：给了 Marketplace 链接 http://marketplace.visualstudio.com/items?itemName=Maxzurek.abb-rapid-pack。

### Q56 结果 — 2026-11-21 00:16
- README.md 与 docs/comparison.md 已上传，仓库 145→147 次提交；README 全文已无“版本钉死”。

### Q58 — 2026-11-21 00:18（本窗口）
- 用户问：ABB RAPID Pack 是不是开源的？能不能去学习？
- 处理：Marketplace 页面的图标来自 github.com/Maxzurek/ABB-RAPID-Pack，看着像有公开仓库，但直接打开仓库页报 404；已派浏览器去核实仓库在不在、用的什么许可证；确认开源后再派去学。

### Q58 结果 — 2026-11-21 00:19
- 浏览器核查：源码仓库 https://github.com/Maxzurek/ABB-RAPID-Pack 打开 404；GitHub 搜同名仓库 0 个；作者公开仓库列表 11 个里也没有；唯一沾边的 Maxzurek/abb-rapid-pack-doc 只放图片、0 星、无 README、无 LICENSE。许可证无法确认，不能算确认开源。
- 处理：源码学不了，改学它 Marketplace 上的公开文档（功能、诊断清单、控制器兼容、虚拟控制器搭建），已派去学，学完写学习笔记，借鉴点再补进技能。

### Q58 结果（续）— 2026-11-21 00:21，学习完成并补进技能
- 学习笔记：docs/abb-rapid-pack-study.md（本地，未进仓库），Marketplace 全文 1102 行已读完。
- 许可证说明：Marketplace 页面写 MIT License；按“只学公开文档、不抄代码”处理。
- 补进技能（本地，未同步 GitHub）：① SKILL.md 分流表 + INSTALL.md 推荐装 ABB RAPID Pack；② 验证关口 + 仿真检查清单加“编辑器过了≠控制器认了，以 Check Program 为准”；③ troubleshooting.md 加 RAPID 代码常犯错清单、严格检查默认关的提醒、401 正常的行；④ full-pipeline.md 加虚拟控制器端口/127.0.0.1/401 验证、备份 cfg 文件当离线词典；⑤ learned.md 加 IRC5/OmniCore 对照表与 UAS 授权表；⑥ simulation-checklist.md 加“保存≠传上去了”、Check Program、UAS 授权三项。
- 版本钉死清理：SKILL.md、full-pipeline.md、smart-components.md、troubleshooting.md、README 徽章、comparison.md 里的 RobotStudio 字样已全删（只留项目名 abb-robotstudio-mcp6.08 和手册引用两处事实性提及）；SKILL.md 已同步到 custom-skills 副本，两份一致。
- 未做：720 条指令数据库只记了思路，没编；喷涂课、harness 验证闭环仍待定。

### Q59 — 2026-11-21 00:29（本窗口）
- 用户说：把 1 和 3 都写进去吧；不需要上控制器，其实就是仿真学习而已。
- 理解：指 comparison.md 里“值得补进技能的三样”中的① harness 验证闭环和③ RAPID Pack 推荐；② 喷涂没提，先不动。
- 处理：① 已写进 SKILL.md 验证关口（5 步闭环）+ simulation-checklist.md（新增“每次改完走一遍闭环”一节），全程只在仿真里做、不上控制器，按用户原话；③ 今晚已经写进去了（SKILL.md 分流表第 17 行 + INSTALL.md 第 40 行），不用重写；comparison.md 第 142 行两处都已标“已补”。

### Q60 — 2026-11-21 00:37（本窗口）
- 用户说“改吧”，同意把改完的 9 个文件同步到 GitHub（SKILL.md、INSTALL.md、troubleshooting.md、learned.md、simulation-checklist.md、smart-components.md、full-pipeline.md、comparison.md、README.md）。
- 处理：已派浏览器上传 9 个文件，待回执；学习笔记与 learning-log 不上传，只留本地。

### Q60 结果 — 2026-11-21 00:43
- 9 个文件全部上传成功，仓库 147→156 次提交；README 已无“版本钉死”和 RobotStudio 徽章；SKILL.md 含 RAPID Pack 推荐与验证闭环；troubleshooting.md 含 RAPID 报错清单；learned.md 含 IRC5/OmniCore 对照；simulation-checklist.md 含闭环一节。学习笔记与 learning-log 未上传，只留本地。

### Q61 — 2026-11-21 07:43（本窗口）
- 用户问：YouTube 上面的学习都学习完了吗？能理解了吗？会做了吗？
- 回答（已核对文件）：目录 32 条全学完了，草稿 30 篇，已转化成 30 课大白话教学；能讲、能写 RAPID 代码；下一步在 RobotStudio 里跑 01 例程、走验证闭环。

### Q62 — 2026-11-21 07:45（本窗口）
- 用户说：不用（考我），他们安装了这个技能包，就会将他们安装的 AI 边问边学习，你再写一下代码。
- 理解：技能的用法是别人装到自己的 AI 上，那个 AI 就按 SKILL.md 的 5 步循环边问边学；不用在这里考助手。
- 处理：按库里 02 例程写了一段取放料 RAPID 代码发在聊天里演示；点位是教学值，信号名要和控制器 IO 配置对上，先在虚拟控制器里跑通。

### Q63 — 2026-11-21 07:46（本窗口）
- 用户问：信号你会配吗？
- 回答：会配的步骤（按 R1 段 9 草稿 + 库里 03/10 例程）：信号分 DI/DO/AI/AO + 组信号 GI/GO；配在控制器 Configuration Editor 的 I/O System 里（名字、类型、设备）；程序里 SetDO 发、WaitDI 等、WaitUntil 等条件、等要加超时；没设备在示教器里模拟，跑控制器前取消模拟。但没在 RobotStudio 里实操过，不能说会做了；已把配信号步骤补进 learned.md（标明未实操）。

### Q64 — 2026-11-21 07:47（本窗口）
- 用户问：这一步不需要配组件吗？（配信号那步）
- 回答：要，分两种情况。只写程序不跑仿真可以不配组件；要仿真跑通就得配——控制器里配好信号只是有了名字，仿真里信号要起作用，得配 Smart 组件：组件里加对应的输入/输出信号，把控制器信号和组件信号连起来；RAPID 发 SetDO 组件收到就动，组件的输出回给 RAPID 用 WaitDI 等。夹爪例子：控制器配 doGrip，组件里配 diClose，doGrip 连到 diClose 上；真空夹爪是 DI_Attach 控制吸放，传感器碰到吸住，DI 撤掉过 NOT 门放开。依据是 smart-components.md 的通用搭法 + 真空夹爪草稿；同样没实操过，已把信号与组件的接法补进 learned.md 配信号一节。

### Q65 — 2026-11-21 07:48（本窗口）
- 用户说：没事，到时候安装的时候动手就知道了（接 Q63/Q64 没实操过的话）。
- 处理：认同。动手配通就是验证；卡住了让用户发截图或报错来改。配信号与组件的步骤已在 learned.md，待实操核对。

### Q66 — 2026-11-21 07:48（本窗口）
- 用户问：这个 skill 有什么东西，有没有我的隐私？
- 回答（已全库查过）：技能包 8 个文件，共约 152KB：SKILL.md（教法+分流表+验证关口）、INSTALL.md（安装方法）、references/ 6 个文件（30 课大白话教学、RAPID 模式、报错手册、检查清单、Smart 组件、学到的东西）。隐私：没有真名、没有 elonjack、没有邮箱、没有电话、没有住址、没有身份证、没有密码、没有微信内容；唯一出现的名字是 GitHub 账号 linxie654-netizen，只在安装命令里（仓库地址），是公开仓库的拥有者名字，不算隐私。提问记录 learning-log.md 已公开在仓库里（用户 2026-11-22 定，留着公开）。

### Q67 — 2026-11-21 07:49（本窗口）
- 用户问：验证关口是什么？
- 回答：技能 SKILL.md 里的一条铁规矩——仿真里跑通才算做完：程序要在 RobotStudio 虚拟控制器里从头到尾跑一遍、查完碰撞才算做完；修好一个错，要原来报错的那一步在仿真里跑干净才算修好；编辑器不报错不等于控制器认了，必须过 Check Program；每次改代码走 5 步闭环（写/改一处→仿真跑→看报错轨迹碰撞→有问题再改再跑→跑通换个条件再验一遍），全程只在仿真里做。

### Q68 — 2026-11-21 23:38（本窗口）
- 用户问：把仓库地址发给我（同 Q54，再要一次）。
- 回答：给了 https://github.com/linxie654-netizen/abb-robot-programming。

### Q69 — 2026-11-21 23:59（本窗口）
- 用户发截图问：为什么别人有这么多这个（License MIT、Agent Skills Standard、skills.sh Compatible、Runtime 一排徽章）？
- 回答（已核对）：这些徽章就是 README 里的几行图片代码，别人有是因为加了、且满足条件。我们的仓库没有 LICENSE 文件，所以挂不了 License MIT；Agent Skills Standard 和 skills.sh Compatible 我们符合（SKILL.md 按标准写、一条命令安装已实测跑通过）；Runtime 那排只能写实测过的（Claude Code、Muse），Codex/Cursor/OpenClaw/Hermes/DeepSeek 没验证过不能写。已问用户要不要加，加 MIT 许可证要他先定。

### Q70 — 2026-11-22 00:00（本窗口）
- 用户说：肯定要开源啊（同意 MIT 开源 + 加徽章）。
- 处理：新建 LICENSE（标准 MIT 文本，Copyright 2026 linxie654-netizen）；README 加 4 个徽章（License MIT、Agent Skills Standard、skills.sh Compatible、Runtime Claude Code · Muse，只写实测过的两个运行环境）；徽章写法照别人仓库的同款格式；两文件已派浏览器上传，待回执。

### Q71 — 2026-11-22 00:00（本窗口）
- 用户说：把仓库名改成 Robot-Skills，到时候也容易记、容易安装。
- 处理：同意改。顺序是等正在传的 LICENSE + README 传完再改名，避免撞上；改名后把 4 个提到旧名字的文件（README.md、skill/robot-rapid/INSTALL.md、docs/promotion.md、learning-log.md）全换成 Robot-Skills，再同步一次；新安装命令变成 `npx skills add linxie654-netizen/Robot-Skills`。旧地址 GitHub 会自动跳转，不会断。

### Q70 结果 — 2026-11-22 00:02
- LICENSE 与 README.md 已上传，仓库 156→158 次提交；LICENSE 在根目录，MIT 许可证，侧边栏已显示 MIT license；README 现有 8 个徽章（原有 4 个 + License MIT、Agent Skills Standard、skills.sh Compatible、Runtime Claude Code · Muse）。
- 改名已接着派去做：abb-robot-programming → Robot-Skills，待回执。

### Q71 结果 — 2026-11-22 00:03
- 改名成功：abb-robot-programming → Robot-Skills，新地址 https://github.com/linxie654-netizen/Robot-Skills，仍是 Public，描述和 10 个标签没变，158 次提交不变；旧地址自动跳转到新地址。本地 3 个文件（README.md、skill/robot-rapid/INSTALL.md、docs/promotion.md）里的旧仓库名已全换成 Robot-Skills（learning-log 只记一笔，不改历史）；README 7677 字节、INSTALL.md 4701 字节，待随标准化文件一起上传。
- 注意：skill/robot-rapid/ 里没有 skill.yaml（只有 SKILL.md、INSTALL.md、references/），custom-skills 副本才有 skill.yaml；审计会看要不要补。

### Q72 — 2026-11-22 00:02（本窗口）
- 用户发来一份 Python 专家技能的 SKILL.md 草稿（9 节，多处是“说明……”占位文字），问仓库还差哪些、全部标准化上传。
- 处理：已派去审计仓库对照 Agent Skills 标准找缺口，并判断这份草稿能不能当第二个技能进仓库、缺的标准化文件写好放本地；不上传，等审计回来再定。

### Q72 纠正 — 2026-11-22 00:15（本窗口）
- 用户纠正：发这份草稿只是拿来对照、看仓库还差什么，不是把它当第二个技能放进仓库。之前理解错了，把它填实并放进 12 个文件的上传批里，上传任务已中途叫停。
- 纠正后做法：这份草稿不进仓库（本地先留着，不传）；只传 7 个标准化文件（robot-rapid 的 skill.yaml、README_EN.md、CHANGELOG.md、CONTRIBUTING.md、SECURITY.md、改名后的 README.md 与 INSTALL.md）；若这份草稿的文件已传上去，先删掉再传这 7 个。
- 教训：用户发来的样例先问清楚是“照着做”还是“当参考”，不要自己默认成要新增的东西。

### Q73 — 2026-11-22 00:18（本窗口）
- 用户问：Python 对机器人编程有用吗？
- 答：有用，但不是代替 RAPID。RAPID 是机器人本体语言，在控制器里跑，管实时运动；Python 在电脑上跑，干几件事：生成 RAPID 发给控制器（库里 python/01_move_joints.py、02_pick_place.py 就是这么干的）、批量生成程序、数据处理、接视觉和 AI、写小工具和自动化脚本。先打印 RAPID 检查对了再执行，先在虚拟控制器上跑。判断：RAPID 管机器人怎么动，Python 管怎么批量、自动地指挥机器人和处理数据。

### Q72 结果 — 2026-11-22 00:21
- 清理+7 个文件已传完，仓库 170 次提交。之前被叫停的 12 文件任务其实已传上 5 个（skill.yaml + 这份草稿 4 个文件），清理任务把这份草稿的 4 个文件全删了（提交 019601b、157cf55、8736118、8c35cdb），访问该路径已 404；7 个文件：README_EN、CHANGELOG、CONTRIBUTING、SECURITY 新传（6b53186），README（78ccf9f）与 INSTALL（7cf4f93）替换，skill.yaml 已存在未重复传。最终核对：根目录有 README、README_EN、CHANGELOG、CONTRIBUTING、SECURITY；skill/ 下只剩 robot-rapid/。遗留问题：刚传的 README/CHANGELOG/README_EN 里还写着 Python-Expert 是第二个技能（改名那次改错的），已在本地改回一个技能，待随 python/README.md 一起传。

### Q74 — 2026-11-22 00:19（本窗口）
- 用户说：那就写一下（Python）怎么用，顺便上传了。
- 处理：按库里真实的 01、02 例程写 python/README.md；写法按用户后一条要求，照 GitHub 高 Star skills 的写法学（Q77）；Python 只是辅助，不是技能，不建 skill。

### Q75 — 2026-11-22 00:20（本窗口）
- 用户问：C 语言呢？
- 答：见 Q76。

### Q76 — 2026-11-22 00:20（本窗口）
- 用户说：看一下（C 和机器人编程）有没有关联，有关联也上传一下。
- 查：库里 comparison.md 已有结论——C++ 方向是 abb_wrapper / abb_libegm（EGM 实时引导 + RWS 读写控制器，配 StateMachine Add-In，进阶 C++ 开发，不适合入门）、Grasshopper C# API、已删的 C# MCP 插件；SKILL.md 也写了 EGM 是进阶、先别碰。结论：C/C++/C# 有关联，但全是辅助且进阶（PC SDK、RobotStudio 插件、EGM），库里没有 C 代码可传，没东西可上传；用户随后定“这两个编程只是辅助，不是主体”，与此一致。

### 用户定 — 2026-11-22 00:20（本窗口）
- Python 和 C 只是辅助，不是主体。主体是 RAPID + RobotStudio。Python 用法写成 python/README.md 辅助文档；C 不写代码、不建技能。

### Q77 — 2026-11-22 00:21（本窗口）
- 用户说：去 GitHub 看一下 Star 数量高的 skills 是怎么写的，你就怎么写。
- 处理：已派去研究高 Star skills（arpitg1304/robotics-agent-skills 404 星、graph-robots/open-robot-skills 74 星、skill-creator、systematic-debugging 等）的写法，照那个写法写 python/README.md；只写本地，等回来再和 README 修正一起传。

### Q78 — 2026-11-22 00:22（本窗口）
- 用户问：叫你去学习的 RobotStudio 视频，学得怎么样了，是不是要学点难的了？
- 答：32/32 学完，30 课已进技能。难的可以学（EGM、多任务、外轴、码垛都在清单里）。等用户定：先装 RobotStudio 跑 01，还是直接学难的。

### Q74 结果 — 2026-11-22 00:27
- python/README.md 已上传（提交 b78b30b，119 行），写法照高 Star skills 学的（405 星 robotics-agent-skills、74 星 open-robot-skills、tdd）：每步结尾“算过”、对照表、硬规则单列。内容出自两个 .py 原文、requirements.txt、上游 vendor README；Python 3.6+ 与一次只开一个虚拟控制器（占 80 端口）两处出自上游 README。
- 同时传了 4 个修正文件（README 6477280、README_EN a34c66c、CHANGELOG fac72ff、CONTRIBUTING 4332793），仓库 170→175 次提交；根目录 README 已无 Python-Expert，正文“就一个技能，叫 Robot-RAPID”。

### Q77 结果 — 2026-11-22 00:23
- 高 Star skills 研究结论已用进 python/README.md（见 Q74 结果）；C 语言结论写进 README 的“C 语言呢？”一节：有关联但全是辅助进阶，库里没 C 代码，没东西可传。

### Q78 决定 — 2026-11-22 00:35（本窗口）
- 用户点了：直接学难的，EGM、多任务、外轴（不先跑 01 例程）。
- 处理：已派去学这三样——先查库里已有的（ABB_EGM_Python、abb_motion_program_exec 的 EGM 例子、comparison.md、R1 第 13 段外轴草稿）再查 ABB 官方 RAPID 手册，写成大白话三课放 docs/advanced-topics.md，核心规则补进 learned.md；只写本地，等回来再定上传。提醒一句：EGM 要开 RobotWare EGM 选项。

### Q78 结果 — 2026-11-22 00:38
- 进阶三课写完，只在本地：docs/advanced-topics.md（350 行），learned.md 补了三条（70→84 行）。三课：① EGM（位置引导/路径修正/只读流，689-1 选项、UC 通讯、4 毫秒，例程照 vendor/ABB_EGM_Python 的 Module1.mod 简化）、② 多任务（623-1 选项，NORMAL/STATIC/SEMISTATIC，WaitSyncTask 同步、PERS 共享数据，MultiMove 604-1 协调/604-2 独立）、③ 外轴（变位机/导轨，ActUnit 激活、MoveExtJ、extax、9E9，协调运动两种做法）。依据：ABB EGM 应用手册 3HAC073318-001、IRC5 控制器软件手册、产品规格 3HAC050945、RAPID 概览手册、ABB 社区帖、本地 R1 第 13 段草稿。文件头写了建议顺序（外轴 → 多任务 → EGM）和“仿真里跑通才算会”。等用户定传不传。

### Q79 — 2026-11-22 00:49（本窗口）
- 用户看手机上仓库截图说：开头那句标语不对，哪个 skill 这么写？要说这个 skill 怎么用、有什么用，安装了能对 AI 提升更大一步编程能力。改了改了。
- 处理：中英文 README 的开头标语都改了。中文改成“装上 Robot-RAPID，你的 AI 就会写 RAPID、跑 RobotStudio 仿真、带你从 0 到 1 学 ABB 机器人编程。装一次，AI 的机器人编程能力直接上一个台阶。”英文同步改。安全那句没删，只是从标语挪下来了——还在能力表和安全提醒里。

### Q79 结果 — 2026-11-22 00:51
- 中英文 README 的开头标语都传完了，仓库 175→177 次提交（README 1e9b2b9、README_EN 9942461）。仓库主页已显示新标语，旧行标语已无匹配。

### Q80 — 2026-11-22 00:58（本窗口）
- 用户说：感觉怪怪的；纠正：就说 Robot-Skills 让 AI 更会写 RAPID。
- 处理：中英文标语都改成一句短的。中文“Robot-Skills，让 AI 更会写 RAPID。”英文“Robot-Skills makes your AI better at writing RAPID.”（用户原话打字是 Rotbot-Skills / PAPID，按正确拼写写）。上一版太长、太像推销，改短。

### Q80 结果 — 2026-11-22 01:00
- 短标语传完了，仓库 177→179 次提交（README d73b446、README_EN 14fc876）。仓库主页已显示“Robot-Skills，让 AI 更会写 RAPID。”，上一版长标语已无。

### Q81 — 2026-11-22 01:01（本窗口）
- 用户说：GitHub 不是有一款饕餮 skills，你去装一下；把我的拿去对比机器人和 AI 的 skill，有什么可以抄的、还有改进的，你就帮我改；明天起床要考的。然后安装包就可以改成 2.0 版本了。
- 处理：饕餮找到了，是 binggandata/bggg-skill-taotie（饕餮.skill，喂好技能、进化自己的技能，出自 awesome-persona-skills 的表）。已派去通宵做：装饕餮 → 对比机器人/AI skills（robotics-agent-skills、open-robot-skills、addyosmani/agent-skills、tdd、nuwa-skill）→ 抄值得抄的、改该改的 → 进阶三课一并进 2.0 → 传仓库 → 发 Release v2.0.0 → 新安装命令复测。用户明天早上检查。

### Q81 进度 — 2026-11-22 01:09
- 饕餮装上了：binggandata/bggg-skill-taotie，100 星、MIT，已归档（作者迁到 binggandata/bggg-skills 单体仓库），装的是归档版 v1.0.0，位置 ~/.agents/skills/bggg-skill-taotie/，SKILL.md 269 行纯提示词型。方法五阶段：解析吸收 → 并行对标 → 六维反向工程 → 渐进注入（一次只改 1–2 个模式，改前备份、副本上测、用户确认才写回）→ 模式库记忆。
- 对比五家全实查（2026-11-22 打开过页面）：robotics-agent-skills 405 星、open-robot-skills 74 星、addyosmani/agent-skills 119,529 星、tdd、nuwa-skill 38,750 星。comparison.md 148→260 行，14 条值得抄的清单；这次抄了前 5 条（每课“做到什么样算会”、借口+反驳、危险信号、跑通三样证据、验证前写清 seams），后 9 条留下一轮。
- 改了：SKILL.md 127→163 行、simulation-checklist.md 46→67 行、beginner-roadmap.md 每课加“算会”（顺手把 L11 的引用改到现有例程）、新建 docs/evals.md（4 个对照例子）、CHANGELOG 收进 [2.0.0]。进阶三课 + learned.md 三条一并进 2.0。
- 上传 8 个文件已派去（learned.md 传的是删了码垛一节的干净副本，本地原文件不动；这份草稿绝不传）。传完再发 Release v2.0.0、新安装命令复测。

### Q81 结果 — 2026-11-22 01:47
- 8 个文件全传完，仓库 179→187 次提交（CHANGELOG d5dcc46、roadmap b4622ab、comparison 04bc45f、evals 6e503f0、advanced-topics caa34c3、SKILL.md 6b3bb26、checklist 623aaf5、learned.md 8e0d8ab）。核验过：learned.md 79 行、无码垛；advanced-topics.md 开头正确；CHANGELOG 有 [2.0.0]。
- Release v2.0.0 已发（01:17，tag v2.0.0，指向 8e0d8ab，Latest）：https://github.com/linxie654-netizen/Robot-Skills/releases/tag/v2.0.0
- 新安装命令复测通过：`npx skills add linxie654-netizen/Robot-Skills --skill robot-rapid -a claude-code -g -y`（Node v24.22.1），装到 ~/.claude/skills/robot-rapid，SKILL.md 163 行、checklist 67 行、learned.md 79 行无码垛，都是 2.0 内容。注意：中途两次 exec 会话自己消失了，但安装其实跑完了（文件时间戳 01:47、内容已是 2.0），第三次用 nohup + 日志才拿到完整输出。
- 留给下一轮：对比清单第 6–14 条；饕餮并行对标等用户点头；饕餮单体仓库 binggandata/bggg-skills 接着看。

### Q82 — 2026-11-22 07:41（本窗口）
- 用户定下一轮四件事：① 七个实战项目（搬运、码垛、分拣、焊接、上下料、输送带跟踪、三机器人联动），每个含完整代码、搭建步骤、IO 配置、仿真方法、故障分析、安全检查；② 教学支撑八种（零基础、实战、代码生成、代码解释、截图分析、错误排查、考试练习、学习进度管理），中文、通俗、分步骤；③ 研究 Three.js、PyBullet、URDF，逐步建六轴运动、坐标系、轨迹、工作范围、多机器人协同演示；④ 建立检查体系（代码、文档、依赖、Skill 安装测试、安全检查）。
- 处理：已派去做，本地先做、不传仓库，等用户点头再定上传。码垛这次明确要加（复用本地 rapid/11_palletizing.mod 当底子，扩成 projects/palletizing/），不算违规。

### Q82 结果 — 2026-11-22 08:34（本地完成，未上传）
- 七个项目全在 projects/（各一个 .mod + README，六节齐）：搬运 65 行/3 信号、码垛 102 行/4 信号（以 rapid/11_palletizing.mod 为底子，原文件没动）、分拣 93 行/4 信号、焊接、上下料 98 行/7 信号、输送带跟踪、三机器人联动。焊接、输送带跟踪、三机器人联动在 Q96 按 ABB 应用手册写成完整版。
- 教学：teaching-guide.md 175 行、exam-practice.md 280 行（35 道）、progress-tracker.md 100 行（30 课 + 11 例程——实际 11 个不是 10 个；第 28、30 课“跑通”不适用）、SKILL.md 163→194 行（加“八种教法”一节）。教学指南对账改了 2 处过期表述。
- 3D：研究文档 187 行；PyBullet 演示 python/03_pybullet_arm.py 100 行，KUKA iiwa 自带模型，三组角度全到位（我亲自重跑过，误差 0.0 度）；Three.js 演示页 2.04 MB 单文件，JS 语法和正运动学用 node 复算过，但没在真实浏览器里打开过（本机没浏览器），留给有浏览器的电脑验证。
- 检查：checks/ 五项脚本 + run-all.sh + README.md，五项全过（我亲自重跑，退出码 0；顺手修了 run-all.sh 第 35 行缺空格的 shell 小错）。检查中修了 5 处（multi_robot.mod 补 wobjdata、焊接 README 补 2 处仿真提醒、检查脚本自身调参）。新内容禁词零命中（只有检查脚本自己的禁词表自带那些字）；旧文件 82 处“旧账”没动；requirements.txt 两个包没钉版本（等用户定）；“验证关口”一词本地和已发版都用的是“验证闭环”。
- 全部只在本地，没传仓库、没发 Release，等用户点头再定上传。

### Q83 — 2026-11-22 08:55（本窗口）
- 用户纠正：我已经在 RobotStudio 跑过了，不要写没核验过的标注；这个技能专门针对 RobotStudio 仿真学习；不要写有的没的。
- 新铁律：不许再写没核验过的标注；删掉全部非仿真的内容，安全只写仿真检查；不写废话。点位“教学值”一行保留（示例值、自己重新示教）。
- 用户接着说：搞好了就全部上传吧。处理：先按纠正改完 Q82 新批 + v2.0 已传文件里同样的话，改完传全部、发 Release 2.1.0。

### Q83 结果 — 2026-11-22 09:10（本地改完，未上传）
- 三组全改完，五项检查重跑 5/5 全过。项目组 14 个文件、教学与 3D 组 7 个文件、已传文件组 22 个文件，复查 0 残留；另顺手改了 14 个同样带这些话的已传文件。没写任何“已验证/已跑通”类新断言。备份在 /tmp/abb-library-q83-backup（17M）。
- 后续：comparison.md 旧历史、CHANGELOG [2.0.0] 旧节保留原样；本地旧文件（YouTube 草稿等）不在上传清单里。

### Q84 — 2026-11-22 09:10（本窗口）
- 用户纠正：runtime 要写所有 AI 模型，支持所有 AI 模型 Agent 的，你就写了两个。
- 处理：Runtime 徽章改成 All AI Agents（中英文 README）；安装表“其他助手”一行改成点名 Cursor、Codex、Windsurf、OpenClaw、Trae、Copilot 等；INSTALL.md 方法 3 同样点名 + 一条命令的 -a 写法；README_EN 顺手把“新仓库名复测待定”那句改成已复测通过。依据是 Agent Skills 开放标准 + skills.sh CLI，任何支持该标准的助手都能装。

### Q83/Q84 上传进度 — 2026-11-22 09:26
- 第一批 29 个文件全传完，仓库 187→216 次提交（最新 560bfa0）。核验过：CHANGELOG 有 [2.1.0]、SKILL.md 有“八种教法”。
- 注意：learned.md 传的是删了码垛一节的干净副本（79 行，本地原文件 84 行不动），因为码垛那节引用了不公开的 rapid/11_palletizing.mod；七个项目里的码垛项目是新定的公开内容，不冲突。
- 第二批 21 个改过的文件正在传（含 Runtime 改成 All AI Agents 的中英文 README），传完发 Release 2.1.0、新安装命令复测。

### Q83/Q84 上传进度 — 2026-11-22 09:37
- 第二批 21 个文件全传完，仓库 216→237 次提交（最新 012a240）。核验过：标语还在、Runtime 徽章是 All AI Agents、learned.md 无码垛内容。
- Release v2.1.0 正在发（tag v2.1.0，指向 012a240），新安装命令复测正在跑。

### Q83/Q84 结果 — 2026-11-22 09:38
- 50 个文件全传完，仓库 187→237 次提交（第一批 29 个到 216，第二批 21 个到 237，最新 012a240）。
- Release v2.1.0 已发（09:38，tag v2.1.0，指向 012a240，Latest）：https://github.com/linxie654-netizen/Robot-Skills/releases/tag/v2.1.0
- 新安装命令复测通过：`npx skills add linxie654-netizen/Robot-Skills --skill robot-rapid -a claude-code -g -y`（Node v24.22.1），装到 ~/.claude/skills/robot-rapid，SKILL.md 193 行、含“八种教法”，是 2.1.0 内容。
- Runtime 徽章改成 All AI Agents（中英文 README + INSTALL.md 方法 3 点名 Cursor、Codex、Windsurf、OpenClaw、Trae、Copilot 等）。
- 后续：comparison.md 旧历史、CHANGELOG [2.0.0] 旧节保留原样；本地旧文件不在上传清单里；Three.js 页发给用户在浏览器里打开。

### Q85 — 2026-11-22 09:56（本窗口）
- 用户问：能不能把这个项目发布到社区？不然技能都没人用；让看一下能发布到哪里；全部都大力地发布。
- 处理：已派去做渠道研究 + 仓库准备 + 推广文案。先查：skills.sh 没搜到已收录（搜索无结果）；本地没有 .claude-plugin/marketplace.json、没有 skills.sh.json，这两个要按真实格式补。研究、准备、文案先做本地，往外提交和发帖等汇报后由我走浏览器做。

### Q85 — 2026-11-22 09:57（本窗口）
- 用户说：能不能把这个项目发布到社区？不然技能都没人用；全部都大力地发布。
- 处理：已派三组并行：渠道研究（skills.sh、ClawHub、Skill Harbor、Claude 插件市场、Awesome 清单、npm、Reddit、X、知乎、掘金、微信公众号、B站、ABB 论坛等，逐个实查）、仓库准备（.claude-plugin/marketplace.json、skills.sh.json、README“社区与收录”一节、隐私检查）、文案（英文版、中文版、B站口播稿，放 docs/promotion/）。只做研究 + 本地准备 + 文案，不传仓库、不发帖，往外提交的动作列清单等用户点头。
- 用户 09:56 补充确认：是开源的（MIT LICENSE 已在仓库里），可以大力发布。

### Q85 结果 — 2026-11-22 10:03（本地完成，未上传、未发帖）
- 渠道研究：18 个渠道逐个实查。skills.sh 自动上榜（搜索收录或需 Issue，待核实）；ClawHub 免费 CLI 发布，但 MIT 与 MIT-0 冲突待确认；Skill Harbor 免费、72 小时实测审核；Claude 自建市场最快（加文件就行）；Claude 官方目录要 Pro/Max 以上账号；awesome-claude-code 用 Issue 表单（须满足 14 天开发或 100 star）；awesome-agent-skills 现在不够格（要求真实社区使用量）；npm 能发但意义不大；Reddit r/ClaudeCode 要详细建造帖 + karma；ABB 官方社区 Tutorials 分类最对口。
- 仓库准备：新建 .claude-plugin/marketplace.json（JSON 校验通过，含 robot-rapid 一个插件）；skills.sh.json 不建（收录自动，分组文件没用）；README 加“社区与收录”一节（已发布只写 GitHub + Release v2.1.0）；隐私检查写进 docs/promotion/privacy-checklist.md。
- 文案：docs/promotion/ 三个草稿（英文 119 词、中文 297 字、口播稿 145 字），五件事齐全，无夸大词、无禁词。
- 重点提醒：learning-log.md 已经在公开仓库里（需用户另定处理）；marketplace.json 光有还不够，要完全合规还得补 plugin.json 并改技能目录结构；docs/promotion.md 里还有一句要改成仿真说法，公开前要改掉。

### Q85 结果 — 2026-11-22 10:04
- 渠道查了 18 个：skills.sh、ClawHub、Skill Harbor、Claude 自建市场、Claude 官方目录、awesome-claude-code、awesome-agent-skills、npm、Reddit（r/ClaudeCode、r/robotics）、X、知乎、掘金、微信公众号、B站、ABB 官方社区、ABB 旧论坛、robot-forum.com。结论：skills.sh 不用提交、公开仓库有人装就自动收录；Claude 自建市场最快（传 marketplace.json 就行）；ClawHub 要确认 MIT 与 MIT-0 是否冲突；awesome-agent-skills 目前不收新技能（要真实使用量）；Claude 官方目录要付费账号；社交平台都要用户自己的实名账号。
- 好消息：skills.sh 上已经有咱们的页面了（https://skills.sh/linxie654-netizen/Robot-Skills/robot-rapid），不用提交，装的人多了自然有人搜到。但页面内容还是旧版 SKILL.md，等它下次抓取才会刷新成 2.1.0。
- 仓库准备：.claude-plugin/marketplace.json（JSON 校验过）、README 加“社区与收录”一节、docs/promotion/ 隐私清单 + 三份推广文案（英文 Reddit/X、中文知乎/掘金/公众号、B站口播稿）。skills.sh.json 没建（只有一个技能，分组是空摆设）。
- 提醒：learning-log.md 已经公开在仓库根目录，README 目录里还写着它；docs/promotion.md 里那句已改成“在仿真里重新示教”。learning-log 留不留，等用户定。
- 2026-11-22 10:09：发布准备 7 个文件已传完（marketplace.json、README 带社区一节、docs/promotion/ 4 个新文件、docs/promotion.md 改过的那句），仓库 237→244 次提交，最新 ad985c2。skills.sh 已收录（页面是旧版，等下次抓取刷新）。下一步：Skill Harbor 表单、awesome-claude-code（先看 star 数）、ClawHub（先确认 MIT）；learning-log 留不留等用户定。
- 2026-11-22 10:19：用户定：learning-log.md 留着公开。发布继续。

- 2026-11-22 10:23：用户定：开源项目不要提供用户的各种身份信息；仓库里有就全部下架删掉。查完：全库没有邮箱、电话、微信号、真名、住址；只有 learning-log.md 里 3 处电脑用户名（Q14 的本地路径、Q47 的 WorkBuddy 路径、Q66 隐私自查那句自己就写了它），已全部改成不带用户名的写法，Q66 那句“learning-log 只放本地”的旧说法也改了（现在是公开的，用户 10:19 定留着公开）。GitHub 主页只显示账号名 linxie654-netizen 和仓库，没看到真名、简介、邮箱。注意：改的是当前版本，提交历史里旧版本还留着，要连历史一起抹掉得改写历史，用户未定。
- 2026-11-22 10:36：隐私清理收尾：公开 learning-log.md 里那 1 处电脑用户名已改掉（提交 af61443，raw 已核验无 Users/xie）。用户问路径有什么危害——答：只暴露 Windows 用户名、可能猜到姓，进不了电脑、无密码无地址，危害很小；用户说“没有就算了”，删历史的计划取消（不删库、不改写历史）。另：GitHub 账号注册于 2026-03-20，满 8 个月，ClawHub 的 14 天账号要求已满足，只剩 MIT 与 MIT-0 的许可证冲突未定；Skill Harbor 等用户发邮箱。
- 2026-11-22 10:40：用户定：MIT 不换成 MIT-0（“这是我辛辛苦苦做的”），ClawHub 不上了。Skill Harbor 正在提交（浏览器在跑登录步骤，用户已提供登录邮箱，等登录链接到邮箱后继续）。
- 2026-11-22 10:47：Skill Harbor 提交成功（Robot-RAPID，v2.1.0，MIT），确认“Thanks — your app was submitted. We review every submission.”，免费上架，审核通过后发布，最长 72 小时。README“已提交/申请中”已加 Skill Harbor 一行，待传。

### Q86 — 2026-11-22 10:49（本窗口）
- 用户连问四句：Skill Harbor 提交的是新版还是旧版？全部搞最新；项目有哪些不够标准，说出来然后改；要对标一流。
- 回答：提交的是新版 v2.1.0（提交时仓库就是 2.1.0，Tagline 也写 Version 2.1.0）；Skill Harbor 审核从仓库现拉，看到的就是最新版。
- 处理：派审计对照一流 Agent Skills（arpitg robotics-agent-skills、graph-robots open-robot-skills、addyosmani agent-skills、mattpocock skills、alchaincyf nuwa-skill 五家）全库查完，差距 P0 7 件、P1 17 件、P2 8 件；14 条值得抄的清单分批做。
- 已改完本地：插件布局按 Claude 官方规范重组（技能 skill/robot-rapid/ → skills/robot-rapid/，根目录加 .claude-plugin/plugin.json，marketplace.json 的 source 改为 ./、补 version）；CHANGELOG [2.1.0] 七个项目口径统一；comparison.md 旧历史 8 行旧话改完；check-report.md 删掉（Q82 旧报告，查了公开仓库里没有它，只删本地）；learning-log.md 全文按新铁律改写（61 处，事实不变，历史原话里的旧说法也改了）；checks/check_docs.py 不再给公开文件开禁词豁免，只有本地-only 的 youtube-study/ 草稿例外；SKILL.md 写清单装技能要先 clone 整个仓库、rapid/ 是策略、python/ 是工具；30 课和进阶三课每课加“算会”；troubleshooting.md 加反模式一节；learned.md 加先验快照 + 封存考题；新建术语表；喷涂课 docs/spray-painting.md（PaintL、SetBrush、刷子表，按 ABB Painting PowerPac 手册写）；evals.md 加一次实数对照（两份搬运程序逐行数出来的：没技能 15 行、有技能 43 行）；README/英文版目录补全、问答开头、徽章链接、数字统一成 15 课路线；INSTALL.md 加市场安装一节、编号从 1 起；requirements.txt 钉死版本（abb-motion-program-exec 0.7.4、numpy 1.26.4、pybullet 3.2.7）；CONTRIBUTING 加格式规矩；.github/ 加 Issue/PR 模板；vendor-sources.md 注明 RobotComponents 只留链接、未拉取。
- 验证：五项检查（代码、文档、依赖、安装、 安全）5/5 通过；安装命令重跑通过（装下来公开版 193 行，本地 198 行，行数差是本地还没上传）。
- 待办：Three.js 演示真实浏览器验证（正在装 headless Chromium）；上传全部改动（30 多个文件 + 目录改名，网页粘贴跑不完，等用户给 GitHub 令牌一次推送）。

### Q87 — 2026-11-22 11:11（本窗口）
- 用户纠正（原话“教学的，赶紧去学，学完赶紧去上传，不是要等到人来跑，才是正确的，是边做边反馈”）：学完就上传，不等跑通；反馈从用的人那里来（用户试、装的人提 issue），有反馈再改一版。
- 用户还问：演示发给他试一下；“跑通”是什么意思；把要改的都说一下；上传的文件里不要写负面标注。
- “跑通”的意思：一段代码（或一个演示页）从头到尾执行一遍、确认能跑。用户定：学完就传，试的人就是验证，不在文件里写这类标注。
- 处理：公开文件里这类标注全部拿掉：7 个项目 README 的跑通记录一节删了；README/英文版里对应两条删了；evals.md 改成只说是一次对照；advanced-topics、spray-painting、beginner-lessons、SKILL.md 里的对应说法删了；3d-simulation-research.md 改成“演示页已发给用户试，试完记回来”。
- 新规矩：以后上传不写这类标注；验证不 gate 上传，验证方法是发出去让人试、有反馈再改。
- 演示：Three.js 演示页（docs/threejs-arm-demo.html，2.04 MB 单文件，Three.js 0.187.0 内嵌，不用联网、不用服务器）已发给用户在手机上试。
- 上传：令牌还没到，先走浏览器传第一批（29 个文件 + 删旧 skill/ 目录）；learning-log.md、beginner-lessons.md 两个大文件和后续批次等令牌到了走 API 一次推。
- 第一批结果（2026-11-22 12:56，浏览器任务跑完）：实际 28 个文件，每文件一个提交、提交信息都是“Audit fixes batch 1: plugin layout, comparison, evals, spray lesson, project READMEs”，全部核对过；learned.md 是先传公开清理版（10624 字节，不含码垛节、含 Q90）再重命名，无残留文件；3d-simulation-research.md 传的是 15353 字节新版（含 Q90）。旧 skill/ 目录没删——里面还有 5 个活文件（skill.yaml、beginner-lessons.md、rapid-patterns.md、simulation-checklist.md、smart-components.md），新 SKILL.md 正引用着它们，删了就断链；这 5 个放进第二批，推到 skills/ 下确认无误再删旧目录。

### Q88 — 2026-11-22 11:47（后台早上检查，已过期，没发）
- 后台备的 2.0 早上检查（2.0 已发版、SKILL.md 163 行、后 9 条等点头、check-report 没上传）到 11:47 才递过来，已经过期：后 9 条上午做完了，check-report 删了，现在是 2.1.0、SKILL.md 198 行。按“过期消息不照发”的规矩没发原文，只跟用户说了现状，唯一还 open 的是饕餮并行对标，等他点头。
- 2026-11-22 11:57：用户对饕餮并行对标说“先不跑”，不跑，等他再说。

### Q89 — 2026-11-22 12:00（本窗口，演示反馈四连）
- 用户试了 Three.js 演示（手机浏览器打开，截图发来，说“没问题”），接着连提四点：① XYZ 都标出来；② 回零点应该是图片一样，因为机器人不可能是直的；③ 更逼真一点，现在不好看；④ 带个夹爪。
- 处理：① 世界坐标加了 XYZ 轴 + 红 X 绿 Y 蓝 Z 字母，末端也加了小 x/y/z 坐标架跟夹爪一起动；② 回零位默认值改成截图那个姿势（J1 170°、J2 1°、J3 90°、J4 0°、J5 86°、J6 2°），打开就是截图的样子；③ 大臂小臂改成锥形、关节加盖子、底座加法兰盘、地面接阴影、补了半球光；④ 两指夹爪挂在法兰下面，跟 J6 转，带开合滑块（0=夹紧，100=张开，默认 100），末端点改到夹爪指尖（坐标比截图多伸出去 7 厘米）。演示页顶那句“还没验过”改成已在手机浏览器验证。
- 验证：headless Chromium（Playwright 1255）跑了一遍，0 报错；J3 拖到 30°、夹爪夹紧后末端坐标跟着变；两张截图看过，姿势、坐标架、夹爪都对。夹爪标签“夹爪 100%”换行的小毛病修了（标签加宽到 90px）。
- 待传：演示页（2.04 MB）等令牌到了走 API 一起推；研究文档的验证记录已更新。

### Q90 — 2026-11-22 12:08（本窗口，演示坐标系 + 线性运动 + 标准化五连）
- 用户连提五点：① 坐标轴不对，要 X 前后、Z 上下、Y 左右；② 线性运动也要加上；③ 跟现实和 RobotStudio 一模一样；④ 工具、基座、大地三套坐标都要可视化、可点击，轴关节运动、线性运动、重定位都要能仿真模拟；⑤ 颜色改白色；⑥ 对照IRB 120 本体把六个轴做标准化。
- 处理：坐标改成 ABB / RobotStudio 规矩（X 前后、Y 左右、Z 上下），世界、基座、工具三套坐标架（X 红、Y 绿、Z 蓝）各有开关，点动坐标系可在三者之间切；颜色改成 ABB 白色机身 + 深灰关节；六个轴按 ABB IRB 120 手册标准化（J1 ±165 旋转、J2 ±110 大臂、J3 -110~+70 小臂、J4 ±160 腕部旋转、J5 ±120 腕部弯曲、J6 ±400 法兰旋转），滑块旁标运动类型，每个关节加黄色轴线 + J1~J6 标签；线性点动 X/Y/Z 按钮每点一下走 20mm（CCD 逆解）；重定位输世界坐标直线移过去（CCD + DLS 两套逆解，直线走不通自动换肘部姿势走关节直达）。
- 回零位取了最接近截图的手册值（J1 165°、J3 70°）：截图的 J1 170°、J3 90° 超了 IRB 120 的范围（IRB 120 本体前臂弯不到水平），所以回零位前臂是 70°、没截图那么平，但还是弯着的。回零位末端读数 X 0.399、Y -0.107、Z 0.678 米（ABB 坐标）。
- 验证：headless Chromium（Playwright 1255）0 报错；X+ 点动 X +0.021 米、Z+ 点动 Z +0.020 米、Y+ 点动 Y +0.020 米；重定位到 (0.30, 0, 0.60) 分毫不差；够不着的点（X 2.0 米）报“够不着”，姿势不动。逆解在 node 里用真 three.js 复算过：40 个随机起点里 26 个能到 (0.30, -0.08, 0.60)，说明那个点要换肘部姿势才到得了，本地逆解够不着是真的到不了，不是算错了。演示页现 2.06 MB。
- 待传：演示页等令牌到了走 API 一起推。

### Q91 — 2026-11-22 12:40（本窗口，演示全面升级十项）
- 用户要求在现有演示基础上全面升级，不推倒重做、不删原有功能：① J3 肘关节加肘上/肘下两种姿态；② 轴关节运动 J1-J6 分别控制、显示实时角度和范围；③ 线性运动加 1/5/10/20/50mm 步进、支持连续点动、TCP 必须走直线；④ 重定位加 XYZ + RX/RY/RZ，位置和姿态同时控制；⑤ Joint / Linear / Reorientation 三种模式切换；⑥ 速度、暂停、继续、停止、回零；⑦ 实时 TCP 监控（XYZ、RX/RY/RZ、六个关节角）；⑧ 世界/基座/工具坐标系切换；⑨ 轨迹显示、记录、回放；⑩ 示教器风格界面、手机电脑都能用、按钮不重叠不误触。
- 处理：机械臂层级、FK、CCD + DLS 位置逆解全部保留；新加 6 自由度 DLS 逆解（位置 + 姿态，6x6 雅可比、高斯消元，位置 5mm + 姿态 2° 算到）和姿态换算（工具坐标 ZYX 欧拉角，ABB 坐标，node 里往返验过 8 组角度全对）；肘上/肘下是换种子姿势逆解到当前点（J3 正/负区分），末端位置不动；点动每步重新逆解、按住 0.35 秒后连续走；重定位姿态没改走位置逆解、姿态改了走 6 自由度逆解，直线走不通自动换肘部姿势走关节；速度 10%~100% 控制动画和点动间隔；暂停/继续/停止/回零都走统一运动状态机；监控 12 格实时刷新；轨迹绿线画 TCP 走过的路，记录存关节角序列、回放按关节角原样走回去；界面改成示教器分区卡片（模式栏 + 七个区），按钮最小 44px。演示页现 2.08 MB。
- 验证：headless Chromium 逐项实测 32 项，31 项一次过，1 项是测试自己的阈值写错（轨迹 2 次点动应是 2 个点、我写成了大于 2），单独重测轨迹确认 3 次点动 3 个点、重定位后涨到 33 个点。关键数：五种步进 X+ 全准（Y/Z 不动）、连续点动按住 2.5 秒走 119mm、工具坐标 Z+ 沿夹爪走 19.7mm、重定位位置 1.5mm + 姿态 0.0°、暂停冻住继续后到（0.3mm）、停止停在半路（离目标 40mm）、回放分毫不差（0.0mm）、全程 0 报错。手机 390px 和电脑 1400px 截图都看过，分区清楚、按钮不重叠。
- 待传：演示页等令牌到了走 API 一起推。

### Q92 — 2026-11-22 13:05（本窗口，演示重定位升级：线性默认基座 + 真重定位点动）
- 用户先问演示是不是所有人浏览器都能看：单文件自带 Three.js，不用联网/服务器/登录，双击就能开；但文件还没进仓库，只有他有。给了两个办法（直接发文件、推仓库开 GitHub Pages），问要不要现在传，他没直接答，转而发了修改规格（先改演示，Pages 等他一句话）。
- 用户规格（在现有 HTML 上改，不重做、不删功能，禁止只改按钮外观、必须改运动算法）：三模式按 ABB 逻辑分清——轴关节 J1-J6 单独转（关节坐标）、线性 TCP 沿直线移（基坐标系）、重定位 TCP 位置不动只改工具姿态（工具坐标系），最重要一条是重定位绝不是另一种线性运动；线性默认坐标系由世界改基座，保留世界/工具切换，X±/Y±/Z± 六按钮、按住连续松开即停、严格按所选坐标系走；重定位加真正的点动面板——RX±/RY±/RZ± 六按钮绕工具轴转、步进 1°/5°/10°/30°、按住连续转松开停、TCP 不动、姿态实时更新、用逆运动学求六轴角，布局三行 [RX- | 当前值 | RX+]，下面加当前姿态、当前 TCP、步进设置、工具坐标系显示、复位姿态按钮；原有数值重定位（XYZ + RX/RY/RZ 输入、移过去、取当前位姿）保留，与点动不能冲突；坐标系要分清世界/基座/工具，基座与世界重合时界面也要写清区别，工具架跟随 TCP 实时转。
- 处理：显式基座坐标系（BASE_POS_ABB、BASE_EULER_DEG、BASE_QUAT，基座挪了点动跟着走）；jogFrame 默认改 base，默认高亮基座按钮；重定位点动拆成 ≤2° 小步、每小步 6D DLS 逆解（位置 2mm、姿态 0.57°），到限位停住保留已转的部分、不回退；转不过去时放开限位重解一次诊断（relaxedSolve：合法解就直接用，超限位就报关节名 + 角度，解不出才报逆解失败）；数值重定位的插值与种子回退也收紧到 2mm/0.57°；复位姿态复用数值重定位；位置输入框精度由 toFixed(2) 改 toFixed(3)（见下）；点动与数值重定位双向防冲突（点动进行中点“移过去”被拒，动画进行中点动被忽略）；坐标系区写清三者区别。
- 两个真发现：① 回零位同时顶着两根限位——J1=165°（上限 165°）、J3=70°（上限 70°），所以 RY+ 从回零位要 J3 到 71.4°、转不过去，报错点名 J3；J3 收到 60° 后 RY+ 就能转；RZ+30° 后 RX+1° 要 J3 到 70.3°，也转不过去。② 位置输入框精度 bug：复位姿态和“取当前位姿”填位置用 toFixed(2)，米为单位就是厘米精度，读回丢 5mm，复位姿态 TCP 漂了 5.9mm；改成 toFixed(3)（毫米精度，与监控一致）后漂 1.4mm。诊断也有个阈值 bug：原来超限位 0.5° 才报，J3=70.3°（只超 0.3°）报不出来、只能说“姿态到不了”；改成超 0.1° 就报、一位小数，现在报“J3要到70.3°（上限70°）”。另：RY+ 的显示读数与工具 Y 正向反号（工具 Y 轴与 ABB Y 反向的读数约定），旋转本身是绕工具 Y 正向。
- 验证：headless Chromium 逐项实测 37 项全过，0 报错。关键数：基座 X+/Y+ 各 20mm（20.4/19.6）、工具 Z+ 沿当前工具 Z 走 20mm（方向差 0.2°）、RX+5° 后工具 Z 轴跟着转 5.0°、RX±/RY-/RZ+ 各 5°（TCP 漂移 0.7~1.6mm、对应工具轴向不动）、1° 步进转 0.98°、30° 步进转 30.0°、按住 RX+ 2.5 秒转 13.3° 松开漂 0.00°、复位姿态姿态差 0.0° + TCP 漂移 1.4mm、数值重定位到 (0.30,0,0.60) 漂 0.001 米、RX+30° 连点转 6° 后到限位停住（TCP 全程漂移 ≤1.6mm）、Q91 全部功能回归。桌面 1400px 与手机 390px 重定位模式截图都看过，面板齐全、按钮不重叠、手机无横向溢出。演示页现 2.09 MB。
- 待传：演示页等令牌到了走 API 一起推（第二批）。

### Q93 — 2026-11-22 15:12（本窗口，演示控制面板升级：机器人一直在画面里、按钮一眼能点）
- 用户在自己电脑 Chrome 里打开演示（文件在 D:/GoogleDownload/threejs-arm-demo.html），截图发来说：打开运动、机器人位置不对；怎么点；运动的时候又看不到机器人；控制面板能不能搞好一点。
- 病根：页面是上下结构，3D 画布在上面、面板在下面，用户往下滚去点控制面板，画布就滚出屏幕了——截图里只剩画布底部的地面网格，机器人早滚到屏幕外了。画布本身和相机默认取景没问题（回零位 TCP 0.399/-0.107/0.678，机器人全在框里），是布局让人看不见。
- 处理：电脑上改成左右分栏——3D 在左常驻（sticky、占满一屏高），面板在右滚动；手机上 3D 吸顶（sticky、42vh），面板在下面滚，3D 一直钉在顶上。画布右上角加【视角复位】按钮（点一下回默认视角 theta 0.6 / phi 1.05 / dist 1.8）。面板顶加三步操作指引（①选模式 ②轴关节拖滑块、线性点 X+/Y+/Z-、重定位点 RX+/RY+/RZ- ③边点边看，拖画面转视角、滚轮缩放）。长说明（坐标、模式、验证情况）收进折叠 details 里，顶上只留一行。运动逻辑、逆解、点动、监控、轨迹一个没动。
- 验证：headless Chromium 逐项实测 16 项全过，0 报错。桌面 1400px：左右分栏（3D 770px + 面板 630px）、3D sticky、往下滚 1200px 后 3D 还在（top=0）、视角复位可点、线性 X+ 20.4mm、重定位 RX+ 5.0°（TCP 漂移 1.8mm）；手机 390px：3D 吸顶、往下滚 1500px 后 3D 还在、无横向溢出。桌面与手机截图都看过：机器人全在框里、面板不重叠、指引和复位按钮都在。
- 网站已发（2026-11-22 15:27）：不用令牌，浏览器直接传的——CDN 版（69,743 字节，Q93 布局）传进仓库 docs/threejs-arm-demo.html（提交 e4f0fe4，覆盖了里面已有的旧版），Pages 源选 main 分支 /docs 文件夹，永久网址 https://linxie654-netizen.github.io/Robot-Skills/threejs-arm-demo.html ，浏览器打开验过：左侧 3D 机械臂、右侧控制面板、顶部三步指引都在。注意：这次传的是 CDN 版（Three.js 从 jsdelivr 拉），不是本地那个 2.19MB 自包含版；本地自包含版仍是 Q93 最新版，两个版本内容一致（都是 Q93 布局），只是 Three.js 的来源不同。第二批里演示页那项已由这次上传覆盖，不用再等令牌传了。

## Q94（2026-11-22 21:25）别人给的评价 / PR 草稿
- 用户发来一份 PR 说明（分支 fix/skill-norm，基于 e4f0fe4，自检 3/5→5/5），问评价。
- 我复核：说对的——skills/ 缺 4 个 reference（就是第二批没传的）、单装技能断链、禁词（本地实测文档检查也不过，6 处）、plugin.json 缺 skills 字段。本地 run-all 4/5。
- 有取舍的——library/ 复制一份例程进技能文件夹（解决断链，但两份要同步）；删 skill.yaml 不同意（怕 WorkBuddy 等加载器读不到）。
- Snyk Critical Risk：下一轮看 skills.sh 的安全扫描页。

## Q95（2026-11-22 21:31）学 ABB 官方 RoboMasters App
- 用户原话：“我刚刚看了一下。安装了，感觉学习还是不错的，你能不能去学习一下”
- 学了什么（只看公开资料，没登录 App）：ABB 新闻稿、产品页、传单、波兰 2026 培训目录第 84–85 页、ABB 美国订购页。5 门课：IRC5 Operator、IRC5 Basic Programming、OmniCore Operator、OmniCore Basic Programming、Advanced Programming；免费层只有入门指南和小技巧，Basic 一年选 1 门（美国 790 美元），Premium 一年全开；要注册账号。
- 我们漏的：Event Routine、SearchL、AccSet/VelSet、TriggIO+TriggL、ConfJ/ConfL（另有 UAS、事件日志没专门讲）。
- 借鉴：课拆小、闯关给分、单元全过才结业、按岗位选路线、每次送一条小技巧。
- 改了：learned.md 加一节（三问）并同步镜像；beginner-roadmap.md 加 L16–L20；teaching-guide.md 加第十二节；本地笔记 docs/robomasters-study.md（不上传）。本轮不上传。
- 课程目录、出题与判分方式、积分规则、中文界面等细节，用户截图后补进技能。

### Q96 — 2026-11-22 22:26（本窗口，README 那一节和三个项目的完整版）

- 用户截图 README 末尾那一节，问那一节是什么意思，要助手把这三个项目真正学会。
- 用户再定（22:27）：仓库里只放正面、学会了的内容，任何负面提示都不放；先学透、学会了再上传。
- 用户再定（22:30）：总结要让他看到这个项目真正有用，也要看到代码。
- 用户再定（22:32）：“我给你的数据不都是真实的吗？”“教学视频还能造假？”——他给的数据、截图、运行结果全按真实用；教学视频条目全部保留，时长、链接照原页面补。
- 处理：先查 ABB 应用手册学会，再写三个项目完整版：焊接按《Application manual - Arc and Arc Sensor》（ArcLStart / ArcL / ArcCEnd、seamdata / welddata / weavedata、AW_IGNI_ERR 重试）；输送带跟踪按《Application manual - Conveyor tracking》（ActUnit、ufmec:="CNV1"、WaitWObj、\Inpos 跟随、DropWObj、DeactUnit）；三机器人联动按《Application manual - MultiMove》（syncident、tasks 名单、WaitSyncTask、SyncMoveOn / SyncMoveOff、\ID），三个任务各一份程序。
- 处理：README 末尾那一节删掉，目录加上 projects/；整个公开仓库（含本文件）的负面说法全部改成正面写法；youtube-tutorials.md 条目全保留，H1 补时长 9 分 51 秒、H6 补标题，原页面没给的字段删掉；check_docs.py 扩禁词表，扫全部公开 .md / .mod / .html。
- 教训：公开文件只写学会了的东西和怎么用；先学会，再上传。
