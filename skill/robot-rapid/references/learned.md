# 学到的东西（边问边学，持续加）

每条都是用户问过、纠正过、或实测过的东西。下次遇到同样的问题，直接按这里答，不用再查。

格式：问题 → 答案 → 为什么 / 来源。用户纠正过的标，以后永远照办。

## 技能本身

- **只有一个 ABB 技能** → 叫 `robot-rapid`，其他的 ABB 技能全部删掉。
- **MCP 工具开发停掉，改做 Skill** → 0 到 1 全流程做成 Skill 版步骤，人照着在 RobotStudio 里点，不编 C# 插件。
- **用户纠正一次就永远照办** → 拍板的决定不反复重提、不劝再考虑。

## RobotStudio 与虚拟控制器

- **虚拟控制器不能用代码从 0 建** → 建系统是 Installation Manager / System Builder 的活，建好后回 RobotStudio 加载；已有系统直接启动就行。（2026-11-20 核实）
- **新建虚拟控制器会失败** → SystemBuilder 报 ProductInstallationFailedException，本机 RIM 层故障，不要反复重试，克隆已有系统或界面手工建。
- **点动命令 SDK 里没有** → 手动点动是示教器的活；仿真里改关节角（SetJointValues）可以代替点动。
- **Station.Load 会在 UI 线程死锁** → 加载工作站改用重启 RobotStudio + 带站路径的方式。
- **普通 Start-Process 启动的 RobotStudio 会被调用方回收** → 用 WMI Win32_Process.Create 分离启动。
- **窗口可能被压成 157×25** → 用 `scripts/fix-window.ps1` 恢复。
- **`localhost` 会走 IPv6 超时** → 桥地址一律用 `127.0.0.1:58080`。

## MCP 与桥

- **Muse 云端接不进用户电脑本地的 MCP** → MCP 是本地 stdio 服务，操作 RobotStudio 走用户电脑上的 Trae CN，Muse 只帮 RAPID 文件、截图改错。
- **rws_get_modules 在 6.08 虚拟控制器上 404** → 可用端点是 `/rw/rapid/modules?task=T_ROB1`，读模块走桥的 `rs_get_modules` / `rs_read_module`。
- **rws_list_files 传 `$HOME` 会被判非法** → 正则要放行裸 `$HOME`，只拦 `..`。
- **rs_read_module 报 C0049004** → 控制器上没装 RAPID 程序，不是安装问题，先装程序（比如库里的 01_move_basics.mod）再试。
- **RWS 端口每次启动都变** → 不要写死，先查 RobVC 的监听端口。

## RAPID 学习

- **例程点位是教学值** → 上真机前必须在仿真里重示教。
- **没定型号先用 IRB 120 练** → 跑通了再换型号。
- **目标点报不可达** → 先查手腕姿态和工件坐标系，别乱改坐标。
- **RAPID 最像 Pascal** → 结构化、强类型，MODULE/PROC、VAR 声明类型、IF…ENDIF、WHILE…ENDWHILE、分号结尾；跟 Python 逻辑相通，差别在缩进 vs 关键字收尾、动态类型 vs 必须声明类型。

- **技能改名要短、要说得出干什么**（2026-11-20，用户说 abbrobotstudio 不好听） → 改成 `robot-rapid`。热门技能（find-skills、grill-me、tdd）都是 1–2 个词，名字本身就是功能；三个词拼软件名既长又没说清用途。改名时本地 custom-skills、公开库 skill 目录、SKILL.md、skill.yaml、INSTALL.md、README、comparison.md 要一起改，只改一处会留尾巴。

- **用户定名按原话，文件夹小写是规范**（2026-11-20，用户纠正 rapid-mentor → Robot-RAPID） → 显示名、标题、徽章都用用户原话 Robot-RAPID，文件夹和 skill name 用小写 `robot-rapid`。改名中途已有同步在跑时不要掐断，等它跑完再同步一次新名字，否则仓库留半截。

## 码垛：只教 2 个点，12 个箱子全靠 Offs 算
- 问题：用户要做叠码垛仿真，托盘 2 列×2 行×3 层，怎么写程序？
- 答案：`rapid/11_palletizing.mod`——规格（列/行/层、箱子尺寸、间隙）全放开头 CONST 里改；`main` 用 WHILE TRUE + 三层 FOR 循环码一托，满托报数、等 `diNewPallet` 换托盘再码；`PickBox` 等 `diBoxReady` 再取；`PlaceBox` 用 `Offs()` 在 `Move` 指令里当场算位置，偶数层换转 90 度的基准点交错码放。
- 为什么：12 个箱子的位置全是基准点加偏移算出来的，只教 2 个基准点，托盘挪地方只改 `wobjPallet` 一个坐标系。注意：`Offs()` 必须写在 `Move` 指令里，别先算出来存变量再用，不然偏移的坐标系会错。
