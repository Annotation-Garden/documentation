# Code Style

AGI projects follow consistent code style guidelines to maintain readability and quality.

## Python

### Formatting

We use **Ruff** for both linting and formatting:

```bash
# Format
ruff format .

# Lint
ruff check .

# Lint and fix
ruff check --fix .
```

### Configuration

All projects use similar `pyproject.toml` configuration:

```toml
[tool.ruff]
line-length = 100
target-version = "py312"

[tool.ruff.lint]
select = [
    "E",   # pycodestyle errors
    "W",   # pycodestyle warnings
    "F",   # pyflakes
    "I",   # isort
    "B",   # flake8-bugbear
    "C4",  # flake8-comprehensions
    "UP",  # pyupgrade
]
ignore = ["E501"]  # line too long (handled by formatter)

[tool.ruff.format]
quote-style = "double"
indent-style = "space"
```

### Style Guidelines

#### Imports

```python
# Standard library
import json
from pathlib import Path

# Third-party
import httpx
from pydantic import BaseModel

# Local
from src.utils import helpers
```

#### Type Hints

Always use type hints for function signatures:

```python
def process_annotation(
    description: str,
    schema_version: str = "8.3.0",
    max_attempts: int = 5,
) -> dict[str, Any]:
    """Process a natural language description into HED annotation."""
    ...
```

#### Docstrings

Use Google-style docstrings:

```python
def validate_hed(hed_string: str, schema_version: str = "8.3.0") -> ValidationResult:
    """Validate a HED annotation string.

    Args:
        hed_string: The HED annotation to validate.
        schema_version: HED schema version to use for validation.

    Returns:
        ValidationResult containing validation status and any errors.

    Raises:
        SchemaLoadError: If the schema version cannot be loaded.
        ValidationError: If the HED string is malformed.
    """
    ...
```

#### Classes

```python
class AnnotationWorkflow:
    """Multi-agent workflow for HED annotation generation.

    This class orchestrates the annotation, validation, and refinement
    process using multiple LLM agents.

    Attributes:
        llm: The language model for annotation generation.
        validator: HED string validator instance.
        max_attempts: Maximum validation retry attempts.
    """

    def __init__(
        self,
        llm: BaseChatModel,
        validator: HedValidator,
        max_attempts: int = 5,
    ) -> None:
        self.llm = llm
        self.validator = validator
        self.max_attempts = max_attempts
```

### Anti-Patterns

**Don't:**

```python
# Bad: No type hints
def process(data):
    return data

# Bad: Unclear variable names
x = get_data()
y = process(x)

# Bad: Magic numbers
if attempts > 5:
    break

# Bad: Long functions without documentation
def do_everything(a, b, c, d, e, f):
    # 200 lines of code...
```

**Do:**

```python
# Good: Type hints and clear names
def process_annotation(annotation_data: dict[str, Any]) -> ProcessedAnnotation:
    return ProcessedAnnotation.from_dict(annotation_data)

# Good: Clear variable names
raw_annotation = get_annotation_data()
processed_annotation = process_annotation(raw_annotation)

# Good: Named constants
MAX_VALIDATION_ATTEMPTS = 5
if attempts > MAX_VALIDATION_ATTEMPTS:
    break

# Good: Small, documented functions
def validate_annotation(
    annotation: str,
    schema_version: str,
) -> ValidationResult:
    """Validate a single HED annotation."""
    ...
```

## TypeScript/JavaScript

### Formatting

Use **ESLint** and **Prettier**:

```bash
npm run lint
npm run format
```

### Style Guidelines

```typescript
// Use interfaces for object types
interface AnnotationResult {
  annotation: string;
  isValid: boolean;
  errors: string[];
}

// Use async/await over promises
async function fetchAnnotation(description: string): Promise<AnnotationResult> {
  const response = await fetch('/api/annotate', {
    method: 'POST',
    body: JSON.stringify({ description }),
  });
  return response.json();
}

// Destructure props in React components
function AnnotationCard({ annotation, isValid }: AnnotationResult) {
  return (
    <div className={isValid ? 'valid' : 'invalid'}>
      {annotation}
    </div>
  );
}
```

## Git Commit Messages

### Format

```
<type>: <subject>

<body>

<footer>
```

### Types

| Type | Description |
|------|-------------|
| `feat` | New feature |
| `fix` | Bug fix |
| `docs` | Documentation |
| `style` | Formatting (no code change) |
| `refactor` | Code refactoring |
| `test` | Adding tests |
| `chore` | Maintenance tasks |

### Examples

```
feat: add batch annotation endpoint

Add /annotate/batch endpoint for processing multiple descriptions
in a single request. Includes progress tracking via SSE.

Closes #123
```

```
fix: handle empty HED strings in validation

Previously, empty strings caused a crash in the validator.
Now returns a proper validation error.
```

### Don't

- Use emojis
- Mention AI/Claude
- Write vague messages ("fix bug", "update code")
- Include unrelated changes

## Testing

### Test File Naming

```
tests/
├── test_validation.py      # Unit tests for validation
├── test_api.py             # API endpoint tests
├── test_integration.py     # Integration tests
└── conftest.py             # Fixtures
```

### Test Structure

```python
class TestHedValidation:
    """Tests for HED string validation."""

    def test_valid_simple_string(self, validator: HedValidator) -> None:
        """Test validation of a simple valid HED string."""
        result = validator.validate("Sensory-event")
        assert result.is_valid
        assert not result.errors

    def test_invalid_tag(self, validator: HedValidator) -> None:
        """Test that invalid tags are caught."""
        result = validator.validate("Invalid-tag-xyz")
        assert not result.is_valid
        assert "TAG_INVALID" in str(result.errors)
```

### No Mocks

AGI projects avoid mock tests. Use real API calls with test keys:

```python
# Good: Real API call
@pytest.mark.integration
def test_annotation_api(api_client: httpx.Client) -> None:
    response = api_client.post("/annotate", json={"description": "test"})
    assert response.status_code == 200

# Bad: Mocked response
def test_annotation_api_mocked(mocker) -> None:
    mocker.patch("httpx.post", return_value=Mock(status_code=200))
    # This doesn't test real behavior
```

## Documentation

### Markdown

- Use ATX-style headers (`#`)
- Use fenced code blocks with language
- Include alt text for images
- Keep lines under 100 characters

### API Documentation

Document all public APIs with:

- Description
- Parameters (types, defaults, constraints)
- Return values
- Examples
- Error conditions
