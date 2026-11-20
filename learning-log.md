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
- 执行：已上网查完新手必学内容，写进库里。新增 `docs/beginner-roadmap.md`（12 课路线 + 6 个常犯错），新增 RAPID 例程 07 圆弧、08 TEST/CASE+函数、09 报错处理、10 模拟量 IO+WaitUntil；对比表补了 5 家新手教程来源。GitHub 上传仍在准备，vendor 不直接上传，改放链接清单，待用户确认仓库名后建仓库上传。

## 待用户确认的学习方向
- 机器人型号：未定（IRB 120 / 140 / 6700 / YuMi？）
- RobotStudio 是否已安装：未确认
- 当前水平：Python 初学；ABB 基础操作、J1-J6、空间坐标系正在学
- 下一步建议：先跑通 RobotStudio 虚拟控制器 + `abb_motion_program_exec` 的 MoveJ/MoveL 例子，再学纯 RAPID 搬运、IO、循环。
