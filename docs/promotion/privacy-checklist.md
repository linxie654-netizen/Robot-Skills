# 发布前隐私检查清单

检查时间：2026-11-22。公开仓库：https://github.com/linxie654-netizen/Robot-Skills ，当前提交 012a240，237 次提交。

核对办法：公开仓库根目录文件列表（GitHub 页面直接看到的）+ 本地 git 跟踪状态 + 此前记录。子目录里的文件没在 GitHub 页面上一个个点开核对，所以下面写“只在本地”的几项，依据是本地记录，不是逐文件点开验证的。

结论先说：**有一件已经公开了，就是 learning-log.md**，在公开仓库根目录里能直接看到，需用户另定处理。其他几项只在本地，没在当前公开内容里出现。

## 1. learning-log.md（提问记录）

- 本地位置：`~/workspace/abb-library/learning-log.md`
- 为什么不能公开：每次提问的记录，是用户本人的学习提问原文和过程，只给自己的 AI 学，不对外。
- 现在的状态：**已在公开仓库，需用户另定处理**。GitHub 根目录文件列表里直接有 `learning-log.md`。另外 README 的“目录”一节里也公开写着这一项，等于公开告诉别人有这个文件。

## 2. rapid/11_palletizing.mod（码垛程序）

- 本地位置：`~/workspace/abb-library/rapid/11_palletizing.mod`
- 为什么不能公开：码垛程序，用户定只留本地，不进公开仓库。
- 现在的状态：**只在本地（当前公开内容里没有）**。本地记录是已从公开仓库删掉。但要注意：提交历史里还有当初上传它的 4 次提交记录，光删文件不等于抹掉历史，要连历史一起抹掉得改写历史，用户还没定。

## 3. skill/python-expert/（对照用的 Python 技能）

- 本地位置：`~/workspace/abb-library/skill/python-expert/`，里面是 `SKILL.md`、`INSTALL.md`、`skill.yaml`、`references/learned.md`、`references/troubleshooting.md`
- 为什么不能公开：用户定 Python 只是辅助，不是主体；这个技能只拿来对照格式、看缺什么，不进仓库，不加新技能。
- 现在的状态：**只在本地**。公开仓库根目录只列了 `skill/robot-rapid`，没有 `skill/python-expert`。

## 4. docs/ 下只留本地的草稿

| 文件 | 本地位置 | 为什么不能公开 | 现在的状态 |
|---|---|---|---|
| youtube-study/ | `~/workspace/abb-library/docs/youtube-study/`（PROGRESS.md + drafts/ 约 30 个草稿） | 学习草稿和进度表，用户定只放本地，不进公开仓库 | 只在本地 |
| promotion.md | `~/workspace/abb-library/docs/promotion.md` | 推广文案草稿，还没定稿就对外发不合适 | 只在本地 |
| palletizing-simulation.md | `~/workspace/abb-library/docs/palletizing-simulation.md` | 码垛仿真草稿，只留本地 | 只在本地 |
| abb-rapid-pack-study.md | `~/workspace/abb-library/docs/abb-rapid-pack-study.md` | RAPID Pack 学习笔记，只留本地 | 只在本地 |
| check-report.md | `~/workspace/abb-library/docs/check-report.md` | 内部检查报告，只留本地 | 只在本地 |
| promotion/ | `~/workspace/abb-library/docs/promotion/`（reddit-x-en.md、video-script-zh.md、zhihu-juejin-zh.md） | 各渠道推广文案草稿，还没发，只留本地 | 只在本地 |
| 其余本地 docs 草稿 | `docs/3d-simulation-research.md`、`docs/advanced-topics.md`、`docs/evals.md`、`docs/exam-practice.md`、`docs/progress-tracker.md`、`docs/threejs-arm-demo.html` | 研究草稿、练习题、进度表，只留本地 | 只在本地 |

另外注意：`docs/promotion.md` 里还有一句“上真机前重新示教”，公开前要改掉，不能带着这句发。

## 5. .claude-plugin 以外的本地配置和本地文件

| 东西 | 本地位置 | 为什么不能公开 | 现在的状态 |
|---|---|---|---|
| .git/ | `~/workspace/abb-library/.git/` | 本地 git 目录，含全部提交历史，包括已删文件的历史记录（上面第 2 项码垛那 4 次提交就在历史里）。`.git` 本身不随文件上传，但以后每次 push 都会把历史带上去 | 只在本地，但历史会跟着 push 走 |
| vendor/ | `~/workspace/abb-library/vendor/` | 拉取的第三方开源参考源，`.gitignore` 已排除，不进仓库 | 只在本地（公开仓库根目录没有 vendor/；`vendor-sources.md` 在公开仓库，只记了来源，不管内容） |
| tools/ | `~/workspace/abb-library/tools/`（check_all.py） | 本地检查脚本，只留本地 | 只在本地（公开仓库根目录没有 tools/） |
| .gitignore | `~/workspace/abb-library/.gitignore` | 不是隐私项，列在这里说明一下：里面只写了 vendor/、__pycache__/、*.pyc，已在公开仓库 | 已在公开仓库，无妨 |

## 上传前必须做的事

1. learning-log.md 已经公开了，用户定一下怎么处理：从仓库删掉、还是改名、还是就这么放着。删文件也不抹历史，历史也要处理的话得另外定。
2. 以后每次上传前，先对着这份清单扫一遍：上面列的东西一个都别带上去。
3. 新加的 `.claude-plugin/marketplace.json` 和这份清单本身，传之前先让用户过目。
