# HEDit API Reference

The HEDit API provides REST endpoints for HED annotation generation and validation.

**Base URL:** `https://api.annotation.garden/hedit`

## Authentication

HEDit supports two authentication modes:

=== "BYOK (Bring Your Own Key)"

    Use your own OpenRouter API key for billing control:

    ```bash
    curl -X POST https://api.annotation.garden/hedit/annotate \
      -H "Content-Type: application/json" \
      -H "X-OpenRouter-Key: your-openrouter-key" \
      -d '{"description": "A red circle appears"}'
    ```

=== "Server API Key"

    Use a server-provided API key:

    ```bash
    curl -X POST https://api.annotation.garden/hedit/annotate \
      -H "Content-Type: application/json" \
      -H "X-API-Key: your-server-key" \
      -d '{"description": "A red circle appears"}'
    ```

## Endpoints

### POST `/annotate`

Generate HED annotation from natural language description.

**Request Body:**

::: src.api.models.AnnotationRequest
    options:
      show_root_heading: false
      members: []

| Field | Type | Required | Default | Description |
|-------|------|----------|---------|-------------|
| `description` | string | Yes | - | Natural language event description |
| `schema_version` | string | No | "8.3.0" | HED schema version (8.3.0, 8.4.0) |
| `max_validation_attempts` | integer | No | 5 | Max validation retries (1-10) |
| `run_assessment` | boolean | No | false | Run completeness assessment |

**Response:**

::: src.api.models.AnnotationResponse
    options:
      show_root_heading: false
      members: []

| Field | Type | Description |
|-------|------|-------------|
| `annotation` | string | Generated HED annotation |
| `is_valid` | boolean | Validation status |
| `is_faithful` | boolean | Faithfulness to description |
| `is_complete` | boolean | Completeness status |
| `validation_attempts` | integer | Number of attempts made |
| `validation_errors` | array | List of validation errors |
| `validation_warnings` | array | List of validation warnings |
| `evaluation_feedback` | string | Evaluation agent feedback |
| `assessment_feedback` | string | Assessment agent feedback |
| `status` | string | "success" or "failed" |

**Example:**

```bash
curl -X POST https://api.annotation.garden/hedit/annotate \
  -H "Content-Type: application/json" \
  -H "X-OpenRouter-Key: $OPENROUTER_API_KEY" \
  -d '{
    "description": "A red circle appears on the left side of the screen",
    "schema_version": "8.3.0",
    "max_validation_attempts": 5
  }'
```

```json
{
  "annotation": "Sensory-event, Visual-presentation, (Red, Circle, (Left-side))",
  "is_valid": true,
  "is_faithful": true,
  "is_complete": true,
  "validation_attempts": 1,
  "validation_errors": [],
  "validation_warnings": [],
  "evaluation_feedback": "Annotation captures key visual elements...",
  "assessment_feedback": "",
  "status": "success"
}
```

---

### POST `/annotate-from-image`

Generate HED annotation from an image.

**Request Body:**

| Field | Type | Required | Default | Description |
|-------|------|----------|---------|-------------|
| `image` | string | Yes | - | Base64 encoded image or data URI |
| `prompt` | string | No | - | Custom prompt for vision model |
| `schema_version` | string | No | "8.4.0" | HED schema version |
| `max_validation_attempts` | integer | No | 5 | Max validation retries |
| `run_assessment` | boolean | No | false | Run completeness assessment |

**Response:**

| Field | Type | Description |
|-------|------|-------------|
| `image_description` | string | Generated description from vision model |
| `annotation` | string | Generated HED annotation |
| `is_valid` | boolean | Validation status |
| `is_faithful` | boolean | Faithfulness to description |
| `is_complete` | boolean | Completeness status |
| `validation_attempts` | integer | Number of attempts made |
| `validation_errors` | array | List of validation errors |
| `validation_warnings` | array | List of validation warnings |
| `status` | string | "success" or "failed" |
| `image_metadata` | object | Metadata about processed image |

**Example:**

```python
import base64
import httpx

# Load and encode image
with open("stimulus.png", "rb") as f:
    image_b64 = base64.b64encode(f.read()).decode()

response = httpx.post(
    "https://api.annotation.garden/hedit/annotate-from-image",
    json={
        "image": f"data:image/png;base64,{image_b64}",
        "schema_version": "8.4.0"
    },
    headers={"X-OpenRouter-Key": os.environ["OPENROUTER_API_KEY"]}
)
print(response.json())
```

---

### POST `/validate`

Validate an existing HED annotation string.

**Request Body:**

| Field | Type | Required | Default | Description |
|-------|------|----------|---------|-------------|
| `hed_string` | string | Yes | - | HED annotation to validate |
| `schema_version` | string | No | "8.3.0" | HED schema version |

**Response:**

| Field | Type | Description |
|-------|------|-------------|
| `is_valid` | boolean | Validation status |
| `errors` | array | List of validation errors |
| `warnings` | array | List of validation warnings |
| `parsed_string` | string | Normalized HED string (if valid) |

**Example:**

```bash
curl -X POST https://api.annotation.garden/hedit/validate \
  -H "Content-Type: application/json" \
  -H "X-OpenRouter-Key: $OPENROUTER_API_KEY" \
  -d '{"hed_string": "Sensory-event, Visual-presentation"}'
```

---

### POST `/feedback`

Submit user feedback about an annotation. No authentication required.

**Request Body:**

| Field | Type | Required | Description |
|-------|------|----------|-------------|
| `type` | string | No | Feedback type ("text" or "image") |
| `description` | string | No | Original input description |
| `annotation` | string | Yes | Generated HED annotation |
| `is_valid` | boolean | No | Whether annotation was valid |
| `user_comment` | string | No | User's comment about the annotation |

**Response:**

| Field | Type | Description |
|-------|------|-------------|
| `success` | boolean | Whether feedback was saved |
| `feedback_id` | string | Unique identifier |
| `message` | string | Status message |

---

### GET `/health`

Health check endpoint.

**Response:**

| Field | Type | Description |
|-------|------|-------------|
| `status` | string | "healthy" or "degraded" |
| `version` | string | API version |
| `llm_available` | boolean | LLM service status |
| `validator_available` | boolean | Validator service status |

---

### GET `/version`

Get API version information.

**Response:**

```json
{
  "version": "0.6.1-alpha2",
  "commit": "abc123"
}
```

---

### GET `/`

Root endpoint with API information.

**Response:**

```json
{
  "name": "HEDit API",
  "version": "0.6.1-alpha2",
  "description": "Multi-agent system for HED annotation generation",
  "endpoints": {...}
}
```

## Error Responses

All endpoints return standard HTTP error codes:

| Code | Description |
|------|-------------|
| 400 | Bad Request (invalid input) |
| 401 | Unauthorized (missing or invalid API key) |
| 500 | Internal Server Error |
| 503 | Service Unavailable (workflow not initialized) |

Error response format:

```json
{
  "detail": "Error description"
}
```

## Rate Limits

When using BYOK mode, rate limits are determined by your OpenRouter account.

## OpenAPI Specification

The full OpenAPI specification is available at:

- **Swagger UI**: `https://api.annotation.garden/hedit/docs`
- **ReDoc**: `https://api.annotation.garden/hedit/redoc`
- **OpenAPI JSON**: `https://api.annotation.garden/hedit/openapi.json`
