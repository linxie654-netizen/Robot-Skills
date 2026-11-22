# 喷涂课：PaintL、SetBrush、刷子数据（大白话教学）

喷涂是库里一直缺的一块（对比表 11-20 就列了，之前没写）。这一课只讲喷涂程序长什么样、每步干什么，点位是教学值。

依据：ABB《Operating Manual - Painting PowerPac》5.14（文档号见 ABB 官网图书馆，Painting PowerPac 用户手册）——PaintStroke、Brush Specification、SetBrush 的说法和下面代码形状都出自这本手册。刷子数据（brushdata）的具体字段以《Application manual - PaintWare》为准，本课不编字段。

先决条件（缺一个都跑不起来）：喷涂要开 PaintWare 选项，建喷涂工作站（paint controller），普通虚拟控制器跑不了喷涂指令；喷枪、供漆、保护气、工件夹紧按手册接好；人在单元外再起喷。

## 是什么

- **PaintL**：喷涂直线运动，和 MoveL 一个形状（目标点、速度、转弯区、工具、工件），区别是它边走边喷。
- **SetBrush**：换刷子（换喷涂参数），`SetBrush_2` 就是用 2 号刷子；后面能跟 `\X:=`、`\Y:=` 写触发位置的偏移。
- **PaintStroke**：一组 PaintL + SetBrush，从开始喷到停喷算一个喷涂段。
- **Brush Specification（刷子表）**：每个刷子号对应一套参数——刷子宽度、长度、颜色、间距、喷涂距离、TCP 速度。这些参数存在刷子表里，不写在程序里。
- **Gun-On time**：枪开着喷的时间，刷子表里 Material 参数是 0 的刷子号就是停喷。

手册里的真实例子（形状照抄，点位是教学值）：

```rapid
PaintL Paint_10, v2000, z50, tool0\WObj:=wobj0;
SetBrush_2\X:=1650;
PaintL Paint_50, v800, z100, tool0\WObj:=wobj0;
```

## 最小骨架（仿真里照做再验）

```rapid
MODULE SprayDemo
  ! 点位全是教学值，在仿真里重新示教；刷子号按自己刷子表的号改
  CONST robtarget pApproach := [[400, -200, 600], [0, 0.7071, 0, 0.7071], [0, 0, 0, 0], [9E9, 9E9, 9E9, 9E9, 9E9, 9E9]];
  CONST robtarget pStart := [[400, -200, 450], [0, 0.7071, 0, 0.7071], [0, 0, 0, 0], [9E9, 9E9, 9E9, 9E9, 9E9, 9E9]];
  CONST robtarget pEnd := [[400, 200, 450], [0, 0.7071, 0, 0.7071], [0, 0, 0, 0], [9E9, 9E9, 9E9, 9E9, 9E9, 9E9]];

  PROC main()
    ! 1. 空走到喷涂起点上方，不喷
    MoveJ pApproach, v1000, z50, tool0;
    MoveL pStart, v500, z50, tool0;
    ! 2. 换 2 号刷子，开始喷
    SetBrush_2;
    ! 3. 沿工件喷一条直线，喷涂段速度按刷子表来（这里 v800 是例子）
    PaintL pEnd, v800, z100, tool0;
    ! 4. 停喷，抬走
    SetBrush_0;
    MoveL pApproach, v500, z50, tool0;
  ENDPROC
ENDMODULE
```

注意：上面 `SetBrush_0` 是停喷的意思——按手册，停喷靠的是刷子表里 Material 参数为 0 的那个刷子号，这里写 0 号只是例子。有没有 0 号、0 号是不是停喷，以自己刷子表为准，别照抄。

## 常见坑

- **没开 PaintWare 选项就写 PaintL**：控制器不认这个指令，先确认选项开了、喷涂工作站建了。
- **刷子号和刷子表对不上**：程序里写 2 号，刷子表里 2 号是另一个宽度、速度，喷出来全错。改程序先对刷子表。
- **喷涂距离不对**：枪离工件太远漆落不到、太近流挂。距离在刷子表里（Spray Distance），不是程序里调。
- **TCP 速度和刷子速度对不上**：刷子表里每个刷子号有自己的 TCP 速度，程序里 PaintL 的速度要和刷子表一致。
- **PaintC 不会用就别硬用**：走圆弧才用 PaintC（和 MoveC 一个形状，给中间点和终点），直线就用 PaintL。

## 算会

算会：说得出 PaintL、SetBrush、PaintStroke、刷子表各是干什么的；骨架在喷涂工作站的仿真里跑通，喷一段、停喷、抬走，顺序对。
