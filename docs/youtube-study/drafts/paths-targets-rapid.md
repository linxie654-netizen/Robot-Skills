# 草稿：用 RAPID 让机器人沿路径走

来源：Aleksandar Haber《How to Easy Program ABB Robots to Follow a Path by Using RAPID Programming Language》（视频 https://www.youtube.com/watch?v=zZXk-TW2iCE）。
状态：草稿，待在 RobotStudio 里照做一遍、跑通后再进 `skill/robot-rapid/references/`。
学法说明：视频本身未逐帧看；流程按 Haber 视频讲的顺序（导模型、装末端执行器、点动记点、建路径、写 RAPID 沿路径走），每一步用 CMU Future CNC 官方教程、ITAR《RobotStudio Handbook》、卡尔加里大学 YuMi 指南、plcprogramming.io RAPID 教程交叉核对过；没核实的写“未核实”，不编。
库里现状：`rapid/01_move_basics.mod` 讲了 MoveJ / MoveL 是什么，但没讲从建站、记点、建路径到同步成 RAPID、跑起来的完整操作链；这篇补的就是这条链。对新手课 L4（示教点）、L6（路径与程序）。

## 完整流程（7 步）

1. **导模型**：Home → Import Geometry，导工件或末端执行器的几何模型（STEP / IGES 等），摆到机器人够得着的位置。
2. **装末端执行器**：Modeling 里把工具模型挂到机器人法兰上，定义 tooldata（TCP）。TCP 没标定就先标——见草稿 `tool-frames-definition.md`，TCP 不准，后面所有点都偏。
3. **点动记点**：Jog Joint（轴点动）或 Jog Linear（直线点动）把机器人点到要走的位置，Home → Teach Target 记下 robtarget；也可以 Home → Target → Create Target 按数值直接建点。点要挂到工件坐标系下（见草稿 `workobject-three-point.md`），别挂到世界坐标系。
4. **建路径**：Home → Path → Empty path 建空路径，把目标点按顺序拖进路径；每一段选运动类型——空中大跨度用 MoveJ，贴工件走直线用 MoveL；沿模型边走可用 Auto path 自动沿边生成目标点。
5. **同步到控制器**：右键 T_ROB1 → Synchronize to VC，路径就变成控制器里的 RAPID 程序（一个 Path 过程 + robtarget 声明）。
6. **写 / 读 RAPID**：同步生成的程序长这样（点位是示教值，上真机前必须重示教）：

```rapid
MODULE Module1
    CONST robtarget pStart:=[[500,0,600],[1,0,0,0],[0,0,0,0],[9E9,9E9,9E9,9E9,9E9,9E9]];
    CONST robtarget p10:=[[500,200,300],[1,0,0,0],[0,0,0,0],[9E9,9E9,9E9,9E9,9E9,9E9]];
    PROC main()
        Path_10;
    ENDPROC
    PROC Path_10()
        MoveJ pStart, v1000, z50, tool0\WObj:=wobj0;
        MoveL p10, v500, fine, tool0\WObj:=wobj0;
    ENDPROC
ENDMODULE
```

`MoveJ 目标, 速度, zone, 工具`：速度 v1000 是空中快移，v500 是贴工件慢走；zone：z50 是空中过渡点可以拐弯，fine / z1 是贴工件必须走到位。工具和工件用 `\WObj:=` 指明，别漏。
7. **跑仿真**：Simulation → Simulation Setup，把 Path_10 加进主序列，点 Play；或者先不跑程序，右键路径 → Move Along Path，只验证轨迹走得对不对。

## 容易错的地方

- **Move Along Path 报错**：先加 `ConfL Off` 和 `ConfJ Off`（右键路径 → Insert Action Instruction → Instruction Templates 里选），再不行用 Auto Configuration 给所有 Move 指令重算构型。
- **轨迹拐弯 / 够不着**：点太少机器人会抄近路，中间加过渡点（Approach 点）；点在可达范围外就挪工件或机器人位置，别硬改点位数值。
- **MoveJ / MoveL 用反**：贴工件（焊接、点胶、装配插入）必须 MoveL，空中赶路用 MoveJ；用反了轨迹是歪的。
- **zone 用错**：贴工件的点用 fine 或 z1，空中过渡点才用 z50；全用 fine 跑得慢，全用 z50 贴工件会撞。
- **忘了同步**：只在工作站里建了路径、没 Synchronize to VC，控制器里就没有程序，仿真跑的是旧程序。

## 跟库里已有的关系

- `rapid/01_move_basics.mod`：MoveJ / MoveL 的概念；这篇是完整操作链，补进去 L4、L6 就完整了。
- H1 / H2 点动、H3 工具坐标系、H4 工件坐标系三点法：都是这篇的前置步骤，先会点动和坐标系，再学路径。
- Patino 码垛 Part 3：建了 3 个工件坐标系 + 取放轨迹，是“沿路径走”的实战版；两个草稿互相印证。
