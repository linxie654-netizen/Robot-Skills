# 3D 仿真研究：Three.js、PyBullet、URDF

> 大白话版。不编版本号、安装命令、API 名。
> 研究日期：2026-11-22。本地环境：Python 3.12.3，Node v24.22.1。

## 一句话先说清

| 东西 | 一句话 | 跟 RobotStudio 的关系 |
| --- | --- | --- |
| Three.js | 在网页里画 3D 的 JavaScript 库 | 补充：只管“画出来好看、能在浏览器里转”，不管机器人真怎么动 |
| PyBullet | 用 Python 跑物理仿真的库，能加载机器人模型、算碰撞、推关节 | 补充：能验运动学和碰撞，但跑不了 RAPID，代替不了虚拟控制器 |
| URDF | 描述机器人长什么样的一个 XML 文件格式 | 补充：是模型文件的“通用写法”，RobotStudio 有自己的工作站格式，两边不直通 |

三样都不是 RobotStudio 的替代品。RobotStudio 是 ABB 官方的仿真工具，里面跑的是真正的虚拟控制器、真正的 RAPID 程序；上面三样是帮你在网页、Python 里多一种办法看机器人、验动作。

---

## 1. Three.js：网页里的 3D

### 是什么

Three.js 是一个 JavaScript 库，专门在浏览器里画 3D 图形，底层用 WebGL（新版本也支持 WebGPU）。官网原话：一个跨浏览器的 JavaScript 库，用 WebGL 和 WebGPU 做 3D 图形。开源，MIT 协议，代码在 GitHub 的 mrdoob/three.js 仓库。

说人话：浏览器本身画 3D 很麻烦，要直接写 WebGL 代码；Three.js 把这些包了一层，你写几十行就能在网页里放一个能旋转、能缩放的 3D 模型。

### 能干什么

- 在网页里画 3D 场景：机器人、零件、工作台、地面网格、灯光、阴影。
- 让用户拖着鼠标旋转、缩放看模型（轨道控制器）。
- 用滑块、按钮控制关节角度，实时看机械臂摆姿势（本库 `docs/threejs-arm-demo.html` 就是这个做法）。
- 加载现成的 3D 模型文件（比如 glTF 格式），不用自己一根根画。

### 不能干什么

- 不算物理：它不管重力、碰撞、惯量，东西不会自己掉下来、也不会撞停。
- 不跑 RAPID：它不知道 MoveJ、MoveAbsJ 是什么，关节角度得你自己算好传给它。
- 不代替 RobotStudio：没有虚拟控制器，没有 ABB 机器人模型库。

### 跟 RobotStudio 的关系：补充

RobotStudio 里建站、跑仿真，是“真家伙”；Three.js 是把结果拿到网页上给人看、给人点的“演示台”。比如：RAPID 程序里的点位，先在 RobotStudio 里跑通，再把关节角度导出来，用 Three.js 在网页上重放一遍，给别人看、给手机上看——这个链路是可行的方向。

### 学起来要装什么

- 写代码：一个浏览器 + 一个文本编辑器就能开始，不用装别的。
- 要在自己的网页里用：装 npm 包 `three`（本机实测 `npm install three` 能装，装到的是 0.187.0 版，2026-11-22 亲手装的）。
- 也可以直接引用 CDN 上的 three.js 文件。
- 离线单文件的做法：把 three.js 的代码直接嵌进 HTML 文件里（本库演示页就是这么做的，文件约 2 MB，浏览器双击就能打开，不用联网、不用起服务器——这一步在浏览器里点开能不能动还没验，见演示页文件头的验证记录）。

### 来源

- Three.js 官网文档：https://threejs.org/docs/llms.txt
- Three.js 手册：http://threejs.org/manual
- Three.js 维基百科：https://en.wikipedia.org/wiki/Three.js

---

## 2. PyBullet：Python 里的物理仿真

### 是什么

PyBullet 是一个 Python 模块，做物理仿真、机器人和机器学习用的。它基于 Bullet 物理引擎（CPU 上跑）。官方快速入门指南原话：可以加载 URDF、SDF 等格式的关节体，提供正向动力学仿真、正逆动力学计算、正逆运动学、碰撞检测。

说人话：你在 Python 里写几行代码，就能“造”一个有重力、有碰撞的世界，把机器人模型放进去，推它的关节，看它怎么动、会不会撞到东西。

### 能干什么

- 加载机器人 URDF 模型（比如 KUKA iiwa 机械臂，自带在 pybullet_data 里）。
- 一个关节一个关节地推：设定目标角度，看它转过去；读每个关节现在实际的角度。
- 算正逆运动学：给末端位置反推关节角（有现成函数，具体函数名以官方文档为准，本文不写）。
- 碰撞检测：手臂碰到桌子、碰到另一个物体，能查出来。
- 不开窗口也能跑（DIRECT 模式，headless），适合在服务器、虚拟机里批量跑。
- 开窗口能看（GUI 模式），能看 3D 画面、拖着看。

### 不能干什么

- 不跑 RAPID：PyBullet 不认识 ABB 的 RAPID 程序，也连不上虚拟控制器。
- 里面的机器人模型不是 ABB 官方的：自带的 KUKA iiwa 是 KUKA 的臂，ABB 的 IRB 系列模型得自己找 URDF，不写链接。
- 物理参数（质量、摩擦、电机力矩）是模型文件里写的，只能做“大概对”的验证，不能当标定用。

### 跟 RobotStudio 的关系：补充

RobotStudio 是“官方答案”：虚拟控制器 + RAPID + ABB 模型。PyBullet 是“便宜的试验田”：不用开 RobotStudio、不用 Windows，在 Python 里就能验一验运动学、碰撞、轨迹规划的思路。思路在 PyBullet 里跑通了，再搬到 RAPID + RobotStudio 里重做一遍、正式验证。两者不是一回事，不能互相代替。

### 学起来要装什么

- Python 3 + `pip install pybullet`（官方指南原话就是这么装）。
- 本机实测：2026-11-22 在这台 Linux 虚拟机上跑 `pip install pybullet`，pip 没有找到现成的轮子（wheel），改从源码现场编译 C++，编译时间很长（十几分钟以上，还在跑）。**这条是本机实测，不是通用结论**——Windows / 其他 Python 版本上可能直接装上轮子，不用编译。
- 装完自带 `pybullet_data`，里面有示例模型（plane、r2d2、kuka_iiwa 等），不用自己到处找模型就能先跑起来。
- 想开窗口看 3D：需要图形界面和 OpenGL；headless（DIRECT 模式）不用（本库 `python/03_pybullet_arm.py` 就是 headless 跑的）。

### 来源

- PyBullet 快速入门指南：https://github.com/bulletphysics/bullet3/raw/6ee3b6832c244452c07683123e8f152f8f4a54a0/docs/pybullet_quickstartguide.pdf
- PyBullet 快速入门指南（网页版）：https://raw.githubusercontent.com/justincredible/bullet3/master/docs/pybullet_quickstart_guide/PyBulletQuickstartGuide.md.html

---

## 3. URDF：机器人模型的“通用写法”

### 是什么

URDF，全称 Unified Robot Description Format（统一机器人描述格式），是一个 XML 文件格式，用来描述一个机器人长什么样、怎么动。最早是 ROS（机器人操作系统）那边的东西，由 Willow Garage 和 Open Source Robotics Foundation 搞出来的。

说人话：URDF 就是一份“机器人说明书文件”，里面写着：机器人有哪几根“骨头”（link，连杆）、骨头之间用什么关节（joint）连着、每根骨头多重、多长、长什么样（能挂 3D 模型文件）、关节能转多少度、最大能使多大劲。

### 一个 URDF 文件里有什么

- `<link>`：一根刚体（连杆），写着质量、惯量、长相（画出来用的几何形状或网格文件）、碰撞用的形状。
- `<joint>`：连着两根连杆的关节，写着父连杆、子连杆、转轴方向、关节类型、角度上下限。
- 关节类型有 6 种，机械臂常用的是 `revolute`（转，有上下限）和 `continuous`（一直转，没上下限，比如轮子）。
- 连杆和关节连起来是一棵树：一个根连杆，每个连杆只有一个父关节，不能有环。
- 角度单位是弧度，长度单位是米（ROS 的规矩）。

### 能干什么

- 一个文件，到处能用：ROS、Gazebo、PyBullet、MuJoCo、Isaac 这些仿真工具都认 URDF，同一个机器人模型换个仿真器不用重写。
- 仿真器读了 URDF 就知道机器人有几个关节、每个关节怎么转、会不会撞。
- 可视化工具（比如 RViz）读了 URDF 就能把机器人画出来。

### 不能干什么

- URDF 只是一份描述文件，本身不会动：得有仿真器（PyBullet、Gazebo）或可视化工具读它，它才有用。
- 只能描述树形结构：并联机器人（有环的）描述不了。
- 只写了刚体：柔软的东西（比如软管、弹簧）描述不了。
- 不是 ABB 的格式：ABB 机器人官方模型不在 URDF 生态里，RobotStudio 用自己的工作站格式。

### 跟 RobotStudio 的关系：补充

- RobotStudio 能不能直接导入 URDF：ABB 官方文档里没找到 URDF 导入 RobotStudio 的说法。
- 反过来，RobotStudio 里建好的 ABB 工作站能不能导出 URDF：ABB 官方文档里也没找到导出 URDF 的说法。
- 所以目前 URDF 在这条学习线上的定位是：PyBullet 这边的模型格式 + 以后如果学 ROS、MoveIt，URDF 是必经之路。跟 RobotStudio 之间先当成两条平行线，不硬扯到一起。

### 学起来要装什么

- 什么都不用装：URDF 就是个 XML 文本文件，记事本就能打开看。
- 要让它“活”起来：装一个能读它的工具——PyBullet（`pip install pybullet`）、或者 ROS + RViz。
- 网上有现成的机器人 URDF 模型库（比如 urdfbase.com 自称有一百个机器人模型，链接只放这里，不背书）：https://urdfbase.com/

### 来源

- ROS 工业培训 URDF 介绍：https://ros-industrial.github.io/ros2_i_training/_source/urdf/introduction.html
- URDF 机器人模型教程：https://docs.robotic-suite.advantech.com/docs/Tutorial/ros/urdf/
- URDF 格式讲解与模型库：https://urdfbase.com/

---

## 三样怎么配合着用（学习路线建议）

1. **先看懂 URDF**：打开一个现成的机械臂 URDF，对着 `<link>` 和 `<joint>` 看，明白“六轴”在文件里就是六个 `revolute` 关节。
2. **再用 PyBullet 跑起来**：`python/03_pybullet_arm.py`，headless 加载 KUKA iiwa，六个关节按给定角度动，打印关节角——先把“程序能推关节”这件事跑通。
3. **再用 Three.js 画出来**：`docs/threejs-arm-demo.html`，浏览器里拖滑块转六个关节，看姿势、看末端坐标——先把“人能看懂机器人在干什么”跑通。
4. **最后回到 RobotStudio**：上面两步只是练手，RAPID 程序还是要在 RobotStudio 虚拟控制器里跑通、查完碰撞，才算数。PyBullet 和 Three.js 里跑通 ≠ 在 RobotStudio 虚拟控制器里跑通。

## 演示验证记录（2026-11-22，本机实测）

### PyBullet 演示（`python/03_pybullet_arm.py`）——跑通了

- 装 pybullet：索引里没有预编译轮子（`--only-binary` 直接报找不到版本），只能从源码编译，约 29 分钟，装上的是 3.2.7 版。
- 模型：pybullet_data 自带的 `kuka_iiwa/model.urdf`，7 个关节全是 revolute 类型；演示只推前 6 个，第 7 个固定 0 度。
- 实跑：`python3 03_pybullet_arm.py`，headless（DIRECT 模式）一次跑完，三组目标角度全部精确到位（实际角度与目标差 0.0 度），末端位置正常打印。完整输出贴在脚本文件头注释里。
- 卡住过的地方：第一次编译失败（`/tmp` 只有 512 MB，编译中途满了）；第二次把临时目录改到 workspace（`TMPDIR=~/workspace/scratch-3d/tmp`）才编过去。

### Three.js 演示（`docs/threejs-arm-demo.html`）——已验证

做了的验证：

- 内嵌的整个 module 脚本（Three.js 库代码 + 演示代码，约 2 MB）用 `node --check` 过了，语法没问题。
- 演示的关节结构、杆长、转轴，用 node + 真 three.js（npm 包 0.187.0）复算了一遍正运动学：全零位末端 [0, 1.260, 0]，J2=90° 时末端 [-0.840, 0.420, 0]，跟手算的杆长对得上，说明演示的运动学数学是对的。
- 离线单文件：Three.js 0.187.0 的库代码直接嵌在文件里，不引用 CDN、不起服务器。
- 真实浏览器验证（2026-11-22）：用户在手机浏览器上打开，3D 正常显示、滑块拖动跟手，说没问题；我这边也装了 headless Chromium（Playwright 1255）跑了一遍，0 报错，J3 拖到 30°、夹爪夹紧后末端坐标跟着变。

2026-11-22 用户反馈改的四样：① 世界坐标 XYZ 轴标出来了（红 X、绿 Y、蓝 Z），末端也有个小 x/y/z 坐标架跟夹爪一起动；② 回零位改成截图里那个弯着的姿势（J1 170°、J2 1°、J3 90°、J4 0°、J5 86°、J6 2°），打开就是截图那个样子，机器人不再是直的；③ 更逼真：大臂小臂改成锥形、关节加了盖子、底座加了法兰盘、地面接阴影；④ 加了两指夹爪，带开合滑块（0=夹紧，100=张开），末端点改到夹爪指尖，坐标比原来多伸出去 7 厘米。
- 拼文件时踩过一个坑：three 0.187.0 的 `three.core.js` 和 `three.module.js` 里有重名的内部变量（比如 `_m1$1`），直接拼在一起会报“重复声明”；最后是把 core 包进一个函数里、只把公开名字交出来，才拼过去的。

2026-11-22 用户又提五点（Q90）：① 坐标轴不对，要 ABB / RobotStudio 的规矩（X 前后、Y 左右、Z 上下）；② 加线性运动；③ 跟现实和 RobotStudio 一模一样；④ 工具、基座、大地三套坐标都要可视化、可点击，轴关节运动、线性运动、重定位都要能仿真；⑤ 颜色改白色；⑥ 六个轴对照真机做标准化。改完情况：
- 坐标改成 ABB 规矩：世界、基座、工具三套坐标架都是 X 红前、Y 绿左、Z 蓝上（以前是 Three.js 的 Y 朝上），末端读数按 ABB 坐标出（回零位 X 0.399、Y -0.107、Z 0.678 米）；三套坐标架各有开关按钮，点一下显隐；点动坐标系可以在世界、基座、工具之间切。
- 颜色改成 ABB 白色机身 + 深灰关节（IRB 120 就是白色）。
- 六个轴按 ABB IRB 120 手册标准化：J1 ±165° 旋转、J2 ±110° 大臂、J3 -110°~+70° 小臂、J4 ±160° 腕部旋转、J5 ±120° 腕部弯曲、J6 ±400° 法兰旋转；滑块旁边直接标运动类型；每个关节加黄色轴线 + J1~J6 标签，开关控制。回零位取了最接近截图的手册值（J1 165°、J3 70°）：截图的 J1 170°、J3 90° 超了 IRB 120 的范围（前臂在真机上弯不到水平），所以回零位前臂是 70°、没截图那么平，但还是弯着的。
- 线性运动：X/Y/Z 点动按钮，每点一下末端沿当前坐标系的轴走 20mm，背后是 CCD 逆解；重定位：输世界坐标，末端直线移过去，背后是 CCD + DLS（阻尼最小二乘）两套逆解。直线走不通时（比如要换肘部姿势），自动改走关节直达：换几个种子姿势再逆解，成了就插值转过去。
- 验证（headless Chromium，0 报错）：X+ 点动 X +0.021 米、Z+ 点动 Z +0.020 米、Y+ 点动 Y +0.020 米；重定位到 (0.30, 0, 0.60) 分毫不差（0.300, 0, 0.600）；够不着的点（X 2.0 米）报“够不着”，姿势不动。逆解在 node 里也用真 three.js 复算过：40 个随机起点里 26 个能到 (0.30, -0.08, 0.60)，说明那个点要换肘部姿势才到得了，本地逆解够不着是真的到不了，不是算错了。
