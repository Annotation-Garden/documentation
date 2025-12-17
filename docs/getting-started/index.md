# Getting Started

Welcome to the Annotation Garden Initiative (AGI). This guide will help you get started with our tools for collaborative neuroscience stimulus annotation.

## Why AGI?

### The Annotation Gap Problem

Naturalistic stimuli datasets (movies, complex images, audio) contain rich, multi-dimensional information ideal for neuroscience research. However, these datasets typically arrive with **minimal or no annotation**, despite having diverse dimensions suitable for analysis.

This creates a fundamental barrier: while methodologies like hyperalignment and functional connectivity can operate without annotations, **most analytical approaches (GLM-based analytics, encoding models) rely heavily on them**.

The result? Despite the wealth of neural data collected with naturalistic stimuli, **researchers often default to resting-state paradigms** simply because the annotation burden is too high.

### A New Science Paradigm

AGI represents a paradigm shift: instead of each lab independently annotating the same stimuli, we build **shared, versioned, community-curated annotation layers**.

Rich annotations unlock:

- **Novel analytics** on complex neural data
- **Cross-study comparisons** using common stimuli
- **FAIR-compliant datasets** ready for re-analysis
- **Reduced barrier to entry** for naturalistic neuroscience

Projects like [StudyForrest](https://studyforrest.org) and [Neuroscout](https://github.com/neuroscout/neuroscout) have demonstrated the value of rich annotations; AGI provides the infrastructure to scale this approach.

## Quick Start Paths

Choose your path based on what you want to do:

<div class="grid cards" markdown>

-   :material-tag-text:{ .lg .middle } **Generate HED Annotations**

    ---

    Use HEDit to convert natural language descriptions into valid HED annotations.

    [:octicons-arrow-right-24: HEDit Quick Start](#hedit-quick-start)

-   :material-image-multiple:{ .lg .middle } **Annotate Images**

    ---

    Use VLMs to automatically annotate neuroscience stimulus images.

    [:octicons-arrow-right-24: Image Annotation Quick Start](#image-annotation-quick-start)

-   :material-file-document:{ .lg .middle } **Understand Standards**

    ---

    Learn about HED, BIDS, and Stim-BIDS integration.

    [:octicons-arrow-right-24: Standards Overview](../standards/index.md)

-   :material-source-pull:{ .lg .middle } **Contribute Annotations**

    ---

    Add your annotations to shared stimulus repositories.

    [:octicons-arrow-right-24: Contributing Guide](../contributing/index.md)

</div>

## HEDit Quick Start

### 1. Install HEDit

```bash
pip install hedit
```

### 2. Get an API Key

HEDit uses [OpenRouter](https://openrouter.ai/keys) for LLM access. Get your API key and initialize:

```bash
hedit init --api-key YOUR_OPENROUTER_KEY
```

### 3. Generate Annotations

```bash
# From text description
hedit annotate "A red circle appears on the left side of the screen"

# From an image
hedit annotate-image stimulus.png

# Validate existing HED
hedit validate "Sensory-event, Visual-presentation"
```

### 4. Use the API

```python
import httpx

response = httpx.post(
    "https://api.annotation.garden/hedit/annotate",
    json={"description": "A face image is shown for 500ms"},
    headers={"X-OpenRouter-Key": "your-key"}
)
print(response.json()["annotation"])
```

## Image Annotation Quick Start

### 1. Clone the Repository

```bash
git clone https://github.com/Annotation-Garden/image-annotation
cd image-annotation
```

### 2. Set Up Environment

```bash
conda activate torch-312  # or create new env
pip install -e .
```

### 3. Run the Service

```bash
python -m image_annotation.api
```

### 4. View Dashboard

```bash
cd frontend
npm install
npm run dev
```

Visit `http://localhost:3000` to browse annotations.

## Next Steps

- [Installation Guide](installation.md): Detailed setup instructions
- [HEDit Documentation](../projects/hedit/index.md): Full HEDit reference
- [Standards](../standards/index.md): Learn about HED and BIDS
- [Contributing](../contributing/index.md): Add your annotations
