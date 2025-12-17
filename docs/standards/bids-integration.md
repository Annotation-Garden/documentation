# BIDS Integration

AGI annotations integrate with the Brain Imaging Data Structure (BIDS) through standardized event files and the Stim-BIDS extension.

## Overview

BIDS organizes neuroimaging data in a consistent directory structure with standardized metadata. AGI annotations fit into BIDS through:

1. **events.tsv**: Tabular event timing and HED annotations
2. **events.json**: Column definitions and HED schema reference
3. **stimuli/**: Stimulus files (or pointers to external sources)

## Event Files

### events.tsv

The core annotation file containing event timing and HED:

```tsv
onset	duration	trial_type	HED
0.0	0.5	face	Sensory-event, Visual-presentation, (Image, Face)
0.5	0.0	response	Agent-action, Press, (Item-physical/Button)
1.0	0.5	scene	Sensory-event, Visual-presentation, (Image, Scene, Outdoor)
```

Required columns:

| Column | Description |
|--------|-------------|
| `onset` | Event start time (seconds from run start) |
| `duration` | Event duration (seconds, 0 for instantaneous) |

Recommended columns:

| Column | Description |
|--------|-------------|
| `trial_type` | Event category/condition |
| `HED` | HED annotation string |
| `stim_file` | Path to stimulus file |
| `response_time` | RT for response events |

### events.json

Sidecar file with column definitions:

```json
{
  "onset": {
    "Description": "Event onset time relative to run start"
  },
  "duration": {
    "Description": "Event duration"
  },
  "trial_type": {
    "Description": "Event category",
    "Levels": {
      "face": "Face image presentation",
      "scene": "Scene image presentation",
      "response": "Participant button press"
    }
  },
  "HED": {
    "Description": "HED annotation for the event"
  }
}
```

## Stim-BIDS (BEP044)

Stim-BIDS is a BIDS extension for organizing stimulus files and their annotations.

### Structure

```
dataset/
├── stimuli/
│   ├── images/
│   │   ├── face_001.png
│   │   └── scene_001.png
│   └── annotations/
│       ├── visual-features/
│       │   ├── annotations.tsv
│       │   └── annotations.json
│       └── hed-tags/
│           ├── annotations.tsv
│           └── annotations.json
├── sub-01/
│   └── func/
│       ├── sub-01_task-viewing_events.tsv
│       └── sub-01_task-viewing_events.json
└── dataset_description.json
```

### Annotation Layers

Stim-BIDS supports multiple annotation layers for the same stimuli:

| Layer | Description |
|-------|-------------|
| `visual-features` | Low-level visual features (color, edges) |
| `semantic-content` | High-level content (objects, scenes) |
| `hed-tags` | HED event descriptors |
| `emotional-ratings` | Valence/arousal ratings |
| `temporal-segmentation` | Scene boundaries, shot changes |

## AGI Repository Structure

AGI stimulus repositories follow this pattern:

```
stimulus-name/
├── stimuli/
│   └── [files or pointers]
├── annotations/
│   ├── visual-saliency/
│   │   ├── events.tsv
│   │   └── events.json
│   ├── emotional-ratings/
│   │   ├── events.tsv
│   │   └── events.json
│   └── hed-tags/
│       ├── events.tsv
│       └── events.json
├── README.md
├── LICENSE
└── dataset_description.json
```

## Integration Example

### From HEDit to BIDS

```python
import pandas as pd
import httpx
import json

# Generate HED annotation
response = httpx.post(
    "https://api.annotation.garden/hedit/annotate",
    json={"description": "A neutral male face appears for 500ms"},
    headers={"X-OpenRouter-Key": "your-key"}
)
hed = response.json()["annotation"]

# Create events.tsv row
event = {
    "onset": 0.0,
    "duration": 0.5,
    "trial_type": "face",
    "stim_file": "stimuli/images/face_001.png",
    "HED": hed
}

# Append to events file
df = pd.DataFrame([event])
df.to_csv("events.tsv", sep="\t", index=False)

# Create sidecar JSON
sidecar = {
    "onset": {"Description": "Event onset"},
    "duration": {"Description": "Event duration"},
    "trial_type": {"Levels": {"face": "Face stimulus"}},
    "HED": {"Description": "HED annotation"}
}
with open("events.json", "w") as f:
    json.dump(sidecar, f, indent=2)
```

## Resources

- **BIDS Specification**: [bids-specification](https://bids-specification.readthedocs.io/)
- **BIDS Validator**: [bids-validator](https://github.com/bids-standard/bids-validator)
- **Stim-BIDS (BEP044)**: [Pull Request](https://github.com/bids-standard/bids-specification/pull/2022)
- **BIDS Examples**: [bids-examples](https://github.com/bids-standard/bids-examples)
