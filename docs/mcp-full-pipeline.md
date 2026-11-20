# MCP 从 0 到 1 全流程（6 段）

> 2026-11-20 用户拍板：MCP 太难，改做 Skill。这份文档留档，工具草稿不再编测；现行做法见 `docs/full-pipeline.md`（Skill 版）。

目标：MCP 工具走完一个工作站从空到能跑程序的全过程。按顺序做，每段先有工具、再实测。

## 1. 工作站创建

- 已有：无
- 草稿：`rs_create_station`（station-tool/ 目录，未测试）
  - C#：`new Station()` + `ActiveTask = DefaultTask` + `Project.ActiveProject = station`
  - 待测：新工作站能不能建出来、3D 窗口在不在、能不能存盘
- 缺：无（就这一个工具）

## 2. 加机器人

- 已有：无
- 导库一半已核实（2026-11-20）：从 .rslib 导机构用同一套 `GraphicComponentLibrary.Load` + `CopyInstance` + `GraphicComponents.Add`（见 verification-notes.md）
- 缺：`rs_add_robot`（待写）；建虚拟控制器从 0 新建系统没找到 SDK 调用（只能走 Installation Manager / System Builder 界面），启动已有 VC 已核实（`RsIrc5Controller.StartAsync`）
- 前置：必须先定机器人型号（用户还没确认）

## 3. 示教器（教点、点动）

- 已有：`rs_create_target`（教目标点）、`rs_get_position` / `rws_get_position`（读位置）
- 点动：手动点动命令 SDK 里没有（ABB 工程师亲口确认）；仿真侧可用 `Mechanism.SetJointValues` 改关节角代替，草稿 `rs_jog_joint` 已写（pipeline-tools/），未测试
- 注意：虚拟示教器本身是 RobotStudio 里的界面，MCP 开不出来；MCP 只能做示教器对应的操作（点动、教点、读位置），不是把示教器窗口搬过来

## 4. 建模

- 已核实（2026-11-20）：`Part.Load(fileName)` 导 CAD + `Body.CreateSolidCone` 建几何 + `station.GraphicComponents.Add`，ABB 官方示例和论坛实例；草稿 `rs_import_cad` / `rs_create_solid` 已写（pipeline-tools/），未测试；`rs_create_solid` 只做了验证过的 cone

## 5. 组件（Smart 组件）

- 已核实（2026-11-20）：`GraphicComponentLibrary.Load(path, true)` + `RootComponent.CopyInstance()` + `station.GraphicComponents.Add`，ABB 论坛标准写法；草稿 `rs_add_smart_component` 已写（pipeline-tools/），未测试；同一套写法也能从 .rslib 导机器人机构

## 6. 编程

- 已有：`rs_write_module`、`rs_validate_rapid`、`rs_create_path`、`rs_create_target`、`rws_write_module`、`rws_load_module_from_file`、`rws_load_program`
- 缺：无（这段已通）
- 待验证：`rs_read_module` 仍需装载程序后验证

## 顺序与状态（2026-11-20 14:30，已核实 4 处调用）

| 段 | 状态 |
| --- | --- |
| 1 工作站创建 | 草稿已写，等另一 AI 编测 |
| 2 加机器人 | 导库已核实，建 VC 新系统没找到调用，等型号 |
| 3 示教器 | 教点已有，点动草稿已写（SetJointValues 替代方案），未测试 |
| 4 建模 | 调用已核实，草稿已写，未测试 |
| 5 组件 | 调用已核实，草稿已写，未测试 |
| 6 编程 | 已有 |

核实结论与草稿见 `~/workspace/abb-mcp-fork/verification-notes.md` 和 `pipeline-tools/`。
