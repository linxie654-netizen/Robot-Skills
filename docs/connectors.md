# 连接器怎么搞：连上 RobotStudio 6.08 的 3 条路

更新：2026-11-20。先说结论：RobotStudio 本身没有给 Muse 的现成连接器，Muse 在云端也连不进你电脑。但下面 3 条路是真实存在的，网上能查到。

## 路 1：MCP 服务器 + ClaudeBridge 插件（直接对 6.08，最对口）

项目：ABB RobotStudio MCP Server，作者 PMinhDuc204，Glama 页 `abb-robotstudio-mcp6.08`，版本 3.1.0。
- 原理：TypeScript MCP 服务器 + C# 插件 ClaudeBridge。MCP 客户端 -> Node.js 服务器 -> 两条线：`rs_*` 工具经 HTTP 到插件（127.0.0.1:58080），插件再调 RobotStudio SDK；`rws_*` 工具经 HTTP(S) 到控制器 RWS。
- 工具数：63 个，33 个 `rs_*` + 30 个 `rws_*`。能查工作站、读/写 RAPID 模块、读/写变量和 IO、开始/暂停/停止仿真、建目标点和路径、查碰撞、截图、读事件日志、启动/停止程序。
- 明确写着：当前桌面集成针对 Windows 上的 RobotStudio 6.08。
- 需要：Node.js 20 + npm、.NET SDK（能编 net461 插件）、RobotStudio 6.08 已装、一个带虚拟控制器的工作站。
- 安装步骤（按它 README 的原步骤，路径换成你自己的）：
  1. `npm ci`，`npm run build`，`npm test`，入口是 `dist/index.js`。
  2. 编插件：`install-addin.ps1 -RobotStudioDir 'D:\Program Files (x86)\ABB Industrial IT\Robotics IT\RobotStudio 6.08' -NewtonsoftJsonPath <RobotStudio 里 ConveyorTracking 插件下的 Newtonsoft.Json.dll>`，产物在 `artifacts\ClaudeBridge`。
  3. 启动 RobotStudio 时带插件：`RobotStudio.exe /addin:"<artifacts\ClaudeBridge\ClaudeBridge.rsaddin>" "<你的工作站.rsstn>"`。
  4. 检查桥：浏览器/ PowerShell 打开 `http://localhost:58080/ping`，通了才算成。
  5. MCP 客户端配置（Codex / 支持 mcpServers JSON 的客户端）：命令 `node`，参数是 `dist\index.js` 的绝对路径，环境变量 `ABB_BRIDGE_URL=http://localhost:58080`，`ABB_RWS_URL=http://localhost:80`，`ABB_RWS_USER=Default User`，`ABB_RWS_PASS=robotics`。
- 限制：MCP 走 stdio，不是 HTTP 端口；已知在 RobotWare 6.08 控制器上有模块端点不匹配的问题；先在虚拟控制器上试，别上真机。
- 注意：这是给支持 MCP 的 AI 客户端（Claude Code / Codex 这类）用的。Muse 这个聊天目前不能直接接你电脑上的 stdio MCP，所以装好后是你电脑上的 MCP 客户端在操作，不是我这个窗口直接点。

## 路 2：RWS（控制器内置 Web API，最简单，不用编插件）

- 原理：控制器自带 Robot Web Services，HTTP API。IRC5 / RobotWare 6 是 RWS 1.0，HTTP + Digest 认证，端口 80；OmniCore / RobotWare 7/8 是 RWS 2.0，HTTPS，端口 443。
- 虚拟控制器地址就是 `http://localhost:80`，默认账号 `Default User`，默认密码 `robotics`，真机上一定要改掉。
- 能干：读控制器状态、启动/停止程序、读/写 RAPID 变量、读/写 IO、读/写模块和文件、读事件日志、要写权限（mastership）。
- 本库已经在用这条路：`python/01_move_joints.py` 和 `02_pick_place.py` 用的 `abb_motion_program_exec` 就是走 RWS 发运动指令。
- 测试方法：不用写代码，先用 Postman / curl 按 ABB 社区教程发一个 GET 到 `http://localhost/rw/motionsystem`，通了再写程序。

## 路 3：ABB PC SDK（C#，官方，适合自己写程序）

- 原理：ABB 官方 .NET 库，C# 程序连真实或虚拟控制器，能上传程序、读程序指针、读写 RAPID、发消息队列（RAPID Message Queue）。
- 需要：Windows + Visual Studio + .NET，引用 `ABB.Robotics.Controllers.PC.dll`，控制器要开 PC Interface 选项。
- 适合：你想自己写一个 Windows 上位机软件，长期用。入门不推荐，先走路 2。

## 3 条路怎么选
- 只想学 RAPID 和仿真：不用连接器，按 `robotstudio/tutorial.md` 手动操作就行。
- 想用 Python 发指令：走路 2，RWS + `abb_motion_program_exec`，本库已有例子。
- 想让 AI 直接操作你电脑上的 RobotStudio 6.08：走路 1，装 MCP + 插件，但要你自己在电脑上跑命令，我远程帮不了你点；而且要在虚拟控制器上先验证。
- 想自己开发上位机：走路 3，PC SDK。

## 安全提醒
- 先在虚拟控制器上试通，再碰真机。
- 真机默认密码 `robotics` 必须改，RWS 写操作要先拿写权限。
- 仿真里跑通、查过碰撞，再上真机低速验证。
