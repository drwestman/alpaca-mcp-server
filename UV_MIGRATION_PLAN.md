# UV Migration Plan

## Overview
Migrate the Alpaca MCP Server project from pip-based package management to uv for improved performance, dependency resolution, and modern Python packaging standards.

## Current State Analysis
- ✅ Project uses `requirements.txt` with 3 dependencies: alpaca-py, mcp, python-dotenv
- ✅ ApplicationStructure.md already specifies uv as the intended package manager
- ✅ Dockerfile uses pip for installation
- ✅ README.md contains extensive pip-based installation instructions
- ✅ No existing pyproject.toml or setup.py files

## Migration Checklist

### Phase 1: Core Package Configuration
- [x] Create `pyproject.toml` with project metadata and dependencies
- [x] Generate `uv.lock` file for reproducible builds
- [x] Test dependency resolution and installation with uv
- [x] Verify all dependencies work correctly with uv

### Phase 2: Build System Updates ✅ COMPLETED
- [x] Update `Dockerfile` to use uv instead of pip
- [x] Test Docker build with uv installation
- [x] Ensure Docker image size and build time improvements
- [x] Verify container functionality with uv-installed dependencies

**Phase 2 Results:**
- **Dockerfile Updates**: Replaced pip with `uv sync --frozen --no-dev --no-install-project`
- **Performance Gains**: 
  - Image size reduced: 518MB → 505MB (13MB smaller)
  - Dependency installation time: ~20.5s → ~2.1s (90% faster)
- **Verification**: Container builds successfully and MCP server starts correctly
- **Date Completed**: 2025-07-12

### Phase 3: Documentation Updates ✅ COMPLETED
- [x] Update README.md installation section (Section 1)
  - [x] Replace `pip install -r requirements.txt` with `uv sync`
  - [x] Update virtual environment creation instructions
  - [x] Add uv installation prerequisites
- [x] Update Claude Desktop configuration examples
- [x] Update Claude Code CLI examples  
- [x] Update VS Code configuration examples
- [x] Update Docker usage documentation

**Phase 3 Results:**
- **README.md Updates**: Comprehensive documentation migration from pip to uv
- **Installation Process**: Simplified from 3 steps to 2 steps (uv sync handles both venv creation and dependency installation)
- **Virtual Environment**: Updated all paths from `/venv/` to `/.venv/` (uv default)
- **Configuration Examples**: Updated all Python executable paths in Claude Desktop, Claude Code, and VS Code configurations
- **Project Structure**: Updated to reflect `pyproject.toml` and `uv.lock` instead of `requirements.txt`
- **Prerequisites**: Added uv installation requirement with documentation link
- **Date Completed**: 2025-07-12

### Phase 4: Configuration File Updates
- [ ] Update `.vscode/mcp.json` examples to use uv
- [ ] Ensure all path references work with uv virtual environments
- [ ] Note: VS Code testing will be done manually by user

### Phase 5: Cleanup and Validation
- [ ] Remove `requirements.txt` file
- [ ] Update `.gitignore` if needed for uv-specific files
- [ ] Test complete installation flow with uv
- [ ] Verify all documented installation methods work
- [ ] Test MCP server functionality after migration

### Phase 6: Testing and Quality Assurance
- [ ] Run linting tools (ruff) to ensure code quality
- [ ] Run type checking (mypy) to verify type correctness
- [ ] Test MCP server startup and basic functionality
- [ ] Verify all environment variable handling works
- [ ] Test both paper and live trading configurations

## Files to Modify

### New Files
- `pyproject.toml` - Project configuration with dependencies
- `uv.lock` - Lock file for reproducible builds (auto-generated)

### Modified Files
- `Dockerfile` - Update pip commands to uv
- `README.md` - Update all installation and setup instructions
- `.vscode/mcp.json` - Update activation commands

### Removed Files
- `requirements.txt` - Replace with pyproject.toml

## Risk Mitigation
- Keep backup of current requirements.txt until migration is verified
- Test all major use cases (Claude Desktop, Docker, CLI)
- Ensure backwards compatibility for existing users
- Document any breaking changes clearly

## Success Criteria
- [ ] All dependencies install correctly with uv
- [ ] MCP server starts and functions properly
- [ ] All documented installation methods work
- [ ] Docker builds successfully and faster than before
- [ ] Documentation is clear and accurate
- [ ] No regression in functionality

## Post-Migration Benefits
- Faster dependency resolution and installation
- Deterministic builds with lock files
- Better dependency conflict resolution
- Modern Python packaging standards compliance
- Improved developer experience
- Smaller Docker images and faster builds