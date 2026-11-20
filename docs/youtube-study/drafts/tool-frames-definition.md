# 工具坐标系定义方法（草稿）

来源：Haber H3《ABB Robot Tutorial: Defining Tool Frames and Basic Modeling in ABB RobotStudio》（标题与内容方向已核实，作者文字版只有两行，细节靠下面两份交叉材料补）；方法三选一见 ITAR《Hands-on with ABB Robots》（ardavan.io，补充材料，非视频原文）；Create Tool 向导步骤见 CMU《10 Steps to Add a Tool》。
状态：待在 RobotStudio 6.08 里照做一遍、跑通后再进正式文件。

## 1. 先分清两个东西

- 工具几何：夹爪、焊枪、吸盘的 3D 模型，导进工作站。
- 工具坐标系（tooldata）：TCP 在哪、朝向怎么定。没定义工具时机器人默认用 tool0，TCP 在法兰中心、Z 轴沿法兰法线。

## 2. FlexPendant 上定义工具的三种方法（按需选）

| 方法 | 什么时候用 | 怎么做 |
|---|---|---|
| TCP（4 点，默认方向） | 工具沿法兰 Z 轴、绕 Z 转不影响干活（如圆头记号笔） | 固定点，从 4 个不同方向把 TCP 对准它 |
| TCP + Z 方向 | 工具 Z 轴和法兰 Z 轴不一样、但绕 Z 转不重要 | 4 点定 TCP，再加一点定 Z 方向 |
| TCP + Z 和 X 方向 | 接近姿态必须精确，连绕 Z 的转角都要定 | 4 点定 TCP，再加两点定 Z、X 方向 |

要点：每种方法都要从多个方向对准空间中同一个固定点，点得越准，TCP 越准。

## 3. RobotStudio 里建工具（Create Tool 向导，CMU 10 步）

1. Modeling → Import Geometry，导工具模型（.stl 等，建模单位先设成 mm）。
2. Modeling → Create Tool，起名字。
3. Use Existing，选刚导进来的几何。
4. 其他设置不填也行，Next。
5. 起 TCP 名（只有一个 TCP 就默认），填每个 TCP 的位置和姿态，加进 TCP 列表，Done。
6. Layout 里把工具拖到机器人上，弹窗点 No（让它自动摆正位置）。
7. 要改：Home → Paths&Targets → tooldata 文件夹，右键工具 → Modify Tooldata。

## 4. TCP 位置怎么量

- 量法兰安装面到 TCP 的距离，填进 TCP 的 Z 值（工具 Z 轴从手腕向外指）。
- Patino 的例子：吸盘底座到 TCP 量出来是 184 mm（每把工具自己量，别照抄）。
- 重心：工具重心用 Snap Gravity 取（见真空夹爪草稿），重量填错会影响负载估算。

## 5. 对应库里

- `rapid/05_coordinates.mod`：tooldata 概念。
- 新手路线 L9（坐标系）。
- 本草稿补的是“具体怎么点”，库里原来只有概念。

## 6. 容易错

- 建模单位不是 mm 就导错尺寸：导之前先确认单位。
- 工具 Z 轴方向搞反：Z 轴从手腕向外指，不是向里。
- 只有一个 TCP 也留默认名，别手改出两个 TCP 互相混。
