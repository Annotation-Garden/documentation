# Image Annotation

VLM-based annotation tool for neuroscience image datasets, with support for multiple vision-language models.

## Overview

The Image Annotation tool enables automated annotation of neuroscience stimulus images using Vision-Language Models (VLMs). It is designed to work with datasets like the Natural Scenes Dataset (NSD) and integrates with HED annotation workflows.

## Features

- **Multi-model support**: Ollama, OpenAI, Anthropic, and more via LangChain
- **Batch processing**: Annotate thousands of images efficiently
- **HED integration**: Generate HED-compatible annotations
- **Web dashboard**: View and manage annotations
- **JSON schema output**: Structured annotation format

## Installation

```bash
git clone https://github.com/Annotation-Garden/image-annotation
cd image-annotation
pip install -e .
```

## Quick Start

### Running the Service

```bash
# Activate environment
conda activate torch-312

# Run the annotation service
python -m image_annotation.api

# Or use uvicorn directly
uvicorn image_annotation.api:app --host 0.0.0.0 --port 8000
```

### Frontend Dashboard

```bash
cd frontend
npm install
npm run dev
```

Visit `http://localhost:3000` to view the annotation dashboard.

## Dataset: NSD Shared 1000

The tool includes pre-computed annotations for the NSD Shared 1000 images:

- **73,000 COCO images** in full NSD dataset
- **1,000 shared images** used across all subjects
- **Multi-model annotations** from various VLMs

## Annotation Format

Annotations are stored as JSON files:

```json
{
  "image_id": "nsd_00001",
  "annotations": {
    "description": "A person riding a bicycle on a city street",
    "objects": ["person", "bicycle", "street", "buildings"],
    "scene": "urban outdoor",
    "hed_annotation": "Sensory-event, Visual-presentation, (Human, Action/Ride, Vehicle/Bicycle)"
  },
  "model": "gpt-4-vision",
  "timestamp": "2024-12-15T10:30:00Z"
}
```

## Architecture

```
image-annotation/
├── src/image_annotation/
│   ├── api/              # FastAPI backend
│   ├── services/         # VLM service integrations
│   └── models/           # Pydantic models
├── frontend/             # Next.js dashboard
├── annotations/          # Generated annotations
└── scripts/              # Processing utilities
```

## Links

- **Repository**: [github.com/Annotation-Garden/image-annotation](https://github.com/Annotation-Garden/image-annotation)
- **Dashboard**: [neuromechanist.github.io/image-annotation](https://neuromechanist.github.io/image-annotation)
