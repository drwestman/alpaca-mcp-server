FROM python:3.13-slim

WORKDIR /app

# Install uv
COPY --from=ghcr.io/astral-sh/uv:latest /uv /bin/uv

# Copy dependency files first for better Docker layer caching
COPY pyproject.toml uv.lock ./

# Install dependencies with uv (skip building the current package)
RUN uv sync --frozen --no-dev --no-install-project && rm -rf /root/.uv/cache

# Copy README and application code
COPY README.md ./
COPY . .

CMD ["uv", "run", "alpaca_mcp_server.py"]
