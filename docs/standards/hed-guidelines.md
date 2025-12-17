# HED Guidelines

HED (Hierarchical Event Descriptors) is a standardized vocabulary for describing events in behavioral experiments. This guide covers HED usage within AGI.

## What is HED?

HED provides a **hierarchical, controlled vocabulary** for describing experimental events in a machine-readable format. Unlike free-text descriptions, HED annotations:

- Have **consistent semantics** across studies
- Are **machine-parseable** for automated analysis
- Support **complex event structures** via grouping
- Enable **cross-study comparisons**

## HED Structure

### Tags

HED uses a hierarchical tag structure:

```
Event
├── Sensory-event
│   ├── Visual-presentation
│   └── Auditory-presentation
├── Agent-action
│   ├── Participant-response
│   └── Experimenter-action
└── Data-feature
```

### Basic Examples

| Description | HED Annotation |
|-------------|----------------|
| A visual stimulus appears | `Sensory-event, Visual-presentation` |
| Participant presses a button | `Agent-action, Press, (Item-physical/Button)` |
| Red circle on left side | `(Red, Circle, (Left-side))` |

### Grouping with Parentheses

Parentheses group related tags:

```
(Red, Circle, (Left-side-of, Screen-component))
```

This means: a red circle on the left side of the screen.

### Complex Events

For complex events, use multiple tag groups:

```
(Sensory-event, Visual-presentation, (Image, Face, Male)),
(Task-property, Target)
```

This describes: a visual presentation of a male face image that is the target.

## HED Schema Versions

AGI tools support multiple HED schema versions:

| Version | Status | Notes |
|---------|--------|-------|
| 8.3.0 | Stable | Default for most tools |
| 8.4.0 | Stable | Enhanced visual vocabulary |
| 8.5.0 | Development | In testing |

Specify the schema version in your requests:

```bash
hedit annotate "A face appears" --schema 8.4.0
```

## Best Practices

### Do

- Use **specific tags** when available (e.g., `Face` instead of `Image`)
- **Group related tags** with parentheses
- Include **spatial information** (Left, Right, Center)
- Add **temporal information** when relevant (Duration)
- **Validate** all annotations before use

### Don't

- Use **free text** where HED tags exist
- Create **inconsistent groupings**
- Omit **essential event features**
- Mix **schema versions** within a dataset

## Validation

Always validate HED strings:

=== "CLI"

    ```bash
    hedit validate "Sensory-event, Visual-presentation"
    ```

=== "Python"

    ```python
    from hedtools import HedString, load_schema

    schema = load_schema("8.3.0")
    hed = HedString("Sensory-event, Visual-presentation", schema)
    issues = hed.validate()
    ```

=== "API"

    ```bash
    curl -X POST https://api.annotation.garden/hedit/validate \
      -H "Content-Type: application/json" \
      -d '{"hed_string": "Sensory-event, Visual-presentation"}'
    ```

## Common Patterns

### Visual Stimuli

```
# Image presentation
(Sensory-event, Visual-presentation, (Image))

# Specific image content
(Sensory-event, Visual-presentation, (Image, Face, (Male, Adult)))

# With spatial location
(Sensory-event, Visual-presentation, (Image, Face), (Left-side))
```

### Participant Actions

```
# Button press
(Agent-action, Participant-response, Press, (Item-physical/Button))

# Keyboard response
(Agent-action, Participant-response, Press, (Item-physical/Key))

# Eye movement
(Agent-action, Participant-response, Move-eyes, (To, Item))
```

### Temporal Events

```
# Onset
(Sensory-event, Visual-presentation, (Onset))

# Offset
(Sensory-event, Visual-presentation, (Offset))

# Duration
(Sensory-event, Duration/500 ms)
```

## Resources

- **HED Documentation**: [hedtags.org](https://hedtags.org)
- **HED Schema Browser**: [hed-specification](https://www.hedtags.org/hed-specification/)
- **HED Validator**: [hed-python](https://github.com/hed-standard/hed-python)
- **HEDit**: AI-powered annotation generation
