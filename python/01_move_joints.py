"""01 Python 发关节运动：MoveAbsJ
来源思路：rpiRobotics/abb_motion_program_exec（Apache-2.0）
先在 RobotStudio 虚拟控制器上跑，不要直接上真机。

步骤：
1. RobotStudio 里建站，启动虚拟控制器
2. 控制器里先装好 abb_motion_program_exec 的 RAPID 端（见 vendor/abb_motion_program_exec/robot/）
3. 本机跑：python 01_move_joints.py
   默认连 http://127.0.0.1:80 ，虚拟控制器就是这个地址
"""
import abb_motion_program_exec as abb

# 关节目标：[J1, J2, J3, J4, J5, J6]，单位度；外轴全 0
j1 = abb.jointtarget([10, 20, 30, 40, 50, 60], [0] * 6)
j2 = abb.jointtarget([-10, 15, 35, 10, 95, -95], [0] * 6)
j3 = abb.jointtarget([15, -5, 25, 83, -84, 85], [0] * 6)

# 工具：TCP 在法兰前方 0.1m，重量 0.001kg（教学值）
my_tool = abb.tooldata(
    True,
    abb.pose([0, 0, 0.1], [1, 0, 0, 0]),
    abb.loaddata(0.001, [0, 0, 0.001], [1, 0, 0, 0], 0, 0, 0),
)

mp = abb.MotionProgram(tool=my_tool)
mp.MoveAbsJ(j1, abb.v1000, abb.fine)
mp.MoveAbsJ(j2, abb.v500, abb.fine)
mp.MoveAbsJ(j3, abb.v500, abb.fine)
mp.WaitTime(1)

# 只打印生成的 RAPID，不执行：先检查对不对
print(mp.get_program_rapid())

# 确认仿真里没问题，再取消下面两行的注释，真正执行
# client = abb.MotionProgramExecClient(base_url="http://127.0.0.1:80")
# log_results = client.execute_motion_program(mp)
# print(log_results.column_headers)
