# 路 1 安装：MCP 服务器 + ClaudeBridge（RobotStudio 6.08）

项目：ABB RobotStudio MCP Server，PMinhDuc204/abb-robotstudio-mcp6.08，v3.1.0，63 个工具。
来源页：http://glama.ai/mcp/servers/PMinhDuc204/abb-robotstudio-mcp6.08
GitHub 仓库：https://github.com/PMinhDuc204/abb-robotstudio-mcp6.08

```powershell
git clone https://github.com/PMinhDuc204/abb-robotstudio-mcp6.08.git
```

注意：clone 下来的目录名是 `abb-robotstudio-mcp6.08`，安装指南里的示例路径 `D:\mcp_server\mcp-robotstudio\abb-robotstudio-mcp` 是作者自己的目录，按实际路径改。
先在虚拟控制器上装、试，别上真机。

## 第 0 步：先检查，不通过别往下装

在你电脑上打开 PowerShell，一个个跑，截图或把结果发我：

```powershell
node --version
npm --version
dotnet --list-sdks
Test-Path 'D:\Program Files (x86)\ABB Industrial IT\Robotics IT\RobotStudio 6.08'
```

- `node` 要能跑，项目 CI 用 Node.js 20。
- `dotnet` 要有能编 net461 插件的 .NET SDK。
- RobotStudio 路径不一定是 D 盘，按你实际安装盘改，后面命令里的 `$rsDir` 都要改成你的路径。

## 第 1 步：编 MCP 服务器

```powershell
Set-Location 'D:\mcp_server\mcp-robotstudio\abb-robotstudio-mcp'
npm ci
npm run build
npm test
```

入口是 `dist\index.js`。`npm test` 之前必须先 `npm run build`，测试用的是编译后的文件。

## 第 2 步：编插件并放好

```powershell
$rsDir = 'D:\Program Files (x86)\ABB Industrial IT\Robotics IT\RobotStudio 6.08'
$jsonDll = Join-Path $rsDir 'Bin\Addins\ConveyorTrackingModuleAddin\Newtonsoft.Json.dll'
powershell -NoProfile -ExecutionPolicy Bypass -File .\install-addin.ps1 `
  -RobotStudioDir $rsDir `
  -NewtonsoftJsonPath $jsonDll
```

成功后产物在 `artifacts\ClaudeBridge`：
- `ClaudeBridge.dll`
- `ClaudeBridge.rsaddin`
- `Newtonsoft.Json.dll`

如果默认的 Newtonsoft 路径没有，找一个兼容的 DLL，用 `-NewtonsoftJsonPath` 指过去。

## 第 3 步：带插件启动 RobotStudio 6.08

先关掉 RobotStudio，保存好工作站，再跑：

```powershell
$bridgeManifest = Join-Path $PWD 'artifacts\ClaudeBridge\ClaudeBridge.rsaddin'
$stationPath = 'D:\RobotStudioProjects\Example\Example.rsstn'
$robotStudioExe = Join-Path $rsDir 'Bin64\RobotStudio.exe'
Start-Process -FilePath $robotStudioExe -ArgumentList @(
  "/addin:`"$bridgeManifest`"",
  "`"$stationPath`""
)
```

`$stationPath` 换成你自己的 `.rsstn` 文件。以后每次用桥都要这样带 `/addin:` 启动，6.08 界面里没有好用的“加载插件”按钮。

注意：脚本/自动化启动时，必须让 RobotStudio 脱离调用方进程树（实测用 WMI `Win32_Process.Create`）。直接 `Start-Process` 时，进程会在命令结束几十秒后被回收。手动双击不受此影响。

## 第 4 步：检查桥通没通

```powershell
Invoke-RestMethod 'http://localhost:58080/ping'
```

通了，再看 RobotStudio 的 Output 窗口有没有桥启动的消息。桥绑在 127.0.0.1:58080，只在本机，不用开防火墙端口。

## 第 5 步：配 MCP 客户端

MCP 走 stdio，不是 HTTP。配 Codex，在 `%USERPROFILE%\.codex\config.toml` 里加：

```toml
[mcp_servers.abb_robotstudio]
command = "node"
args = ['D:\mcp_server\mcp-robotstudio\abb-robotstudio-mcp\dist\index.js']

[mcp_servers.abb_robotstudio.env]
ABB_BRIDGE_URL = "http://localhost:58080"
ABB_RWS_URL = "http://localhost:80"
ABB_RWS_USER = "Default User"
ABB_RWS_PASS = "robotics"
```

用 JSON 配置的客户端同理，`command` 是 `node`，`args` 是上面那个绝对路径，`env` 里是上面 4 个值。
密码是虚拟控制器的默认密码，真机一定要改，不要把真密码写进公开文件。

实测修正（2026-11-20，另一 AI 在用户 Windows 机上装完）：
- `command` 不要只写 `node`：系统 Node 是 24，项目要 20，必须写便携版 Node 20 的绝对路径（本次 `D:\mcp_server\tools\node-v20.20.2-win-x64\node.exe`）。
- `ABB_BRIDGE_URL` 写 `http://127.0.0.1:58080`，不要写 `localhost`：`localhost` 先解析 IPv6 `::1`，实测一直超时。
- `ABB_RWS_URL` 写 `http://127.0.0.1:19404` 这种实际端口，不要写 `localhost:80`：80 端口被 IIS 占用；虚拟控制器的 RWS 端口每次启动都会变，每次启动后要跑 `refresh-rws-url.ps1` 刷新配置里的端口。

## 第 6 步：第一次连接，先只查不改

按顺序调：
1. `rs_ping`：桥通没通
2. `rs_get_station`：工作站和控制器对不对
3. `rs_get_tasks`：看任务名，一般是 `T_ROB1`
4. `rs_get_modules`：`{"task":"T_ROB1"}`
5. `rs_read_module`：读一个已有模块
6. `rws_controller_status`：确认 RWS 指的是你要的那个控制器

只查不改，确认对了再写 RAPID、再跑仿真。

## 检查结果诊断（2026-11-20 实测一例）
- Node.js v24.16.0，不是项目 CI 用的 20：先试，`npm ci` 能过就不用降；报错再装 Node.js 20（nvm-windows：`nvm install 20`，`nvm use 20`）。
- npm 11.13.0：正常。
- .NET SDK 未安装，只有 8.0.22 运行时：运行时不等于 SDK，不能编插件。必须装 .NET 8 SDK（x64），装完重开 PowerShell，`dotnet --list-sdks` 要能看到 8.x。
- net461 引用程序集：装 SDK 后，首次还原可能从 NuGet 拉 .NET Framework 引用程序集；如果报 MSB3644（找不到框架引用程序集），再装 .NET Framework 4.6.1 Developer Pack。
- RobotStudio 6.08 路径、Newtonsoft.Json.dll、git/网络都找到，RobotStudio 未运行：都正常，装插件前本来就要关掉 RobotStudio。

## 常见卡点
- `node` 找不到：Node.js 没装或没加 PATH，先装 Node.js 20。
- 编插件失败：.NET SDK 不对，或 Newtonsoft.Json.dll 路径不对。
- `ping` 不通：RobotStudio 没带 `/addin:` 启动，或插件没加载，看 Output 窗口。
- RWS 连不上：虚拟控制器没启动，或地址不是 `http://localhost:80`，或账号密码不对。
- 已知问题：项目 README 说在 RobotWare 6.08 控制器上有模块端点不匹配的问题，先在虚拟控制器上验证，别直接上真机。
- RWS 端口每次启动 VC 都会变：不要写死端口，每次启动后跑 `refresh-rws-url.ps1` 刷新 MCP 配置里的 `ABB_RWS_URL`。
- 释放 mastership 后约 3 秒内 `rws_controller_status` 会短暂返回 503：控制器在所有权切换时短暂重置会话，属控制器侧行为，等 3 秒再查。
- `rs_read_module` 读不到模块：先确认控制器上已装载 RAPID 程序。没装程序时读模块必败（见下节），不是安装问题。
- 强杀 RobotStudio 会遗留孤儿 `RobVC.exe` 锁定工作站，下次启动卡在初始化；如需强杀，同时结束 `RobVC.exe`。

## 实际安装结果（2026-11-20，另一 AI 在用户 Windows 机上装完）

项目 `PMinhDuc204/abb-robotstudio-mcp6.08`，v3.1.0，仓库提交 `a782f78`（2026-10-26）。工作站 `D:\Desktop_Projects\ABB PROJECT\ABB1115\ABB1115.rsstn`，虚拟控制器 `ABB1`，SystemId `{99BB5E50-2253-4220-AA6A-340EA40A3299}`。

- 环境：Node.js v20.20.2（便携，`D:\mcp_server\tools\node-v20.20.2-win-x64`）、.NET SDK 8.0.428（便携，`D:\mcp_server\tools\dotnet`），系统原有 Node 24.16.0 和 .NET 8 运行时未改动。
- 构建：`npm ci`（96 个依赖）→ `npm run build`（tsc 通过）→ `npm test`（5/5 通过）；`install-addin.ps1` 生成 `ClaudeBridge.dll`、`ClaudeBridge.rsaddin`、`Newtonsoft.Json.dll` 三件产物。
- 桥接：RobotStudio 带 `/addin:` 加载成功，`ping` 返回 `{"status":"ok","stationOpen":true,"stationName":"ABB1115"}`，桥绑 `127.0.0.1:58080`。
- MCP 配置：已写入 Trae CN 的 `mcp.json`，JSON 校验通过；`tools/list` 返回 63 个工具，`initialize` 返回 `abb-robotstudio 3.0.0`。
- 只读验证 6 项通过 5 项：`rs_ping`、`rs_get_station`（ABB1115 / ABB1 / Started）、`rs_get_tasks`（T_ROB1，Motion）、`rs_get_modules`（user、BASE、Module1、CalibData）、`rws_controller_status`（motoron / AUTO / stopped / once）都通。
- 未通过：`rs_read_module`。根因（SDK 直连诊断，非推测）：控制器上没有装载 RAPID 程序。`Task.SaveProgramToFile` 报 `C0049004`（程序名未设置）；`Module.SaveToFile` 报 `C004A000`（文件处理错误）；RWS `/rw/rapid/tasks/T_ROB1/modules/Module1/text` 返回 404（该 VC 未实现文本端点），`/rw/rapid/modules/Module1?task=T_ROB1` 返回 200 但只有元数据、无正文。结论：读模块源码要求控制器上装载程序，这属于控制器状态变更（写操作），按“只查不改”约束当时未执行。下一步：在 RobotStudio 里给 `ABB1` 装载程序（不产生运动），建议直接装本库的 `01_move_basics.mod` 再重试 `rs_read_module`。
- 代码改动（仅本项目，非 RobotStudio）：3 个文件，+122 / -42。修了 4 个问题：读模块不申请 mastership（`TargetInvocationException`）、文件列表通配符 `$HOME/*` 必抛异常、RWS 兜底写死 `localhost:80` + Basic 认证、mastership POST 缺 body/Content-Type 报 415。改动有原始副本对照（`abb-robotstudio-mcp-original`，commit `a782f78`）和补丁文件（261 行，`git apply --check` 通过），可回滚。
- 未修 bug（报告第 7 节）：#5 高——`rws_get_modules` 用的 `/rw/rapid/tasks/T_ROB1/modules` 在该 VC 返回 404，可用端点是 `/rw/rapid/modules?task=T_ROB1`；#6 中——`rws_list_files` 传 `"$HOME"` 被 `validateControllerPath` 判非法，列不了目录；#7 低——版本号三处不一致（3.1.0 / 2.0.0 / 3.0.0，上游 README 自己承认未同步）；#8 低——`npm audit` 3 个漏洞（2 中 1 高）；#9 低——`typescript`、`@types/node` 放在 `dependencies`。
- 安全：全程只操作虚拟控制器 `ABB1`，未连接、未启动任何真实机器人运动；未修改 RobotStudio 安装目录；仅在本机配置里用虚拟控制器默认凭据 `Default User / robotics`。
- 附注：本机 `TIA Administrator V3` 服务处于崩溃重启循环（系统日志 77+ 次，约 65 秒一次），与本次安装无关，但会干扰日志排查，建议单独处理。
