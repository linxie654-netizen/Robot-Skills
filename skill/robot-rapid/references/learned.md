# 学到的东西（边问边学，持续加）

每条都是用户问过、纠正过、或实测过的东西。下次遇到同样的问题，直接按这里答，不用再查。

格式：问题 → 答案 → 为什么 / 来源。用户纠正过的标，以后永远照办。

## 技能本身

- **只有一个 ABB 技能** → 叫 `robot-rapid`，其他的 ABB 技能全部删掉。
- **0 到 1 全流程做成 Skill 版步骤** → 人照着在 RobotStudio 里点，步骤在 `docs/full-pipeline.md`。
- **用户纠正一次就永远照办** → 拍板的决定不反复重提、不劝再考虑。

## RobotStudio 与虚拟控制器

- **虚拟控制器要先建系统** → 建系统是 Installation Manager / System Builder 的活，建好后回 RobotStudio 加载；已有系统直接启动就行。
- **新建虚拟控制器会失败** → SystemBuilder 报 ProductInstallationFailedException，本机 RIM 层故障，不要反复重试，克隆已有系统或界面手工建。
- **点动是示教器的活** → 仿真里改关节角可以代替点动。

## RAPID 学习

- **例程点位是教学值** → 在仿真里重新示教。
- **没定型号先用 IRB 120 练** → 跑通了再换型号。
- **目标点报不可达** → 先查手腕姿态和工件坐标系，别乱改坐标。
- **RAPID 最像 Pascal** → 结构化、强类型，MODULE/PROC、VAR 声明类型、IF…ENDIF、WHILE…ENDWHILE、分号结尾；跟 Python 逻辑相通，差别在缩进 vs 关键字收尾、动态类型 vs 必须声明类型。

- **技能改名要短、要说得出干什么**（2026-11-20，用户说 abbrobotstudio 不好听） → 改成 `robot-rapid`。热门技能（find-skills、grill-me、tdd）都是 1–2 个词，名字本身就是功能；三个词拼软件名既长又没说清用途。改名时本地 custom-skills、公开库 skill 目录、SKILL.md、skill.yaml、INSTALL.md、README、comparison.md 要一起改，只改一处会留尾巴。

- **用户定名按原话，文件夹小写是规范**（2026-11-20，用户纠正 rapid-mentor → Robot-RAPID） → 显示名、标题、徽章都用用户原话 Robot-RAPID，文件夹和 skill name 用小写 `robot-rapid`。改名中途已有同步在跑时不要掐断，等它跑完再同步一次新名字，否则仓库留半截。

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

## 配 IO 信号（2026-11-21 从 R1 段 9 草稿学）

- 问题：信号怎么配、程序里怎么用？
- 答案：信号分四种：DI（传感器、按钮发来的 0/1）、DO（机器人发出去的 0/1）、AI/AO（连续量）；组信号 GI/GO 是几个数字信号拼成一个数，PLC 发程序号就用组信号。配在控制器 Configuration Editor 的 I/O System 里：新建信号，定名字、类型、接哪个设备；程序里用的名字必须和配置里一模一样，差一个字母就报错。程序里：SetDO 发 1/0（Reset 是置 0），WaitDI 等输入变 1，WaitUntil 等条件成立；等信号要加超时，一直等不到就报错。没设备时在示教器 Inputs and Outputs 里把信号设成模拟，手动拨 0/1 调程序；记得取消模拟。新建信号要 UAS_CFG_WRITE 授权和配置 mastership。
- 为什么：信号名是控制器配出来的，不是程序里随便起的；名字对不上编译就报错。
- 信号配好还得接东西：仿真里信号要起作用，得配 Smart 组件——组件里加对应的输入/输出信号，把控制器信号和组件信号连起来；RAPID 发 SetDO，组件收到就动；组件的输出回给 RAPID，用 WaitDI 等。夹爪的例子：控制器配 doGrip，组件里配 diClose，doGrip 连到 diClose 上，不然 SetDO 发出去没东西响应。真空夹爪是 DI_Attach 控制吸放，传感器碰到箱子吸住，DI 撤掉（过 NOT 门）放开。只写程序不跑仿真可以不配组件；要仿真跑通就得配。

## 进阶三课：EGM、多任务、外轴（2026-11-22 用户点直接学难的，写进 docs/advanced-topics.md）

- 问题：EGM 是什么、怎么用？
- 答案：EGM 是电脑每 4 毫秒发一次位置、机器人跟着走的实时控制，分位置引导（电脑定路）和路径修正（程序定路、电脑只发偏移量）两种；要开 689-1 选项、配 UC 通讯、电脑同时跑发数据的程序。RAPID 骨架四步：EGMGetId 领身份证 → EGMSetupUC 配通讯 → EGMActJoint 准备会话 → EGMRunJoint 开始跑；电脑断了报 ERR_UDPUC_COMM。三种模式：关节目标（发 6 个关节角，最简单）、姿态目标（发位置+四元数，要躲奇异点）、路径修正（发路径坐标偏移，48 毫秒才更新一次）。
- 为什么：EGM 绕过路径规划和很多安全功能（包括防碰撞），先在仿真里测；光写 RAPID 不够，电脑不发数据程序就卡在等 UDP 包。

- 问题：多任务是什么、任务之间怎么同步、怎么共享数据？
- 答案：一个控制器同时跑几个 RAPID 任务，各干各的活。开 623-1 选项；任务分三种类型：NORMAL（机器人运动任务，只能是这个，急停会停）、STATIC（后台跑，急停也不停）、SEMISTATIC（后台跑，开机自动从头跑）；调试先全用 NORMAL，调好再改回去、重启控制器。同步用 WaitSyncTask（各任务跑到碰头点一起等，人齐再走）；共享数据用 PERS 变量放公共模块（所有任务都加载）或用信号。两台机器人配合用 MultiMove：604-2 独立（各干各的、只在碰头点等）、604-1 协调（全程同步，包含独立的全部功能）；协调动作包在 SyncMoveOn / SyncMoveOff 里，每句 Move 带 \ID，两台机器人 \ID 一一对应。
- 为什么：一个控制器最多带 4 台机器人、最多 7 个运动任务（产品规格原话）；后台任务急停不停，写的时候要想清楚急停后它该干什么。

- 问题：外轴是什么、怎么编？
- 答案：外轴是机器人本体六个轴之外的轴，常见变位机（翻工件）和导轨（带机器人走）。动外轴前先 ActUnit 激活机械单元（名字按自己系统的改）；只动外轴用 MoveExtJ；robtarget / jointtarget 里的 extax 是外轴位置，写 9E9 表示“这根轴别管”。变位机翻 90 度再焊的骨架：ActUnit → 焊第一面 → MoveExtJ 转 90 度 → 焊第二面。协调运动两种做法：工件坐标系挂变位机上，或机器人和变位机各一个任务、用 SyncMoveOn 包起来。
- 为什么：外轴不标定，转的角度和程序里的角度对不上；点位教的时候外轴在 0 度、跑的时候在 90 度，点位全错；外轴动起来力气大，翻工件时人在单元外。
