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
