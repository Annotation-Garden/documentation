# HEDit CLI Reference

The HEDit CLI provides a command-line interface for generating and validating HED annotations.

## Installation

```bash
pip install hedit
```

## Commands

### `hedit init`

Initialize HEDit CLI with your API key and preferences.

```bash
hedit init [OPTIONS]
```

**Options:**

| Option | Short | Type | Description |
|--------|-------|------|-------------|
| `--api-key` | `-k` | TEXT | OpenRouter API key (prompted if not provided) |
| `--api-url` | | TEXT | API endpoint URL (default: api.annotation.garden/hedit) |
| `--model` | `-m` | TEXT | Default model for annotation |
| `--provider` | | TEXT | Provider preference (e.g., Cerebras for fast inference) |
| `--temperature` | `-t` | FLOAT | LLM temperature (0.0-1.0) |

**Example:**

```bash
hedit init --api-key sk-or-v1-xxx --model openai/gpt-4o-mini
```

---

### `hedit annotate`

Generate HED annotation from a text description.

```bash
hedit annotate DESCRIPTION [OPTIONS]
```

**Arguments:**

| Argument | Type | Description |
|----------|------|-------------|
| `DESCRIPTION` | TEXT | Natural language event description |

**Options:**

| Option | Short | Type | Default | Description |
|--------|-------|------|---------|-------------|
| `--api-key` | `-k` | TEXT | | OpenRouter API key (or use env var) |
| `--api-url` | | TEXT | | API endpoint URL |
| `--model` | `-m` | TEXT | | Model to use |
| `--provider` | | TEXT | | Provider preference |
| `--temperature` | `-t` | FLOAT | | LLM temperature |
| `--schema` | `-s` | TEXT | 8.3.0 | HED schema version |
| `--output` | `-o` | TEXT | text | Output format (text, json) |
| `--max-attempts` | | INT | 5 | Maximum validation attempts |
| `--assessment/--no-assessment` | | BOOL | False | Run completeness assessment |
| `--verbose` | `-v` | BOOL | False | Show detailed output |

**Examples:**

```bash
# Basic usage
hedit annotate "A red circle appears on the left side of the screen"

# With specific schema version
hedit annotate "Participant pressed the spacebar" --schema 8.4.0

# JSON output for piping
hedit annotate "Audio beep plays" -o json > result.json

# With custom model settings
hedit annotate "..." --model gpt-4o-mini --temperature 0.2

# With assessment enabled
hedit annotate "A face image is shown" --assessment -v
```

---

### `hedit annotate-image`

Generate HED annotation from an image file.

```bash
hedit annotate-image IMAGE [OPTIONS]
```

**Arguments:**

| Argument | Type | Description |
|----------|------|-------------|
| `IMAGE` | PATH | Path to image file (PNG, JPG, etc.) |

**Options:**

| Option | Short | Type | Default | Description |
|--------|-------|------|---------|-------------|
| `--prompt` | | TEXT | | Custom prompt for vision model |
| `--api-key` | `-k` | TEXT | | OpenRouter API key |
| `--model` | `-m` | TEXT | | Model to use |
| `--schema` | `-s` | TEXT | 8.4.0 | HED schema version |
| `--output` | `-o` | TEXT | text | Output format |
| `--max-attempts` | | INT | 5 | Maximum validation attempts |
| `--assessment/--no-assessment` | | BOOL | False | Run completeness assessment |
| `--verbose` | `-v` | BOOL | False | Show detailed output |

**Examples:**

```bash
# Basic usage
hedit annotate-image stimulus.png

# With custom vision prompt
hedit annotate-image photo.jpg --prompt "Describe the experimental setup"

# JSON output
hedit annotate-image screen.png -o json > result.json
```

---

### `hedit validate`

Validate an existing HED annotation string.

```bash
hedit validate HED_STRING [OPTIONS]
```

**Arguments:**

| Argument | Type | Description |
|----------|------|-------------|
| `HED_STRING` | TEXT | HED annotation string to validate |

**Options:**

| Option | Short | Type | Default | Description |
|--------|-------|------|---------|-------------|
| `--api-key` | `-k` | TEXT | | OpenRouter API key |
| `--api-url` | | TEXT | | API endpoint URL |
| `--schema` | `-s` | TEXT | 8.3.0 | HED schema version |
| `--output` | `-o` | TEXT | text | Output format |

**Examples:**

```bash
# Validate a simple HED string
hedit validate "Sensory-event, Visual-presentation"

# Validate with specific schema
hedit validate "(Red, Circle)" --schema 8.4.0

# JSON output for parsing
hedit validate "Event" -o json
```

---

### `hedit config`

Manage CLI configuration.

#### `hedit config show`

Show current configuration.

```bash
hedit config show [OPTIONS]
```

**Options:**

| Option | Type | Description |
|--------|------|-------------|
| `--show-key` | BOOL | Show full API key (default: masked) |

#### `hedit config set`

Set a configuration value.

```bash
hedit config set KEY VALUE
```

**Examples:**

```bash
hedit config set models.default gpt-4o
hedit config set settings.temperature 0.2
hedit config set api.url https://api.example.com/hedit
```

#### `hedit config path`

Show configuration file paths.

```bash
hedit config path
```

#### `hedit config clear-credentials`

Remove stored API credentials.

```bash
hedit config clear-credentials [--force]
```

---

### `hedit health`

Check API health status.

```bash
hedit health [OPTIONS]
```

**Options:**

| Option | Type | Description |
|--------|------|-------------|
| `--api-url` | TEXT | API endpoint URL |

---

### `hedit --version`

Show version and exit.

```bash
hedit --version
```

## Configuration

HEDit stores configuration in `~/.config/hedit/`:

- `config.yaml`: General settings (models, temperature, API URL)
- `credentials.yaml`: API keys (stored securely)

### Environment Variables

| Variable | Description |
|----------|-------------|
| `OPENROUTER_API_KEY` | Default OpenRouter API key |

## Exit Codes

| Code | Description |
|------|-------------|
| 0 | Success |
| 1 | Error (validation failed, API error, etc.) |

## Output Formats

### Text (default)

Human-readable output with colors and formatting.

### JSON

Machine-readable output for scripting:

```json
{
  "annotation": "Sensory-event, Visual-presentation, (Red, Circle, (Left-side))",
  "is_valid": true,
  "is_faithful": true,
  "is_complete": true,
  "validation_attempts": 1,
  "validation_errors": [],
  "validation_warnings": [],
  "status": "success"
}
```
