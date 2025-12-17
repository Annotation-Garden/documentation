# Projects

The Annotation Garden Initiative consists of several interconnected projects for neuroscience stimulus annotation.

## Core Projects

### HEDit

A multi-agent system for generating valid HED (Hierarchical Event Descriptors) annotations from natural language descriptions.

- **Repository**: [Annotation-Garden/hedit](https://github.com/Annotation-Garden/hedit)
- **API**: [api.annotation.garden/hedit](https://api.annotation.garden/hedit)
- **Frontend**: [hedit.pages.dev](https://hedit.pages.dev)

[:octicons-arrow-right-24: HEDit Documentation](hedit/index.md)

### Image Annotation

VLM-based annotation tool for neuroscience image datasets, supporting multiple vision-language models.

- **Repository**: [Annotation-Garden/image-annotation](https://github.com/Annotation-Garden/image-annotation)

[:octicons-arrow-right-24: Image Annotation Documentation](image-annotation/index.md)

## Shared Components

All AGI projects share common standards and patterns:

- **HED Integration**: All annotation outputs conform to HED schema specifications
- **BIDS Compatibility**: Outputs are structured for BIDS datasets
- **API Design**: RESTful APIs with OpenAPI documentation
- **Authentication**: Support for BYOK (Bring Your Own Key) model
