#!/usr/bin/env bash
# 一键跑全部五项检查，输出每项过/不过。
# 用法：bash checks/run-all.sh [--root DIR]
# 退出码：0=五项全过，1=至少一项不过。
set -u
ROOT="${2:-$(cd "$(dirname "$0")/.." && pwd)}"
cd "$ROOT" || exit 1

PASS=0
FAIL=0
FAILED_ITEMS=""

run_item() {
local name="$1"; shift
echo "===== $name ====="
if "$@"; then
echo "PASS"
PASS=$((PASS + 1))
else
echo "FAIL"
FAIL=$((FAIL + 1))
FAILED_ITEMS="$FAILED_ITEMS $name"
fi
echo ""
}

run_item "代码检查" python3 checks/check_rapid.py --root "$ROOT"
run_item "文档检查" python3 checks/check_docs.py --root "$ROOT"
run_item "依赖检查" python3 checks/check_deps.py --root "$ROOT"
run_item "Skill安装测试" bash checks/check_install.sh --root "$ROOT"
run_item "安全检查" python3 checks/check_safety.py --root "$ROOT"

echo "===== 汇总 ====="
echo "通过：$PASS 项，不过：$FAIL 项"
if [ "$FAIL" -gt 0 ]; then
echo "不过的项：$FAILED_ITEMS"
exit 1
fi
echo "五项全过"
exit 0
