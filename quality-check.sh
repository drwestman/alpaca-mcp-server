#!/bin/bash
# Quality Tools Check Script - Check only, no auto-fix

echo "🔍✨ Running Quality Checks... 🛠️"
echo "════════════════════════════════════"
echo

# Black
echo "1. 🎨 BLACK (formatting):"
if black --check . > /dev/null 2>&1; then
    echo "   ✅ PASSED - No formatting issues! 🎉"
else
    echo "   ⚠️  Files need formatting 📝 (run: black .)"
fi

# MyPy  
echo "2. 🔍 MYPY (type checking):"
if mypy . --ignore-missing-imports > /dev/null 2>&1; then
    echo "   ✅ PASSED - No type issues! 🧩"
else
    echo "   ❌ FAILED - Type issues found 🐛"
    echo "   💡 Run 'mypy . --ignore-missing-imports' to see details"
fi

# Ruff
echo "3. 🧹 RUFF (linting):"
RUFF_ERRORS=$(ruff check . --output-format=github 2>/dev/null | wc -l)
if [ $RUFF_ERRORS -eq 0 ]; then
    echo "   ✅ PASSED - No issues! 🌟"
elif [ $RUFF_ERRORS -lt 100 ]; then
    echo "   ⚠️  $RUFF_ERRORS issues found (mostly line length) 📏"
    echo "   💡 Run 'ruff check .' to see details"
else
    echo "   ❌ $RUFF_ERRORS issues found 🚨"
    echo "   💡 Run 'ruff check .' to see details"
fi

echo
echo "════════════════════════════════════"
echo "🚀 To auto-fix issues, run: ./quality-fix.sh"