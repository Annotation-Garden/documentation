# AGI Documentation

Documentation site for the [Annotation Garden Initiative](https://annotation.garden), built with [MkDocs Material](https://squidfunk.github.io/mkdocs-material/).

**Live site:** https://docs.annotation.garden

## Local Development

### Prerequisites

- Python 3.11+
- pip

### Setup

```bash
# Clone the repository
git clone https://github.com/Annotation-Garden/documentation
cd documentation

# Install dependencies
pip install -e .

# Serve locally with hot reload
mkdocs serve
```

Visit http://localhost:8000 to preview the documentation.

### Build

```bash
mkdocs build
```

The static site is generated in the `site/` directory.

## Project Structure

```
documentation/
├── docs/                      # Markdown source files
│   ├── index.md              # Home page
│   ├── getting-started/      # Installation guides
│   ├── projects/             # Project documentation
│   │   ├── hedit/           # HEDit docs
│   │   └── image-annotation/ # Image Annotation docs
│   ├── standards/            # HED, BIDS specs
│   └── contributing/         # Contribution guidelines
├── overrides/                 # Theme customizations
├── stylesheets/              # Custom CSS
├── scripts/                  # Build scripts
├── mkdocs.yml                # MkDocs configuration
└── pyproject.toml            # Python dependencies
```

## Adding Documentation

### For Existing Projects

Edit files in `docs/projects/<project>/` and run `mkdocs serve` to preview.

### For New Projects

1. Create `docs/projects/<new-project>/index.md`
2. Add navigation entry in `mkdocs.yml`
3. Configure source paths in `mkdocs.yml` for API documentation

## Deployment

The site deploys automatically to Cloudflare Pages on push to main.

Manual deployment (if needed):

```bash
mkdocs build
# Upload site/ directory to Cloudflare Pages
```

## Contributing

See [Contributing Guide](docs/contributing/index.md) for guidelines.

## License

MIT License - see [LICENSE](LICENSE) for details.
