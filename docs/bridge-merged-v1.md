# abb-robotstudio-bridge-merged-v1 复核记录（2026-11-20）

来源：用户发的 `abb-robotstudio-bridge-merged-v1.zip`，375KB，50 个文件，目录 `robotstudio-bridge/`。

## 是什么

上游 `abb-robotstudio-mcp6.08` v3.1.0 的整合版：上游全部代码 + 本地已验证的修复与新功能 + 全局技能 `robotstudio-ops`。

不用 MCP 客户端也能用：技能走 HTTP 桥 `http://127.0.0.1:58080` 直接操作 RobotStudio 6.08。

## 核对结果

- 工具总数 67 个：`rs_*` 37 个 + `rws_*` 30 个（原来 63 个，33 + 30）。`dist/index.js` 启动横幅与 `src/index.ts` 里 `server.tool` 出现 67 次对得上。
- 新增 4 个 MCP 工具：`rs_new_station`、 `rs_create_station`、 `rs_save_station_as`、 `rs_add_library_component`。
- Add-In 新增端点：`/station/new`、`/station/create`、`/station/save-as`、`/station/add-component`，另有 `/exec`（在 RobotStudio 进程内执行 C#，用来建站、连信号等没有独立端点的工作）。
- #5 已修：`rws_get_modules` 改走 `/rw/rapid/modules?task=...`，在 `src/index.ts` 525 行。
- #6 已修：`validateControllerPath` 正则 `/^\$(?:HOME|SYSTEM|TEMP)(?:\/[a-zA-Z0-9_\-\.]+)*$/i`，裸 `$HOME` 能过，`..` 仍拦截，在 565 行。
- 技能 `skill/robotstudio-ops/`：SKILL.md + references/recipes.md + 4 个 PowerShell 脚本（bridge-call、exec-cs、fix-window、start-robotstudio）。start 脚本用 WMI `Win32_Process.Create` 分离启动 RobotStudio，普通 Start-Process 会被调用方回收。

## 安装步骤（Windows 电脑上，交给 Trae 做）

1. 解压到 `D:\mcp_server\mcp-robotstudio\robotstudio-bridge`（或任意英文路径）。
2. 编插件：`powershell -ExecutionPolicy Bypass -File .\install-addin.ps1 -Destination "$env:USERPROFILE\RobotStudioBridge"`，要 .NET SDK 8+。产物 3 个文件：ClaudeBridge.dll、Newtonsoft.Json.dll、ClaudeBridge.rsaddin。
3. 编 MCP：`npm ci`、`npm run build`，验证 `dist\index.js` 存在。
4. 装技能（可不走 MCP）：把 `skill\robotstudio-ops` 复制到 `%USERPROFILE%\.trae-cn\skills\robotstudio-ops`。
5. 启动验证：`.\skill\robotstudio-ops\scripts\start-robotstudio.ps1`，再 `.\skill\robotstudio-ops\scripts\bridge-call.ps1 -Path /ping`，返回 `status=ok`、`stationOpen`、`stationName` 才算通。
6. 要走 MCP 才配客户端：command 是 node，args 是 `dist\index.js` 绝对路径，env 是 ABB_BRIDGE_URL=http://127.0.0.1:58080、ABB_RWS_URL=http://127.0.0.1:80、ABB_RWS_USER=Default User、ABB_RWS_PASS=robotics。RWS 端口每次启动都可能变，先查 RobVC 监听端口。

## 已知限制（不要反复重试）

- 新建虚拟控制器会失败：SystemBuilder 报 ProductInstallationFailedException，句柄未初始化，本机 RIM 层故障。需要控制器时克隆已有系统或在界面手工创建。
- `rs_read_module` 常失败：控制器未装载 RAPID 程序时报 C0049004，无只读绕过，先装程序再试。
- `Station.Load` 会在 UI 线程死锁：加载工作站改用重启 RobotStudio + 带站路径的方式。
- 窗口可能被压成 157×25：用 `scripts/fix-window.ps1` 恢复。
- `localhost` 会走 IPv6 超时：一律用 `127.0.0.1`。
- 只在虚拟控制器上操作，不连真机。

## 同步 GitHub

关键源文件传到 fork `linxie654-netizen/abb-robotstudio-mcp6.08`，不传构建产物 `dist/`、`artifacts/`（里面有已编好的 DLL）。

未验证项：新 4 个工具未在真控制器上跑过；install 步骤未在实机上重跑过。
