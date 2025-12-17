# Annotation Format

AGI uses standardized formats for storing and exchanging annotations.

## File Formats

### TSV (Tab-Separated Values)

Primary format for BIDS-compatible annotations:

```tsv
onset	duration	trial_type	HED	stim_file
0.0	0.5	face	Sensory-event, Visual-presentation, (Image, Face)	stimuli/face_001.png
0.5	0.0	response	Agent-action, Press	n/a
1.0	0.5	scene	Sensory-event, Visual-presentation, (Image, Scene)	stimuli/scene_001.png
```

### JSON

For rich metadata and API responses:

```json
{
  "stimulus_id": "nsd_00001",
  "annotations": {
    "description": "A man riding a bicycle through a park",
    "objects": ["man", "bicycle", "park", "trees"],
    "scene_category": "outdoor",
    "hed_annotation": "Sensory-event, Visual-presentation, (Image, Scene, Outdoor, (Human, Male, Action/Ride))"
  },
  "metadata": {
    "annotator": "gpt-4-vision",
    "timestamp": "2024-12-15T10:30:00Z",
    "schema_version": "8.3.0",
    "is_valid": true
  }
}
```

### JSONL (JSON Lines)

For streaming and batch processing:

```jsonl
{"id": "001", "hed": "Sensory-event, Visual-presentation", "valid": true}
{"id": "002", "hed": "Agent-action, Press", "valid": true}
{"id": "003", "hed": "Invalid-tag", "valid": false, "errors": ["TAG_INVALID"]}
```

## Schema Definitions

### Annotation Record

```json
{
  "$schema": "http://json-schema.org/draft-07/schema#",
  "type": "object",
  "required": ["stimulus_id", "hed_annotation"],
  "properties": {
    "stimulus_id": {
      "type": "string",
      "description": "Unique identifier for the stimulus"
    },
    "hed_annotation": {
      "type": "string",
      "description": "Valid HED annotation string"
    },
    "description": {
      "type": "string",
      "description": "Natural language description"
    },
    "is_valid": {
      "type": "boolean",
      "description": "HED validation status"
    },
    "schema_version": {
      "type": "string",
      "pattern": "^\\d+\\.\\d+\\.\\d+$",
      "description": "HED schema version used"
    },
    "annotator": {
      "type": "string",
      "description": "Source of annotation (model name or 'human')"
    },
    "timestamp": {
      "type": "string",
      "format": "date-time",
      "description": "ISO 8601 timestamp"
    }
  }
}
```

### Events File Schema

```json
{
  "$schema": "http://json-schema.org/draft-07/schema#",
  "type": "array",
  "items": {
    "type": "object",
    "required": ["onset", "duration"],
    "properties": {
      "onset": {
        "type": "number",
        "minimum": 0,
        "description": "Event onset in seconds"
      },
      "duration": {
        "type": "number",
        "minimum": 0,
        "description": "Event duration in seconds"
      },
      "trial_type": {
        "type": "string",
        "description": "Event category"
      },
      "HED": {
        "type": "string",
        "description": "HED annotation"
      },
      "stim_file": {
        "type": "string",
        "description": "Path to stimulus file"
      },
      "response_time": {
        "type": "number",
        "description": "Response time in seconds"
      }
    }
  }
}
```

## Conversion Utilities

### TSV to JSON

```python
import pandas as pd
import json

# Read TSV
df = pd.read_csv("events.tsv", sep="\t")

# Convert to JSON
records = df.to_dict(orient="records")
with open("events.json", "w") as f:
    json.dump(records, f, indent=2)
```

### JSON to TSV

```python
import pandas as pd
import json

# Read JSON
with open("annotations.json") as f:
    data = json.load(f)

# Convert to DataFrame
df = pd.DataFrame(data)
df.to_csv("events.tsv", sep="\t", index=False)
```

### HEDit Output to BIDS

```python
import httpx
import pandas as pd

# Get annotation from HEDit
response = httpx.post(
    "https://api.annotation.garden/hedit/annotate",
    json={"description": "A face image appears"},
    headers={"X-OpenRouter-Key": "key"}
)
result = response.json()

# Create BIDS event row
event = {
    "onset": 0.0,
    "duration": 0.5,
    "trial_type": "face",
    "HED": result["annotation"]
}

# Save
df = pd.DataFrame([event])
df.to_csv("sub-01_task-faces_events.tsv", sep="\t", index=False)
```

## Validation

### Using HEDit

```bash
# Validate single string
hedit validate "Sensory-event, Visual-presentation"

# Validate from file
cat events.tsv | while read -r line; do
    hed=$(echo "$line" | cut -f4)
    hedit validate "$hed" -o json
done
```

### Using hed-python

```python
from hed import HedString, load_schema

schema = load_schema("8.3.0")

def validate_hed(hed_string):
    hed = HedString(hed_string, schema)
    issues = hed.validate()
    return len(issues) == 0, issues

# Validate file
import pandas as pd
df = pd.read_csv("events.tsv", sep="\t")
for idx, row in df.iterrows():
    valid, issues = validate_hed(row["HED"])
    if not valid:
        print(f"Row {idx}: {issues}")
```

## Best Practices

1. **Always validate** HED strings before storing
2. **Include metadata** (schema version, annotator, timestamp)
3. **Use consistent file naming** following BIDS conventions
4. **Version your annotations** using Git
5. **Document annotation sources** (human vs. model)
