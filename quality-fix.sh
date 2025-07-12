#!/bin/bash
# Quality Tools Auto-Fix Script

echo "🔧✨ Running Quality Tools with Auto-Fix... 🚀"
echo "══════════════════════════════════════════════"
echo

# 1. BLACK - Auto-format
echo "1. 🎨 BLACK (formatting):"
if black --check . > /dev/null 2>&1; then
    echo "   ✅ Already formatted correctly! 🎯"
else
    echo "   🔧 Fixing formatting... 📝"
    black .
    echo "   ✅ Formatting fixed! 🌟"
fi

# 2. RUFF - Auto-fix what's possible
echo "2. 🧹 RUFF (linting):"
BEFORE=$(ruff check . --output-format=github 2>/dev/null | wc -l || echo "0")
if [ $BEFORE -eq 0 ]; then
    echo "   ✅ No issues found! 🎉"
else
    echo "   🔧 Auto-fixing $BEFORE issues... ⚡"
    ruff check . --fix > /dev/null 2>&1 || true
    ruff check . --fix --unsafe-fixes > /dev/null 2>&1 || true
    
    AFTER=$(ruff check . --output-format=github 2>/dev/null | wc -l || echo "0")
    if [ $AFTER -eq 0 ]; then
        echo "   ✅ All issues fixed! 🎊"
    else
        FIXED=$((BEFORE - AFTER))
        echo "   🔧 Fixed $FIXED issues, $AFTER remain (mostly line length) 📏"
        echo "   🎯 Great progress!"
    fi
fi

# 3. MYPY - Check only (cannot auto-fix)
echo "3. 🔍 MYPY (type checking):"
if mypy . --ignore-missing-imports > /dev/null 2>&1; then
    echo "   ✅ No type issues! 🧩"
else
    echo "   ❌ Type issues found (cannot auto-fix) 🐛"
    echo "   💡 Run 'mypy . --ignore-missing-imports' for details"
fi

echo
echo "══════════════════════════════════════════════"
echo "🎉 Auto-fix complete! Run './quality-check.sh' to see final status. 📊"