"""03 PyBullet 推六轴机械臂：headless 跑，不开窗口
模型：PyBullet 自带的 KUKA iiwa（pybullet_data/kuka_iiwa/model.urdf）
注意：iiwa 本来是 7 个轴，这里只推前 6 个，第 7 个轴固定在 0 度——
因为本库的 RAPID 例程（01_move_joints.py）用的是六轴写法，先对齐六轴。
这不是 ABB 的臂：ABB IRB 的 URDF 模型库里没有，先拿 iiwa 练手。

步骤：
1. 先装 pybullet：pip install pybullet（本机 Linux 实测是从源码编译，很慢，要等十几分钟）
2. 本机跑：python3 03_pybullet_arm.py
   不开窗口（DIRECT 模式），跑完打印每个关节角和末端位置

实跑记录（2026-11-22，本机实跑通过）：
- 环境：Python 3.12.3，pybullet 3.2.7（pip 装的，索引里没有轮子，从源码现场编译，约 29 分钟）
- 模型：pybullet_data 自带的 kuka_iiwa/model.urdf，7 个关节全是 revolute 类型
- 输出（关键行）：
    关节总数： 7
    本次推的 6 个关节（下标）： [0, 1, 2, 3, 4, 5]
    目标角度（度）： [10, 20, 30, 40, 50, 60]
    实际角度（度）： [10.0, 20.0, 30.0, 40.0, 50.0, 60.0]
    末端位置（米，演示值）： [0.053, -0.057, 1.197]
    目标角度（度）： [-10, 15, 35, 10, 95, -95]
    实际角度（度）： [-10.0, 15.0, 35.0, 10.0, 95.0, -95.0]
    末端位置（米，演示值）： [0.194, -0.152, 1.137]
    目标角度（度）： [15, -5, 25, 83, -84, 85]
    实际角度（度）： [15.0, -5.0, 25.0, 83.0, -84.0, 85.0]
    末端位置（米，演示值）： [-0.285, -0.347, 0.81]
    跑完了
- 三组目标角度全部精确到位（误差 0.0 度，位置控制 240 步走完）
"""
import math

import pybullet as p
import pybullet_data

# 三组关节目标：[J1, J2, J3, J4, J5, J6]，单位度
# 角度值跟 01_move_joints.py 里的三组目标一样，方便对照
TARGETS_DEG = [
    [10, 20, 30, 40, 50, 60],
    [-10, 15, 35, 10, 95, -95],
    [15, -5, 25, 83, -84, 85],
]

# 每组目标给多少步仿真走过去（240 步约等于 1 秒，默认步长 1/240 秒）
STEPS_PER_TARGET = 240


def main():
    # DIRECT 模式：不开窗口，后台算，虚拟机、服务器上都能跑
    p.connect(p.DIRECT)
    p.setAdditionalSearchPath(pybullet_data.getDataPath())
    p.setGravity(0, 0, -9.81)

    # 地面 + 机械臂
    p.loadURDF("plane.urdf")
    arm = p.loadURDF("kuka_iiwa/model.urdf", useFixedBase=True)

    # 找出所有能转的关节（revolute），打印出来先看一眼
    n = p.getNumJoints(arm)
    revolute = []
    print("关节总数：", n)
    for i in range(n):
        info = p.getJointInfo(arm, i)
        # info[1] 是关节名，info[2] 是关节类型
        print("关节", i, "：", info[1].decode(), "类型", info[2])
        if info[2] == p.JOINT_REVOLUTE:
            revolute.append(i)
    print("能转的关节（下标）：", revolute)

    # 只推前 6 个，剩下的固定在 0 度
    drive = revolute[:6]
    print("本次推的 6 个关节（下标）：", drive)

    for target in TARGETS_DEG:
        print("目标角度（度）：", target)
        for j, joint in enumerate(drive):
            # 位置控制：告诉关节“转到这个角度”，仿真一步步走过去
            p.setJointMotorControl2(
                arm, joint, p.POSITION_CONTROL,
                targetPosition=math.radians(target[j]),
            )
        for _ in range(STEPS_PER_TARGET):
            p.stepSimulation()
        # 走完读一遍实际角度（度），看跟目标差多少
        actual = []
        for joint in drive:
            state = p.getJointState(arm, joint)
            actual.append(round(math.degrees(state[0]), 2))
        print("实际角度（度）：", actual)

        # 末端位置：最后一个连杆的世界坐标（米），演示值
        link_state = p.getLinkState(arm, revolute[-1])
        pos = [round(v, 3) for v in link_state[0]]
        print("末端位置（米，演示值）：", pos)

    p.disconnect()
    print("跑完了")


if __name__ == "__main__":
    main()
