# Telemetry

HEDit collects anonymous telemetry data to help improve the service and support research on annotation quality. This page explains what data we collect, how it's used, and how you can opt out.

## Why We Collect Telemetry

Telemetry helps us:

1. **Improve annotation quality**: By analyzing successful and failed annotations, we can identify patterns and improve the underlying models
2. **Train better models**: Anonymized annotation pairs (description + HED string) can be used to fine-tune models for better HED annotation generation
3. **Track service health**: Understanding usage patterns helps us maintain and scale the service appropriately
4. **Support research**: Aggregated, anonymized data may be used for academic research on natural language to HED annotation translation

## What We Collect

When telemetry is enabled, we collect:

| Data | Description |
|------|-------------|
| Input description | The natural language event description you provided |
| Generated HED string | The HED annotation that was generated |
| Schema version | Which HED schema version was used (e.g., 8.3.0) |
| Validation iterations | How many validation attempts were needed |
| Validation errors | Any validation errors encountered (for debugging) |
| Model configuration | Which LLM model was used and its settings |
| Latency | How long the request took (for performance monitoring) |
| Source | Whether the request came from CLI, API, or web interface |

### Input Hashing for Deduplication

To avoid storing duplicate data, we hash each input description using SHA-256 and store only the first 16 characters. This allows us to detect duplicates without storing the full hash.

## What We Do NOT Collect

We are committed to user privacy. We explicitly **do not** collect:

- **IP addresses**: Your network location is never logged or stored
- **User identifiers**: We do not track individual users across requests
- **API keys**: Your OpenRouter or other API keys are never logged
- **Personal information**: No names, emails, or identifying information
- **Session tracking**: We do not use cookies or track sessions
- **Geographic data**: No location information is collected
- **Device fingerprints**: No browser or device identification

Each telemetry event is independent and cannot be linked to previous requests or to you personally.

## Data Storage and Security

- Telemetry data is stored in Cloudflare Workers KV (production) or local files (development)
- Data is encrypted in transit using HTTPS
- Access to telemetry data is restricted to project maintainers
- Data may be aggregated and anonymized for public research publications

## How to Opt Out

### Web Interface

Click the "Allow" checkbox in the footer of the HEDit web interface to disable telemetry. Your preference is saved in your browser's local storage.

### CLI

Use the `--no-telemetry` flag with any command:

```bash
hedit annotate "A red circle appears" --no-telemetry
```

Or disable telemetry permanently in your configuration:

```bash
hedit config set telemetry_enabled false
```

### API

Include `telemetry_enabled: false` in your request body:

```json
{
  "description": "A red circle appears on the screen",
  "telemetry_enabled": false
}
```

## Data Retention

- Raw telemetry data is retained for up to 12 months
- Aggregated statistics may be retained indefinitely
- You may request deletion of any data associated with your inputs by contacting us

## Open Source

The telemetry implementation is fully open source. You can review the code at:

- [Telemetry Schema](https://github.com/Annotation-Garden/HEDit/blob/main/src/telemetry/schema.py)
- [Telemetry Collector](https://github.com/Annotation-Garden/HEDit/blob/main/src/telemetry/collector.py)
- [Storage Backends](https://github.com/Annotation-Garden/HEDit/blob/main/src/telemetry/storage.py)

## Questions?

If you have questions about telemetry or data privacy, please:

- Open an issue on [GitHub](https://github.com/Annotation-Garden/HEDit/issues)
- Contact the maintainers at info@annotation.garden
