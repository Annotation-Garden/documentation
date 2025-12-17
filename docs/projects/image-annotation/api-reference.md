# Image Annotation API Reference

API documentation for the Image Annotation service.

## Overview

The Image Annotation API provides endpoints for annotating images using Vision-Language Models (VLMs).

!!! note "Work in Progress"
    This API is under active development. See the [GitHub repository](https://github.com/Annotation-Garden/image-annotation) for the latest updates.

## REST API Endpoints

### POST `/api/annotate`

Annotate an image using a VLM.

**Request:**

```json
{
  "image_path": "path/to/image.png",
  "model": "gpt-4-vision",
  "prompt": "Describe this image for HED annotation"
}
```

**Response:**

```json
{
  "description": "A person riding a bicycle...",
  "objects": ["person", "bicycle", "street"],
  "hed_annotation": "Sensory-event, Visual-presentation, ..."
}
```

### GET `/api/annotations/{image_id}`

Retrieve stored annotations for an image.

### GET `/api/models`

List available VLM models.

## Services

### VLM Service

The VLM service handles communication with vision-language models:

- **Ollama**: Local models via Ollama
- **OpenAI**: GPT-4 Vision
- **Anthropic**: Claude Vision

### Annotation Storage

Annotations are stored in JSON format in the `annotations/` directory.

## Configuration

Environment variables:

| Variable | Description | Default |
|----------|-------------|---------|
| `OPENAI_API_KEY` | OpenAI API key | - |
| `OLLAMA_BASE_URL` | Ollama server URL | `http://localhost:11434` |
| `ANNOTATION_DIR` | Output directory | `./annotations` |

## Python API

```python
from image_annotation.services import VLMService

# Initialize service
service = VLMService(model="gpt-4-vision")

# Annotate image
result = await service.annotate("path/to/image.png")
print(result.description)
print(result.hed_annotation)
```

!!! info "Full API Reference"
    Detailed Python API documentation will be auto-generated once the package structure is finalized. See the [source code](https://github.com/Annotation-Garden/image-annotation/tree/main/src) for current implementation.
