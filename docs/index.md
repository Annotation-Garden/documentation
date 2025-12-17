# Annotation Garden Initiative

Welcome to the documentation for the **Annotation Garden Initiative (AGI)**, an open infrastructure for collaborative annotation of neuroscience stimuli.

## A New Science Paradigm

!!! success "The Annotation Gap Problem"

    Naturalistic stimuli datasets (movies, complex images, audio) are **rich in information but poor in annotation**. While a 2-hour movie contains millions of visual frames, emotional beats, dialogue, and scene changes, typical datasets arrive with minimal timing information at best.

    This creates a fundamental barrier: although methodologies like hyperalignment and functional connectivity can operate without annotations, **most analytical approaches (GLM-based analytics, encoding models) rely heavily on them**. The result? Researchers often default to resting-state paradigms despite rich neural data opportunities.

AGI represents a paradigm shift. Instead of each lab independently annotating the same stimuli, we build **shared, versioned, community-curated annotation layers** that unlock:

- **Novel analytics** on complex neural data
- **Cross-study comparisons** using common stimuli
- **FAIR-compliant datasets** ready for re-analysis
- **Reduced barrier to entry** for naturalistic neuroscience

Projects like [StudyForrest](https://studyforrest.org) and [Neuroscout](https://github.com/neuroscout/neuroscout) have demonstrated the value of rich annotations. AGI provides the infrastructure to scale this approach.

## What is AGI?

AGI addresses a fundamental fragmentation problem in neuroscience research: researchers repeatedly annotate the same naturalistic stimuli (images, videos, audio) in isolation. By building on [Stim-BIDS (BEP044)](https://github.com/bids-standard/bids-specification/pull/2022) and [HED specifications](https://hedtags.org), AGI enables researchers to share, refine, and build upon stimulus annotations collaboratively through GitHub-based version control.

## Projects

<div class="grid cards" markdown>

-   :material-tag-text:{ .lg .middle } **HEDit**

    ---

    Multi-agent system for generating valid HED (Hierarchical Event Descriptors) annotations from natural language descriptions.

    [:octicons-arrow-right-24: HEDit Documentation](projects/hedit/index.md)

-   :material-image-multiple:{ .lg .middle } **Image Annotation**

    ---

    VLM-based annotation tool for neuroscience image datasets, with support for multiple vision-language models.

    [:octicons-arrow-right-24: Image Annotation Documentation](projects/image-annotation/index.md)

</div>

## Quick Start

=== "HEDit CLI"

    ```bash
    # Install HEDit
    pip install hedit

    # Initialize with your API key
    hedit init --api-key YOUR_OPENROUTER_KEY

    # Generate HED annotation
    hedit annotate "A red circle appears on the left side of the screen"
    ```

=== "HEDit API"

    ```python
    import httpx

    response = httpx.post(
        "https://api.annotation.garden/hedit/annotate",
        json={"description": "A red circle appears on screen"},
        headers={"X-OpenRouter-Key": "your-key"}
    )
    print(response.json()["annotation"])
    ```

=== "Image Annotation"

    ```bash
    # Clone and setup
    git clone https://github.com/Annotation-Garden/image-annotation
    cd image-annotation
    pip install -e .

    # Run the annotation service
    python -m image_annotation.api
    ```

## Standards

AGI builds on established neuroscience data standards:

- **[HED (Hierarchical Event Descriptors)](https://hedtags.org)**: A standardized vocabulary for describing events in behavioral experiments
- **[BIDS (Brain Imaging Data Structure)](https://bids.neuroimaging.io)**: A standard for organizing neuroimaging data
- **[Stim-BIDS (BEP044)](https://github.com/bids-standard/bids-specification/pull/2022)**: Extension for organizing stimulus files and their annotations

## Flagship Datasets

AGI is being developed with these flagship datasets:

| Dataset | Type | Description |
|---------|------|-------------|
| Natural Scenes Dataset (NSD) | Images | 73,000 COCO images with 7T fMRI |
| Forrest Gump | Video | 2-hour movie with temporal annotations |
| HBN Movies | Video | Child Mind Institute collection (Despicable Me, Pixar shorts) |

## Getting Help

- **GitHub Issues**: Report bugs or request features on [GitHub](https://github.com/Annotation-Garden)
- **Documentation**: This site contains comprehensive guides and API references
- **Contributing**: See our [contribution guidelines](contributing/index.md)

## Links

- Website: [annotation.garden](https://annotation.garden)
- GitHub Organization: [Annotation-Garden](https://github.com/Annotation-Garden)
- HEDit Frontend: [hedit.pages.dev](https://hedit.pages.dev)
