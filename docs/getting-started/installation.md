# Installation

This guide covers installation for all AGI projects.

## Prerequisites

- **Python 3.11+** (3.12 recommended)
- **Node.js 18+** (for frontends)
- **conda** or **uv** for environment management
- **Git** for version control

## HEDit

### From PyPI (Recommended)

```bash
pip install hedit
```

### From Source

```bash
# Clone the repository
git clone https://github.com/Annotation-Garden/hedit
cd hedit

# Create environment
conda create -n hedit python=3.12
conda activate hedit

# Install in development mode
pip install -e ".[dev]"

# Or with uv
uv sync
```

### Verify Installation

```bash
hedit --version
hedit health
```

### API Key Setup

HEDit requires an [OpenRouter API key](https://openrouter.ai/keys):

```bash
hedit init --api-key YOUR_API_KEY
```

Or set the environment variable:

```bash
export OPENROUTER_API_KEY=your-key
```

## Image Annotation

### Clone and Install

```bash
# Clone the repository
git clone https://github.com/Annotation-Garden/image-annotation
cd image-annotation

# Create environment
conda create -n torch-312 python=3.12
conda activate torch-312

# Install
pip install -e ".[dev]"
```

### Frontend Setup

```bash
cd frontend
npm install
```

### Run Services

```bash
# Backend (from project root)
python -m image_annotation.api

# Frontend (from frontend/)
npm run dev
```

## Environment Configuration

Both projects support environment variables for configuration. Create a `.env` file:

=== "HEDit"

    ```bash
    # .env
    OPENROUTER_API_KEY=your-key
    LLM_PROVIDER=openrouter
    LLM_TEMPERATURE=0.1
    HED_SCHEMA_VERSION=8.3.0
    ```

=== "Image Annotation"

    ```bash
    # .env
    OPENAI_API_KEY=your-key
    OLLAMA_BASE_URL=http://localhost:11434
    DATABASE_URL=sqlite:///./annotations.db
    ```

## Docker

Both projects support Docker for containerized deployment:

=== "HEDit"

    ```bash
    docker-compose up -d
    ```

=== "Image Annotation"

    ```bash
    docker-compose up -d
    ```

## Development Tools

Both projects use consistent tooling:

| Tool | Purpose | Config File |
|------|---------|-------------|
| **ruff** | Linting & formatting | `pyproject.toml` |
| **pytest** | Testing | `pyproject.toml` |
| **pre-commit** | Git hooks | `.pre-commit-config.yaml` |
| **mypy** | Type checking | `pyproject.toml` |

Install pre-commit hooks:

```bash
pre-commit install
```

## Troubleshooting

### Common Issues

??? question "ModuleNotFoundError: No module named 'hedit'"

    Ensure you've installed the package:
    ```bash
    pip install -e .
    ```

??? question "Connection refused to API"

    Check that the API server is running and the URL is correct:
    ```bash
    hedit health --api-url http://localhost:38427
    ```

??? question "HED validation errors"

    Ensure you're using a supported schema version (8.3.0, 8.4.0).

### Getting Help

- **HEDit Issues**: [GitHub Issues](https://github.com/Annotation-Garden/hedit/issues)
- **Image Annotation Issues**: [GitHub Issues](https://github.com/Annotation-Garden/image-annotation/issues)
