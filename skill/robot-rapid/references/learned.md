# 学到的东西（边问边学，持续加）

每条都是用户问过、纠正过、或实测过的东西。下次遇到同样的问题，直接按这里答，不用再查。

格式：问题 → 答案 → 为什么 / 来源。用户纠正过的标，以后永远照办。

## 技能本身

- **只有一个 ABB 技能** → 叫 `robot-rapid`，其他的 ABB 技能全部删掉。
- **0 到 1 全流程做成 Skill 版步骤** → 人照着在 RobotStudio 里点，步骤在 `docs/full-pipeline.md`。
- **用户纠正一次就永远照办** → 拍板的决定不反复重提、不劝再考虑。

## RobotStudio 与虚拟控制器

- **虚拟控制器要先建系统** → 建系统是 Installation Manager / System Builder 的活，建好后回 RobotStudio 加载；已有系统直接启动就行。（2026-11-20 核实）
- **新建虚拟控制器会失败** → SystemBuilder 报 ProductInstallationFailedException，本机 RIM 层故障，不要反复重试，克隆已有系统或界面手工建。
- **点动是示教器的活** → 仿真里改关节角可以代替点动。

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

## IRC5 与 OmniCore 对照（2026-11-21 从 ABB RAPID Pack 公开文档学）

| | IRC5 | OmniCore |
|---|---|---|
| RobotWare | 6 | 7 或 8 |
| RWS | 1.0 | 2.0 |
| 认证 | HTTP Digest + 会话 cookie | HTTP Basic + 会话 cookie |
| 推荐传输 | HTTP | HTTPS |
| 连电脑要的授权选项 | 616-1 PC Interface | 3119-1 RobotStudio Connect |

- 先看控制器铭牌是 IRC5 还是 OmniCore，再决定走 RWS 1.0 还是 2.0，两套端点和解析器不能混用。
- 没 616-1 / 3119-1 选项，电脑连不上控制器，先查选项再查网络。
- 手动模式改东西被拒，先查 RMMP（远程手动模式权限）；RobotWare 8 报 Guard Stop，先去示教器按 Reset。

## UAS 授权：哪个操作要哪个授权（2026-11-21 从 ABB RAPID Pack 公开文档学）

| 想干什么 | 要什么授权 |
|---|---|
| 读控制器、RAPID、I/O 状态 | 有读权限的 UAS 账号 |
| 写 RAPID 变量当前值 | `UAS_RAPID_CURRVALUE`，还要 mastership 和控制器状态允许 |
| 启动/停止/复位 RAPID | `UAS_RAPID_EXECUTE`，还要运行状态允许 |
| 加载/卸载/部署模块 | `UAS_RAPID_EDIT`、`UAS_RAPID_LOADPROGRAM`，还要 mastership 和文件服务权限 |
| 读/写控制器文件 | `UAS_FTP_READ` / `UAS_FTP_WRITE` |
| 写 I/O 信号 | `UAS_IO_WRITE`，还要信号的自动/手动访问级别允许 |
| 新建 I/O 信号 | `UAS_CFG_WRITE`，还要配置 mastership |
| 热启动 | 重启授权 |
| 设控制器断点 | `UAS_RAPID_DEBUG`，还要 mastership |

- 写操作被拒先查四道门：工作区受信任、配置是 Read & Write、写/执行总开关开了、当前连接的写权限已激活；再查 UAS 授权、运行模式、mastership。
