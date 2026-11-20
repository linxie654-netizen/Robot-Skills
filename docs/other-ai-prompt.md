# 给另一个 AI 的安装指令（可直接复制）

下面这段直接发给在你电脑上装东西的那个 AI。括号里的路径按你的实际情况改。

---

请帮我在 Windows 电脑上安装 ABB RobotStudio MCP 服务器，让 AI 能操作 RobotStudio 6.08。

项目：ABB RobotStudio MCP Server，PMinhDuc204/abb-robotstudio-mcp6.08，v3.1.0，63 个工具。
来源页：http://glama.ai/mcp/servers/PMinhDuc204/abb-robotstudio-mcp6.08
我的 RobotStudio 是 6.08，装在（填你的路径，例如 D:\Program Files (x86)\ABB Industrial IT\Robotics IT\RobotStudio 6.08）。
我的工作站文件在（填你的 .rsstn 路径）。
安装目录用 D:\mcp_server\mcp-robotstudio\abb-robotstudio-mcp。

先检查，再安装，不跳步：
1. 检查 node --version、npm --version、dotnet --list-sdks、RobotStudio 6.08 路径是否存在。缺哪个先装哪个，Node.js 用 20。
2. 下载项目，跑 npm ci、npm run build、npm test，入口是 dist\index.js。
3. 编 ClaudeBridge 插件：用 install-addin.ps1，-RobotStudioDir 指到我的 RobotStudio 6.08 目录，-NewtonsoftJsonPath 指到 RobotStudio 里 ConveyorTracking 插件下的 Newtonsoft.Json.dll。产物要在 artifacts\ClaudeBridge，有 ClaudeBridge.dll、ClaudeBridge.rsaddin、Newtonsoft.Json.dll。
4. 关掉 RobotStudio，用 RobotStudio.exe /addin:"artifacts\ClaudeBridge\ClaudeBridge.rsaddin" "我的工作站.rsstn" 重新启动。
5. 检查桥：Invoke-RestMethod 'http://localhost:58080/ping'，要通；再看 RobotStudio Output 窗口有没有桥启动消息。
6. 配 MCP 客户端：command 是 node，args 是 dist\index.js 的绝对路径，env 是 ABB_BRIDGE_URL=http://localhost:58080，ABB_RWS_URL=http://localhost:80，ABB_RWS_USER=Default User，ABB_RWS_PASS=robotics。
7. 第一次连接只查不改：依次调 rs_ping、rs_get_station、rs_get_tasks、rs_get_modules（task 是 T_ROB1）、rs_read_module、rws_controller_status，确认工作站和控制器都对。

安全要求：
- 只在虚拟控制器上试，不碰真机，不启动真机运动。
- 不要改 RobotStudio 的安装文件，不要把真机密码写进任何公开文件。
- 每一步做完告诉我结果，失败了把报错原文完整发我，不要自己猜着跳过。
