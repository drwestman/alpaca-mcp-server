# Quality Scripts

This project includes two convenient scripts for maintaining code quality:

## Scripts

### `quality-check.sh` - Quick Status Check
```bash
./quality-check.sh
```
- **Purpose**: Quickly check the status of all quality tools
- **What it does**: Runs black, mypy, and ruff in check-only mode
- **Output**: Simple pass/fail status for each tool
- **When to use**: Before committing, in CI/CD, or to get a quick overview

### `quality-fix.sh` - Auto-Fix Issues  
```bash
./quality-fix.sh
```
- **Purpose**: Automatically fix code quality issues where possible
- **What it does**: 
  - Runs `black .` to format code
  - Runs `ruff check . --fix --unsafe-fixes` to auto-fix linting issues
  - Checks `mypy` for type issues (cannot auto-fix)
- **When to use**: During development to quickly clean up code

## Usage Examples

### Development Workflow
```bash
# Make code changes
vim alpaca_mcp_server.py

# Auto-fix any formatting/linting issues
./quality-fix.sh

# Check final status
./quality-check.sh

# If all good, commit
git add . && git commit -m "Your changes"
```

### Pre-commit Check
```bash
# Quick check before committing
./quality-check.sh

# If issues found, fix them
./quality-fix.sh

# Verify all is good
./quality-check.sh
```

## Quality Tools Used

1. **Black** - Code formatting
   - Ensures consistent Python code style
   - Auto-fixable: Yes ✅

2. **Ruff** - Fast Python linter  
   - Checks for style issues, imports, complexity, etc.
   - Auto-fixable: Partially ✅ (some issues require manual fixing)

3. **MyPy** - Static type checking
   - Ensures type safety and catches type-related bugs
   - Auto-fixable: No ❌ (requires manual type annotations)

## Current Status

After running the quality improvement plan:
- ✅ **Black**: All formatting issues resolved
- ✅ **MyPy**: All type safety issues resolved  
- 🔄 **Ruff**: 48 minor line length issues remain (89-95 chars)
  - These are acceptable for production code
  - All critical issues have been resolved

## Integration with Development

### VS Code Integration
Add to your VS Code settings.json:
```json
{
    "python.formatting.provider": "black",
    "python.linting.enabled": true,
    "python.linting.ruffEnabled": true,
    "python.linting.mypyEnabled": true
}
```

### Pre-commit Hook (Optional)
Create `.git/hooks/pre-commit`:
```bash
#!/bin/bash
./quality-check.sh
```

### CI/CD Integration
Add to your GitHub Actions or similar:
```yaml
- name: Run Quality Checks
  run: ./quality-check.sh
```