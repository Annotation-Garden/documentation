#!/usr/bin/env bash
# Sync presentation source content from the hedit submodule into the docs site.
#
# Pulls the deck JSON, picture assets, and event data from
# hedit/presentations/<talk>/ into docs/projects/hedit/presentations/slides/<talk>/.
# The reveal.js viewer (presentation.html + runtime assets) is preserved.
#
# Run after `git submodule update` to refresh the talks bundled with the docs.

set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
HEDIT_SRC="${REPO_ROOT}/hedit/presentations"
DOCS_DST="${REPO_ROOT}/docs/projects/hedit/presentations/slides"

if [[ ! -d "${HEDIT_SRC}" ]]; then
  echo "Error: ${HEDIT_SRC} not found. Run 'git submodule update --init hedit' first." >&2
  exit 1
fi

for talk_dir in "${HEDIT_SRC}"/*/; do
  talk="$(basename "${talk_dir}")"
  dst="${DOCS_DST}/${talk}"

  if [[ ! -d "${dst}" ]]; then
    echo "Skipping ${talk}: no destination at ${dst} (set up the runtime first)"
    continue
  fi

  echo "Syncing ${talk} -> ${dst}"

  cp "${talk_dir}/${talk}.json" "${dst}/"

  mkdir -p "${dst}/assets/icons" "${dst}/assets/figures" "${dst}/data"
  cp "${talk_dir}"assets/icons/*.svg "${dst}/assets/icons/"
  cp "${talk_dir}"assets/figures/*.svg "${dst}/assets/figures/"
  cp "${talk_dir}"data/* "${dst}/data/"
done

echo "Done."
