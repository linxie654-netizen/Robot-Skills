# 检查体系

一键跑全部五项：`bash checks/run-all.sh`（退出码 0=全过，1=有不过的项）。

| 脚本 | 查什么 | 失败算什么 |
|---|---|---|
| `check_rapid.py` | 所有 `.mod`：PROC/FUNC/TRAP/MODULE 配对、禁词（见脚本内 BANNED 表）；项目 `.mod` 还查 tooldata/wobjdata 必填段 | 配不上、缺必填段、有禁词 |
| `check_docs.py` | 公开的 `.md` / `.mod` / `.html`（含 learning-log.md）：README 标语、禁词（见脚本内 BANNED、SOFT_BANNED 表）、七个项目 README 六节齐不齐；没标“教学值”的断言味表述只列出来，不算失败 | 标语缺、**公开文件**有禁词、缺章节；本地专用文件里的禁词列为“旧账” |
| `check_deps.py` | requirements.txt 包名版本、vendor 里有没有 abb-motion-program-exec、README 的 Node 要求对本机 node、安装命令对不对 | 文件缺、包找不到、版本不够、命令对不上；没钉版本只记 WARN |
| `check_install.sh` | 跑 `npx skills add linxie654-netizen/Robot-Skills --skill robot-rapid -a claude-code -g -y`，验装到的 SKILL.md 存在、行数、关键内容 | 装不下来、文件不存在、缺 Robot-RAPID/验证环节 |
| `check_safety.py` | 每个项目 README：安全检查一节、确认提醒；全文不许出现真实设备相关字样，安全检查只查仿真项 | 缺节、缺确认提醒、出现真实设备相关字样 |

注意：`check_install.sh` 只报本地与已装副本的行数，不拿行数相等当通过条件（本地改动还没上传时两边行数本来就不一样）。
