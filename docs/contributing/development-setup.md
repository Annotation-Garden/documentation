# Development Setup

This guide covers setting up a development environment for AGI projects.

## Prerequisites

- **Python 3.11+** (3.12 recommended)
- **Node.js 18+** (for frontends)
- **Git**
- **conda** or **uv** for Python environment management

## General Setup

### 1. Clone Repository

```bash
# HEDit
git clone https://github.com/Annotation-Garden/hedit
cd hedit

# Or Image Annotation
git clone https://github.com/Annotation-Garden/image-annotation
cd image-annotation
```

### 2. Create Environment

=== "conda"

    ```bash
    conda create -n agi-dev python=3.12
    conda activate agi-dev
    pip install -e ".[dev]"
    ```

=== "uv"

    ```bash
    uv venv
    source .venv/bin/activate
    uv sync
    ```

### 3. Install Pre-commit Hooks

```bash
pre-commit install
```

### 4. Configure Environment

Copy and configure environment file:

```bash
cp .env.example .env
# Edit .env with your API keys
```

## Project-Specific Setup

### HEDit

```bash
cd hedit

# Install dependencies
pip install -e ".[dev]"

# Set up API keys
export OPENROUTER_API_KEY=your-key
export OPENROUTER_API_KEY_FOR_TESTING=your-test-key

# Run tests
pytest tests/ -m "not integration"

# Run with coverage
pytest tests/ --cov=src --cov-report=html

# Run integration tests (requires API key)
pytest tests/ -m integration
```

### Image Annotation

```bash
cd image-annotation

# Install dependencies
pip install -e ".[dev]"

# Install frontend
cd frontend
npm install
cd ..

# Run backend
python -m image_annotation.api

# Run frontend (in separate terminal)
cd frontend && npm run dev
```

## Running Tests

### Unit Tests

```bash
# All unit tests
pytest tests/ -m "not integration"

# Specific test file
pytest tests/test_validation.py

# With verbose output
pytest tests/ -v
```

### Integration Tests

```bash
# Requires API keys
pytest tests/ -m integration

# With coverage
pytest tests/ -m integration --cov=src
```

### Coverage

```bash
# Generate HTML report
pytest tests/ --cov=src --cov-report=html

# View report
open htmlcov/index.html
```

## Code Quality

### Linting

```bash
# Check
ruff check .

# Fix automatically
ruff check --fix .

# With unsafe fixes
ruff check --fix --unsafe-fixes .
```

### Formatting

```bash
ruff format .
```

### Type Checking

```bash
mypy src/
```

### Pre-commit

```bash
# Run on staged files
pre-commit run

# Run on all files
pre-commit run --all-files
```

## API Development

### Running the API Server

```bash
# HEDit
python -m src.api.main
# or
uvicorn src.api.main:app --reload --port 38427

# Image Annotation
python -m image_annotation.api
```

### API Documentation

Once running, visit:

- Swagger UI: `http://localhost:38427/docs`
- ReDoc: `http://localhost:38427/redoc`
- OpenAPI JSON: `http://localhost:38427/openapi.json`

## Frontend Development

### HEDit Frontend

```bash
cd frontend
npm install
npm run dev
```

### Image Annotation Frontend

```bash
cd frontend
npm install
npm run dev
```

## Docker Development

### Build

```bash
docker-compose build
```

### Run

```bash
docker-compose up -d
```

### Logs

```bash
docker-compose logs -f
```

## Debugging

### VS Code

Add to `.vscode/launch.json`:

```json
{
  "version": "0.2.0",
  "configurations": [
    {
      "name": "Python: API",
      "type": "python",
      "request": "launch",
      "module": "uvicorn",
      "args": ["src.api.main:app", "--reload", "--port", "38427"],
      "env": {
        "PYTHONPATH": "${workspaceFolder}"
      }
    },
    {
      "name": "Python: CLI",
      "type": "python",
      "request": "launch",
      "module": "src.cli.main",
      "args": ["annotate", "test description"]
    }
  ]
}
```

### PyCharm

1. Create Run Configuration
2. Set module: `src.api.main`
3. Set parameters: `--reload --port 38427`
4. Set environment variables

## Troubleshooting

??? question "Import errors after installation"

    Ensure you're in the correct environment:
    ```bash
    conda activate agi-dev
    pip install -e .
    ```

??? question "Pre-commit hooks failing"

    Run the hooks manually to see details:
    ```bash
    pre-commit run --all-files -v
    ```

??? question "API connection refused"

    Check the server is running on the correct port:
    ```bash
    lsof -i :38427
    ```

??? question "Tests failing with API errors"

    Ensure API keys are set:
    ```bash
    echo $OPENROUTER_API_KEY
    ```
