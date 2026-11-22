#!/usr/bin/env bash
# Skill 安装测试：跑官方安装命令，验装下来的 SKILL.md。
# 注意：本轮是本地扩充、还没上传，所以装下来的是公开仓库 v2.0.0 的版本
# （SKILL.md 163 行），本地已改成 194 行——行数不一样不算失败，
# 如实报两边的行数就行。失败只算：装不下来、文件不存在、关键内容缺失。
# 用法：bash checks/check_install.sh [--root DIR]
set -u
ROOT="${2:-$(cd "$(dirname "$0")/.." && pwd)}"
INSTALL_DIR="$HOME/.claude/skills/robot-rapid"
LOCAL_SKILL="$ROOT/skill/robot-rapid/SKILL.md"
FAILED=0

echo "跑安装命令：npx skills add linxie654-netizen/Robot-Skills --skill robot-rapid -a claude-code -g -y"
if ! npx skills add linxie654-netizen/Robot-Skills --skill robot-rapid -a claude-code -g -y; then
  echo "FAIL: 安装命令没跑通"
  exit 1
fi

INSTALLED="$INSTALL_DIR/SKILL.md"
if [ ! -f "$INSTALLED" ]; then
  echo "FAIL: 装完找不到 $INSTALLED"
  exit 1
fi

INSTALLED_LINES=$(wc -l < "$INSTALLED")
LOCAL_LINES=$(wc -l < "$LOCAL_SKILL")
echo "装下来的 SKILL.md：$INSTALLED_LINES 行（公开仓库 v2.0.0）"
echo "本地的 SKILL.md：$LOCAL_LINES 行（本轮扩充后）"
if [ "$INSTALLED_LINES" != "$LOCAL_LINES" ]; then
  echo "INFO: 两边行数不一样是预期的——本地还没上传，不算失败"
fi

for KEY in "Robot-RAPID"; do
  if grep -q "$KEY" "$INSTALLED"; then
    echo "  关键内容在：$KEY"
  else
    echo "FAIL: 装下来的 SKILL.md 里找不到“$KEY”"
    FAILED=1
  fi
done
# “验证关口”这个词本地 SKILL.md 用的是“验证闭环”，两个词都认，
# 只要有一个在就算验证环节写了；都没有才算缺。
if grep -q "验证关口" "$INSTALLED"; then
  echo "  关键内容在：验证关口"
elif grep -q "验证闭环" "$INSTALLED"; then
  echo "  WARN: 没写“验证关口”，写的是“验证闭环”（本地 SKILL.md 也是这个词）"
else
  echo "FAIL: 装下来的 SKILL.md 里既没“验证关口”也没“验证闭环”"
  FAILED=1
fi

if [ "$FAILED" = "1" ]; then
  echo "FAIL: Skill 安装测试不过"
  exit 1
fi
echo "PASS: Skill 安装测试通过"
exit 0
