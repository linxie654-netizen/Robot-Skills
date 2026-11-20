# 草稿：三点法定义工件坐标系

来源：Aleksandar Haber《How to Correctly Define and Create Workobject Frames and Coordinate Systems》（视频 https://www.youtube.com/watch?v=5fdcGGy9IzI，文字版 https://aleksandarhaber.com/21779-2/）。
状态：草稿，待在 RobotStudio 6.08 里照做一遍、跑通后再进 `skill/robot-rapid/references/`。
库里现状：`rapid/05_coordinates.mod` 讲了 wobjdata 是什么，但没讲三点法具体怎么点。

## 为什么要用工件坐标系

工件坐标系是用户自己定的坐标系，通常跟工件的几何对齐。好处：工件一挪位置，只改工件坐标系就行，不用重示教每个点（新手常犯的错就是工件一动就全重示教）。

## 步骤（按 Haber 视频）

1. **建个盒子练手**：在 RobotStudio 里建模一个盒子（Box），调好尺寸。这一步是练手，也是后面定坐标系的参照物。
2. **开三点法**：建工件坐标系时选三点法（Three-point method）。
3. **取三个点**：按顺序取原点、X 方向点、Y 方向点——
   - 第 1 个点：原点（工件坐标系的零点，一般取工件一角）
   - 第 2 个点：X 轴方向上的点
   - 第 3 个点：Y 轴方向上的点
   - 三个点定了，坐标系就定了（Z 轴按右手定则出来）。
4. **检查**：看坐标系方向对不对：X、Y 沿着工件边，Z 垂直于工件面。不对就重取，别将就。
5. **用起来**：目标点都挂到这个工件坐标系下写，程序里用 `wobjdata` 引用它。

## 容易错的地方

- 三个点的顺序别搞反（原点、X、Y），反了坐标系就歪了。
- 点别取在工件本身会动的地方，取在固定、可复现的位置。
- 工具 TCP 没标定就定工件坐标系，点位全偏——先标工具，再定工件。

## 跟库里已有的关系

- `rapid/05_coordinates.mod`：讲 tooldata、wobjdata 的概念；这个是三点法的操作步骤，补进去 L9 就完整了。
- Patino Part 3 建了 3 个工件坐标系（传送带 + 大小托盘），是三点法的实战应用，两个草稿可以互相印证。
