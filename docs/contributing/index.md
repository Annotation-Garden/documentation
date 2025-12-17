# Contributing

Welcome to the Annotation Garden Initiative! We appreciate your interest in contributing to open neuroscience annotation infrastructure.

## Ways to Contribute

<div class="grid cards" markdown>

-   :material-tag-plus:{ .lg .middle } **Add Annotations**

    ---

    Contribute annotations to existing stimulus repositories.

    [:octicons-arrow-right-24: Annotation Guidelines](#contributing-annotations)

-   :material-bug:{ .lg .middle } **Report Issues**

    ---

    Report bugs or suggest improvements to our tools.

    [:octicons-arrow-right-24: Issue Guidelines](#reporting-issues)

-   :material-source-pull:{ .lg .middle } **Code Contributions**

    ---

    Contribute to HEDit, Image Annotation, or other projects.

    [:octicons-arrow-right-24: Development Setup](development-setup.md)

-   :material-file-document-edit:{ .lg .middle } **Documentation**

    ---

    Improve documentation, tutorials, and examples.

    [:octicons-arrow-right-24: Documentation Guidelines](#documentation)

</div>

## Contributing Annotations

### 1. Choose a Stimulus Repository

Browse available repositories in the [Annotation-Garden organization](https://github.com/Annotation-Garden):

- Natural Scenes Dataset annotations
- StudyForrest temporal annotations
- HBN Movies annotations (pointer-based)

### 2. Fork and Clone

```bash
git clone https://github.com/YOUR_USERNAME/stimulus-repo
cd stimulus-repo
```

### 3. Create Annotation Branch

```bash
git checkout -b add-annotations-your-name
```

### 4. Add Your Annotations

Follow the [annotation format](../standards/annotation-format.md):

```
annotations/
└── your-annotation-type/
    ├── events.tsv
    └── events.json
```

### 5. Validate Annotations

```bash
# Validate HED strings
hedit validate "$(cat annotations/hed-tags/events.tsv | tail -1 | cut -f4)"

# Or validate all
python scripts/validate_annotations.py
```

### 6. Submit Pull Request

```bash
git add .
git commit -m "Add HED annotations for stimuli 001-100"
git push origin add-annotations-your-name
```

Then create a Pull Request on GitHub.

## Reporting Issues

### Bug Reports

For bug reports, please include:

1. **Environment**: OS, Python version, package versions
2. **Steps to reproduce**: Minimal example that reproduces the issue
3. **Expected behavior**: What should happen
4. **Actual behavior**: What actually happens
5. **Error messages**: Full traceback if available

**Example:**

```markdown
## Bug Report

**Environment:**
- OS: macOS 14.1
- Python: 3.12.0
- hedit: 0.6.1-alpha2

**Steps to Reproduce:**
1. Run `hedit annotate "test"`
2. Observe error

**Expected:** HED annotation output
**Actual:** `ConnectionError: ...`

**Full Error:**
```
[paste traceback]
```
```

### Feature Requests

For feature requests:

1. **Use case**: Describe why you need this feature
2. **Proposed solution**: How you envision it working
3. **Alternatives**: Other approaches you've considered

## Code Contributions

### Development Workflow

1. **Fork** the repository
2. **Clone** your fork
3. **Create branch** from `develop` (not `main`)
4. **Make changes** with atomic commits
5. **Test** your changes
6. **Submit PR** to `develop`

### Branching Strategy

| Branch | Purpose |
|--------|---------|
| `main` | Production releases |
| `develop` | Active development |
| `feature/*` | New features |
| `fix/*` | Bug fixes |

### Commit Messages

Write clear, concise commit messages:

```
Add HED validation caching for improved performance

- Cache schema loads to avoid repeated file reads
- Add TTL-based cache invalidation
- Improve validation speed by 3x for batch operations
```

**Don't:**

- Use emojis
- Mention AI/Claude co-authorship
- Write vague messages like "fix bug"

### Code Style

See [Code Style Guide](code-style.md) for details:

- **Python**: Ruff for linting and formatting
- **TypeScript**: ESLint + Prettier
- **Tests**: pytest with coverage, no mocks

## Documentation

### Building Docs Locally

```bash
cd documentation
pip install -e .
mkdocs serve
```

Visit `http://localhost:8000` to preview.

### Documentation Style

- Use **clear, concise language**
- Include **code examples**
- Add **screenshots** for UI features
- Link to **related documentation**

## Community

### Communication

- **GitHub Issues**: Bug reports, feature requests
- **GitHub Discussions**: General questions, ideas
- **Pull Requests**: Code and documentation contributions

### Code of Conduct

We follow the [Contributor Covenant](https://www.contributor-covenant.org/). Be respectful, inclusive, and constructive.

## Recognition

Contributors are recognized in:

- Repository CONTRIBUTORS files
- Release notes
- Project documentation

Thank you for contributing to open neuroscience!
