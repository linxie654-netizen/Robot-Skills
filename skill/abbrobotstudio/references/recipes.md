# C# 片段（配合 /exec 使用）

每段都是 `Func<object>` 的函数体，用 `return new { ... };` 返回结果。默认已 using `ABB.Robotics.RobotStudio`、`.Stations`、`.Environment`、`.Math`。

## 查看当前站与组件

```csharp
var st = Station.ActiveStation;
if (st == null) return new { error = "no active station" };
var comps = new System.Collections.Generic.List<string>();
foreach (ProjectObject c in st.GraphicComponents) comps.Add(c.Name + " (" + c.GetType().Name + ")");
return new { station = st.Name, dirty = st.IsDirty, components = comps, controllers = st.Irc5Controllers.Count };
```

## 新建并替换当前站（会关闭旧站，未保存则拒绝）

已由 `/station/new` 端点提供；若需更细控制：

```csharp
var current = Station.ActiveStation;
if (current != null) { if (current.IsDirty) return new { error = "dirty station" }; current.Close(); }
var st = new Station();
st.Name = "MyStation";
st.SaveAs(@"D:\RobotStudioProjects\MyStation\MyStation.rsstn");
return new { active = Station.ActiveStation == null ? "(none)" : Station.ActiveStation.Name };
```

## 列出 Smart 组件的信号与属性

```csharp
var st = Station.ActiveStation;
SmartComponent sc = null;
foreach (ProjectObject c in st.GraphicComponents) if (c is SmartComponent) { sc = (SmartComponent)c; break; }
if (sc == null) return new { error = "no SmartComponent" };
var sigs = new System.Collections.Generic.List<string>();
foreach (IOSignal s in sc.IOSignals) sigs.Add(s.Name + " | " + s.SignalType + " | input=" + s.IsInput + " | value=" + s.Value);
return new { component = sc.Name, properties = sc.Properties.Count, signals = sigs, connections = sc.Connections.Count };
```

## 连线两个信号

```csharp
var st = Station.ActiveStation;
var comps = new System.Collections.Generic.List<SmartComponent>();
foreach (ProjectObject c in st.GraphicComponents) if (c is SmartComponent) comps.Add((SmartComponent)c);
if (comps.Count < 2) return new { error = "need 2 SmartComponents" };
st.Connections.Add(new IOConnection(comps[0], "Executed", comps[1], "Execute"));
return new { connections = st.Connections.Count };
```

## 建站点信号并连线，仿真中触发

```csharp
var st = Station.ActiveStation;
IOSignal src = null, dst = null;
foreach (IOSignal s in st.IOSignals) { if (s.Name == "Demo_Out") src = s; if (s.Name == "Demo_In") dst = s; }
if (src == null) { src = new IOSignal("Demo_Out", IOSignalType.DigitalOutput); st.IOSignals.Add(src); }
if (dst == null) { dst = new IOSignal("Demo_In", IOSignalType.DigitalInput); st.IOSignals.Add(dst); }
st.Connections.Add(new IOConnection(st, "Demo_Out", st, "Demo_In"));
var r = src.TrySetValue(true);
System.Threading.Thread.Sleep(1500);
return new { write = "" + r, out = src.Value, inn = dst.Value };
```

注意：信号写值只在仿真运行中生效；先 `POST /simulation/start`。

## 查找可用库文件

```csharp
var root = @"D:\Program Files (x86)\ABB Industrial IT\Robotics IT\RobotStudio 6.08\ABB Library";
var robots = System.IO.Directory.GetFiles(root + @"\Robots", "IRB2600*.rslib");
var comps = System.IO.Directory.GetFiles(root + @"\Components", "Attacher.rslib");
return new { robots, comps };
```
