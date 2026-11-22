"""02 Python 发搬运：MoveJ / MoveL
先在虚拟控制器上跑通。
robtarget = 位置 [x,y,z]（毫米）+ 姿态四元数 [qw,qx,qy,qz]
  + 机器人姿态 confdata + 外轴
"""
import abb_motion_program_exec as abb

# 两个目标点：取料点 r1，放料点 r2
r1 = abb.robtarget(
    [350.0, -100.0, 600.0],
    [0.0868241, -0.0868241, 0.9924039, 0.0075961],
    abb.confdata(-1, 0, -1, 0),
    [0] * 6,
)
r2 = abb.robtarget(
    [370.0, 120.0, 620.0],
    [0.0868241, 0.0868241, 0.9924039, -0.0075961],
    abb.confdata(0, -1, 0, 0),
    [0] * 6,
)

my_tool = abb.tooldata(
    True,
    abb.pose([0, 0, 0.1], [1, 0, 0, 0]),
    abb.loaddata(0.001, [0, 0, 0.001], [1, 0, 0, 0], 0, 0, 0),
)

mp = abb.MotionProgram(tool=my_tool)
# MoveJ：关节插补去取料点，快
mp.MoveJ(r1, abb.v500, abb.fine)
mp.WaitTime(0.5)
# MoveL：直线去放料点，稳
mp.MoveL(r2, abb.v200, abb.fine)
mp.WaitTime(0.5)
# 回取料点
mp.MoveJ(r1, abb.v500, abb.fine)

print(mp.get_program_rapid())

# 真正执行前，先在 RobotStudio 里看仿真轨迹
# client = abb.MotionProgramExecClient(base_url="http://127.0.0.1:80")
# log_results = client.execute_motion_program(mp)
