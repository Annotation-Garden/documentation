# Quick Start

Get up and running with AGI tools in minutes.

## Choose Your Tool

=== "HEDit CLI"

    ### 1. Install

    ```bash
    pip install hedit
    ```

    ### 2. Configure

    ```bash
    hedit init --api-key YOUR_OPENROUTER_KEY
    ```

    ### 3. Annotate

    ```bash
    # Text description
    hedit annotate "A red circle appears on the left"

    # From image
    hedit annotate-image stimulus.png

    # Validate HED string
    hedit validate "Sensory-event, Visual-presentation"
    ```

=== "HEDit API"

    ### 1. Get API Key

    Get an [OpenRouter API key](https://openrouter.ai/keys).

    ### 2. Make Request

    ```python
    import httpx

    response = httpx.post(
        "https://api.annotation.garden/hedit/annotate",
        json={"description": "A face image is shown"},
        headers={"X-OpenRouter-Key": "your-key"}
    )

    result = response.json()
    print(f"HED: {result['annotation']}")
    print(f"Valid: {result['is_valid']}")
    ```

    ### 3. Use Result

    ```python
    if result["is_valid"]:
        # Add to your events.tsv
        hed_annotation = result["annotation"]
    else:
        print(f"Errors: {result['validation_errors']}")
    ```

=== "Image Annotation"

    ### 1. Clone

    ```bash
    git clone https://github.com/Annotation-Garden/image-annotation
    cd image-annotation
    ```

    ### 2. Install

    ```bash
    pip install -e .
    cd frontend && npm install
    ```

    ### 3. Run

    ```bash
    # Terminal 1: Backend
    python -m image_annotation.api

    # Terminal 2: Frontend
    cd frontend && npm run dev
    ```

    ### 4. View

    Open http://localhost:3000 to browse annotations.

## Example Workflows

### Annotate a Stimulus Set

```bash
# Create annotations for multiple images
for img in stimuli/*.png; do
    hedit annotate-image "$img" -o json >> annotations.jsonl
done
```

### Batch Validate HED Strings

```python
import json
import httpx

# Read HED strings from file
with open("hed_strings.txt") as f:
    strings = f.readlines()

# Validate each
for hed in strings:
    response = httpx.post(
        "https://api.annotation.garden/hedit/validate",
        json={"hed_string": hed.strip()},
        headers={"X-OpenRouter-Key": "your-key"}
    )
    result = response.json()
    status = "[OK]" if result["is_valid"] else "[ERROR]"
    print(f"{status} {hed.strip()[:50]}...")
```

### Export to BIDS Format

```python
import pandas as pd

# Your annotation results
annotations = [
    {"onset": 0.0, "duration": 0.5, "HED": "Sensory-event, Visual"},
    {"onset": 0.5, "duration": 0.5, "HED": "Agent-action, Press"},
]

# Create events.tsv
df = pd.DataFrame(annotations)
df.to_csv("events.tsv", sep="\t", index=False)
```

## Next Steps

- [Full Installation Guide](installation.md)
- [HEDit CLI Reference](../projects/hedit/cli-reference.md)
- [HEDit API Reference](../projects/hedit/api-reference.md)
- [HED Guidelines](../standards/hed-guidelines.md)
