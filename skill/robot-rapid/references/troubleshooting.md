# 报错排查手册 — Robot-RAPID

先走四步，再动手改：**1 复现**（在哪一步、什么操作、原样报错贴出来）→ **2 定位**（先查下面这张表，报错先对号，不猜）→ **3 修**（一次只改一处，改完再跑）→ **4 验证**（仿真里跑通、查完碰撞，才算修好）。没跑通就别说修好了。

## 报错对号表（已核实的才写进来）

| 现象 / 报错 | 先查什么 | 怎么办 |
|---|---|---|
| 目标点不可达 / 机器人够不着 | 手腕姿态（config）和工件坐标系（wobjdata） | 先查这两处，别乱改点位；换个姿态或重设工件坐标系再试 |
| `rs_read_module` 报 C0049004 | 控制器里有没有装 RAPID 程序 | 控制器没装程序，先装 `rapid/01_move_basics.mod` 再读 |
| RWS 文本端点 404 | 是不是走了 RWS 文本端点 | 6.08 的模块端点不匹配是已知问题，改走 `/rw/rapid/modules?task=T_ROB1` |
| 新建虚拟控制器失败 | 本机 RIM 层故障 | 不要反复重试；克隆已有系统，或在界面里手工建 |
| `Station.Load` 卡死 | 是不是在 UI 线程调 Load | 别调它；关掉重开 RobotStudio 时带工作站路径加载，改前先保存 |
| RobotStudio 窗口缩成一条（约 157×25） | 窗口被挤了 | 跑 `scripts/fix-window.ps1` |
| 桥连不上 / 超时 | 地址是不是写了 `localhost` | 改用 `127.0.0.1`，localhost 会走 IPv6 超时；再跑 `scripts/bridge-call.ps1 -Path /ping`，要返回 `stationOpen` 和 `stationName` |
| 脚本启动 RobotStudio，几十秒后被回收 | 是不是直接 `Start-Process` 启动的 | 改用 `scripts/start-robotstudio.ps1`，它走 WMI 脱离进程树；手动双击不受影响 |
| 工作站被锁、打不开 | `RobVC.exe` 还在跑 | 关 RobotStudio 时连 `RobVC.exe` 一起杀掉 |
| POST 桥接口报 500 | JSON 是不是直接写在命令行里 | PowerShell 会吃掉引号；改用 `scripts/bridge-call.ps1 -Path <path> -Method POST -BodyFile <json文件>` |
| Windows 机 TIA Administrator V3 反复崩溃 | 和机器人无关 | 和 MCP、桥都无关，别往机器人身上查，单独处理 |
| 程序在仿真里跑得好好的，真机不动 | 有没有先在手动低速下验证 | 没仿真过的程序不上真机；真机先手动低速，再切自动 |

## 排查时要问用户的三句话

1. 报错原话贴出来（截图或复制，别只说“报错了”）。
2. 卡在哪一步：建站、加机器人、教点、仿真、还是下程序？
3. 上一次能跑的时候，改过什么？一次只改一处。

## 没核实的别写进来

新报错先记到 `learning-log.md`，核实了再进这张表。不要把网上没验证过的偏方写成定论。
