# Python 用法：怎么用 Python 控制 ABB 机器人

**先说清楚：Python 在这里是辅助，RAPID 才是主体。**

机器人怎么动，RAPID 说了算——RAPID 是机器人本体语言，在控制器里跑，管实时运动。Python 在电脑上跑，帮你批量、自动地指挥机器人和处理数据，不代替 RAPID。

| 谁 | 在哪跑 | 管什么 |
| --- | --- | --- |
| RAPID | 控制器里 | 机器人怎么动：MoveJ / MoveL / MoveAbsJ、IO、循环、坐标系 |
| Python | 电脑上 | 生成 RAPID 发给控制器、批量生成程序、数据处理、接视觉和 AI |

## Python 在这里干什么

| 要干什么 | 用什么 | 得到什么 |
| --- | --- | --- |
| 发一段关节运动 | `01_move_joints.py` | 生成 MoveAbsJ 的 RAPID，先打印检查再执行 |
| 发一段搬运 | `02_pick_place.py` | 生成 MoveJ / MoveL 的 RAPID，取料、放料 |
| 批量生成程序 | 同一个 `MotionProgram` 写法，循环里改点位 | 不用一个个手写 RAPID |
| 数据处理 | Python 标准库、numpy | 算点位、读文件、批量改数据 |
| 接视觉和 AI | 方向，库里还没有现成例程 | 以后再说，先把上面两条跑通 |

思路来自上游库 rpiRobotics/abb_motion_program_exec（Apache-2.0，见 `vendor/abb_motion_program_exec/`）：Python 写运动指令，生成 RAPID，下发到控制器执行。

## 环境怎么装

1. **装 Python**：电脑上装好 Python 3。上游库标注 Python 3.6+（见 `vendor/abb_motion_program_exec/README.md`）。
2. **装依赖**：进到 `python/` 目录，跑：
   ```
   pip install -r requirements.txt
   ```
   装的是 `abb-motion-program-exec` 和 `numpy`。numpy 在 `requirements.txt` 里，但两个例程里没用到它。
3. **RobotStudio 里建站，启动虚拟控制器**：按 `robotstudio/tutorial.md` 建站。
4. **控制器里装 RAPID 端**：把 `vendor/abb_motion_program_exec/robot/` 里的文件装到控制器上，步骤见上游库的 `docs/robot_setup_manual.md`。
5. **注意**：一次只能开一个虚拟控制器——虚拟控制器占 TCP 80 端口，两个一起开会冲突（上游库 README 原话）。

## 两个例程是干什么的

| 例程 | 干什么 | 关键点 |
| --- | --- | --- |
| `01_move_joints.py` | 发关节运动 MoveAbsJ | 三个关节目标 J1–J6（单位度），速度 v1000 / v500，到位方式 fine，停 1 秒；工具 TCP 在法兰前方 0.1 m、重量 0.001 kg，都是教学值 |
| `02_pick_place.py` | 发搬运 MoveJ / MoveL | 取料点 r1 [350, -100, 600]、放料点 r2 [370, 120, 620]（毫米）；MoveJ 去取料点（快），MoveL 直线去放料点（稳），再回取料点 |

两个例程都一样：**只打印生成的 RAPID，不执行**。执行那两行默认是注释掉的：

```python
print(mp.get_program_rapid())

# 确认仿真里没问题，再取消下面两行的注释，真正执行
# client = abb.MotionProgramExecClient(base_url="http://127.0.0.1:80")
# log_results = client.execute_motion_program(mp)
```

默认连 `http://127.0.0.1:80`，虚拟控制器就是这个地址。

## 标准流程：先打印，再执行

每一步都有“做到什么样算过”，没过就别往下走。

**第 1 步：跑脚本，看打印的 RAPID**
```
python 01_move_joints.py
```
算过：屏幕上打印出一段 RAPID，里面有你写的 MoveAbsJ，点位和速度跟你写的一致。

**第 2 步：检查打印出来的 RAPID**
对着看三样：点位对不对、速度对不对（v1000 / v500 / v200）、工具对不对。点位是教学值，在仿真里重新示教。
算过：三样都对得上，没看不懂的行。

**第 3 步：虚拟控制器里跑**
先在 RobotStudio 虚拟控制器上跑通，看轨迹、查碰撞。
算过：仿真里完整跑完一遍，没报错、没撞。

**第 4 步：没问题再真正执行**
取消执行那两行的注释，再跑一次脚本，真正下发到控制器。
算过：控制器执行完，日志有结果返回。

## 规矩：别碰的线

- **没仿真过不跑**：所有程序先在虚拟控制器里跑通、查完碰撞，再低速手动验证。
- **EGM 先不碰**：上游库支持 EGM 实时控制，但需要 RobotWare EGM 选项，等 MoveJ / MoveL 在仿真里跑通再说。
- **一次只改一处**：改完跑一遍；一次改五处，报错了不知道是哪处改坏的。
- **点位、速度、工具都是教学值**：换到你的工件和夹具上必须重新示教。
- **一次只开一个虚拟控制器**：都占 80 端口，开两个会冲突。

## 报错先看最后一行

报错先看最后一行，那行就是原因。几个新手最常碰到的（标准 Python 报错，不是本库特有的）：

| 报错 | 原因 | 怎么办 |
| --- | --- | --- |
| `IndentationError` | 缩进错了 | 对齐缩进，Python 靠缩进认代码块 |
| `NameError` | 变量没定义就用了 | 检查变量名有没有拼错、是不是先用了后定义 |
| `ModuleNotFoundError` | 库没装 | 先跑 `pip install -r requirements.txt` |
| `TypeError` | 类型对不上 | 看最后一行说的那两个东西，一个是数、一个是文字就对不上 |

一次只改一处，改完再跑。

## C 语言呢？

C / C++ / C# 跟 ABB 机器人编程有关联，但**都是辅助且进阶，不是主体**，库里也没有 C 代码，所以没有要上传的 C 东西。

| 关联点 | 是什么 | 结论 |
| --- | --- | --- |
| `abb_wrapper` / `abb_libegm` + `abb_librws` | C++ 库，连 EGM 和 RWS（见 `docs/comparison.md`） | 进阶 C++ 开发，不适合入门；以仓库为准 |
| RobotComponents | Grasshopper 插件，Python / C# API | 有 Rhino 基础才用得上，否则先不动 |
| C# 插件 | RobotStudio 插件、PC SDK 都是 C# / .NET 那边的 | 以前 MCP 路线用过 C# 插件，MCP 已停、相关文件已删 |
| EGM | 实时控制要开 RobotWare EGM 选项 | 先不碰，等 MoveJ / MoveL 跑通再说 |

一句话：C 那边是给进阶开发留的路，先把 RAPID + Python 联动跑通再说。

## 还没有的内容


- GUI 例程：库里暂无，方向是先从 Python 自带的 tkinter 入手，换框架等用户说。
- PLC 直连的 Python 例程：库里暂无，先学 Python + ABB 联动。
- 视觉 / AI 联动例程：库里暂无，方向先记下来。
- 双机联动（Multi-Move）：上游库支持，库里没有例程。
- C++ 的 `abb_libegm` / `abb_librws`：只在 comparison.md 里记了一行。
