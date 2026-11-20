# 从已有布局创建单机器人系统 + 配 I/O（草稿）

来源：C5 cnctrain《Creating Single Robot System in ABB Robotstudio》（2024-04-04，文章与视频链接已核实：https://www.youtube.com/watch?v=TDjzO5AMOmk；时长未核实）。
状态：待在 RobotStudio 6.08 里照做一遍、跑通后再进正式文件。

## 1. 机器人系统是什么

- 一台独立机器人 + 自己的控制器 + 自己的 I/O 系统，配好、能编程。
- 本教程用 IRC5 控制器。

## 2. 三种加系统的方法（Home → Robot System）

1. 基于已有布局创建系统（视频演示的就是这种：布局里 IRC5 已经加好了）。
2. 创建新系统并加到工作站。
3. 加一个已有的系统到工作站。

新手先学第 1 种：布局现成，系统跟着布局走，最不容易配错。

## 3. 加完系统再配 I/O

- Controller 标签页 → Configuration Editor。
- 在这里看和改系统参数：Communication（通信）、I/O System（I/O 系统）。
- 配完 I/O，信号才能在程序里用（`SetDO` / `WaitDI` 用的就是这里配出来的信号名）。

## 4. 对应库里

- `docs/full-pipeline.md`：0 到 1 全流程（从头建系统）。
- 本草稿补的是“从已有布局建”这条路 + 建完后去 Configuration Editor 配 I/O 这一步，库里原来没单独写。

## 5. 容易错

- 布局里没加控制器就建系统：先确认 IRC5 已经在布局里。
- 配完 I/O 不检查信号名：程序里写错一个字母就找不到信号，先在 Configuration Editor 里核对名字再写程序。
