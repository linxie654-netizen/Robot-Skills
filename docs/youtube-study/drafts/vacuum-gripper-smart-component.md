# 草稿：真空夹爪 Smart 组件做法

来源：Maurilio Patino 码垛教程 Part 1（视频 https://youtu.be/y0FjnO8AysQ，文字版全文已读）。
状态：草稿，待在 RobotStudio 6.08 里照做一遍、跑通后再进 `skill/robot-rapid/references/`。
库里现状：`references/smart-components.md` 只有搭组件的通用 6 步，缺真空夹爪的具体做法。

## 目标

做一个能吸住箱子、松开箱子的真空夹爪，信号一来就吸，信号一撤就放。

## 步骤

1. **导夹爪 CAD**：建空工作站，Modeling → Import Geometry，选 `.SAT` 格式的夹爪文件（GrabCAD 上能找例子）。
2. **摆正工具**：先把工具转到露出底座，用 Place Tool → One Point + Snap Center，把工具放到世界坐标系原点，再转到正确朝向。
3. **定 TCP**：Frame → Create Frame（参考系选世界坐标系）；量出工具底座到 TCP 的距离（Patino 的例子是 184 mm，用自己的夹爪要自己量），Set Position 把工具坐标系移到 TCP。
4. **生成工具文件**：Modeling → Create Tool，起名，选 Existing Component；重心用 Snap Gravity 取；TCP 起名、选刚建的工具坐标系。
5. **（可选）存成库**：点工具 → Save as Library，存成 `.rslib`，以后直接复用。
6. **建 Smart 组件**：Modeling → Smart Component，起名如 `SC_VentosaTool`；把自定义工具拖进去做子组件，工具属性用 Set as Role 设为 Role。
7. **加传感器**：在 TCP 处放一个 Line Sensor，定好起点和终点的小圆柱，就是传感器的检测线。
8. **接逻辑**：Design 窗口里新建一个数字输入 DI（如 `DI_Attach`），接线逻辑是——
   - 吸：传感器 SensorOut 为真 → Attacher 执行
   - 放：DI_Attach 为假 → Detacher 执行（注意：放的逻辑要过一个 LogicGate NOT）
   - Attacher/Detacher 的 Child 都设成 `LineSensor.SensedPart`（也就是传感器碰到的箱子），Parent 设成夹爪工具。
9. **存成库**：Smart 组件 → Save as Library，存成 `.rslib`。

## 容易错的地方

- TCP 距离要自己量，别抄 184 mm，那是 Patino 那个夹爪的数。
- 放的逻辑要取反（DI 为假才放），直接接会吸住不放。
- Attacher 的 Parent 必须是夹爪工具，不然箱子吸到别的地方去。

## 跟库里已有的关系

- 库里 `rapid/02_pick_place.mod` 的搬运是写死的取放，这个是 Smart 组件版的吸放，信号驱动。
- 库里 `references/smart-components.md` 讲通用搭法，这个是真空夹爪的完整实例，补进去后新手能直接照做。
