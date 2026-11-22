# Changelog

All notable changes to this repo are recorded here. Dates are in the user's local time (Asia/Shanghai).

## [2.1.0] — 2026-11-22

### Added

- 七个实战项目（projects/）：搬运、码垛、分拣、焊接、上下料、输送带跟踪、三机器人联动，每个含完整代码、搭建步骤、IO 配置、仿真方法、故障分析、安全检查。
- 教学支撑：docs/teaching-guide.md（八种教法）、docs/exam-practice.md（35 道练习题）、docs/progress-tracker.md（学习进度表）；skill/robot-rapid/SKILL.md 加“八种教法”一节。
- docs/3d-simulation-research.md（Three.js、PyBullet、URDF 研究）+ python/03_pybullet_arm.py（PyBullet 六轴演示）+ docs/threejs-arm-demo.html（网页版六轴演示）。
- checks/：代码、文档、依赖、Skill 安装测试、安全检查五项，一键跑。

### Changed

- 按用户纠正（2026-11-22）：删掉核实状态类标注，删掉全部真实设备相关内容；技能只针对 RobotStudio 仿真学习，安全检查只写仿真里的检查项。

## [2.0.0] — 2026-11-22

### Added

- `python/README.md`: how to use Python with the robot — auxiliary only (Python generates RAPID and automates; RAPID is the main subject).
- `skill/robot-rapid/skill.yaml`: skill metadata for Robot-RAPID, matching its `SKILL.md` frontmatter.
- `README_EN.md`: full English version of the README.
- `CONTRIBUTING.md`: how to ask questions and suggest content.
- `SECURITY.md`: safety notes for teaching code and real hardware.
- MIT License (`LICENSE`).
- `docs/advanced-topics.md`: 进阶三课——EGM、多任务、外轴，大白话教学；三课都没在 RobotStudio 里跑过，全部标“未核实”。
- `docs/comparison.md`: 2.0 对比（2026-11-22 实查五家 GitHub 页面），“值得抄的清单”14 条，每条注明出处和目标文件。
- `docs/evals.md`: “同一提示，有技能 vs 没技能”对照（RAPID 版 evals），4 个纸面例子，没跑过对照实验，不算基准测试。
- `skill/robot-rapid/SKILL.md`: 常见借口和反驳（rationalizations）、危险信号（red flags）两节；每课 / 每个模式“做到什么样算会”（exit_conditions）；跑通要拿三样证据，感觉对了不算数。
- `skill/robot-rapid/references/simulation-checklist.md`: 验证前先写清这次看什么（seams：轨迹、IO、速度、碰撞）；跑通的证据要求（报错截图或“无报错”、轨迹、碰撞检查结果），缺一样不算跑通。
- `docs/beginner-roadmap.md`: 每课末尾加一句“算会：……”，标准从现有内容提炼，没编新标准。

### Changed

- Repo renamed `abb-robot-programming` → `Robot-Skills` (2026-11-22): easier to remember and install. New install command: `npx skills add linxie654-netizen/Robot-Skills`. The old address redirects automatically.
- README 开头标语定为“Robot-Skills，让 AI 更会写 RAPID。”

### Fixed

- Removed version-pinned wording from the README and the skills (no more pinned RobotStudio / RobotWare version numbers); content is written generically, not split by version.

## [1.0.0] — 2026-11-21

First release: https://github.com/linxie654-netizen/Robot-Skills/releases/tag/v1.0.0

### Added

- Robot-RAPID skill (`skill/robot-rapid/`): the ABB robot mentor — 30 plain-language beginner lessons, 10 RAPID routines, 0-to-1 station pipeline, error handbook, simulation checklist, Smart Component guide.
- One-command install: `npx skills add linxie654-netizen/Robot-Skills` (verified working with the skills.sh CLI).
- RAPID routines `rapid/01`–`rapid/10`, Python examples `python/01`–`python/02`, RobotStudio tutorial, beginner roadmap, cheat sheet, comparison table.

## [0.1.0] — 2026-11-20

- Repo created; skill and library built up question by question from the ABB learning window.
