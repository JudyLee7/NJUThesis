#!/usr/bin/env bash
set -euo pipefail

cd "$(dirname "$0")/.."

latexmk -g -xelatex -interaction=nonstopmode -halt-on-error docs/njuthesis-sample.tex

timestamp="$(date '+%Y%m%d_%H%M')"
output="${timestamp}_毕设论文.pdf"
counter=1

while [[ -e "$output" ]]; do
  output="${timestamp}_毕设论文_${counter}.pdf"
  counter=$((counter + 1))
done

mv njuthesis-sample.pdf "$output"

find . -path './.git' -prune -o \( \
  -name '*.aux' -o \
  -name '*.bbl' -o \
  -name '*.bcf' -o \
  -name '*.blg' -o \
  -name '*.fdb_latexmk' -o \
  -name '*.fls' -o \
  -name '*.log' -o \
  -name '*.out' -o \
  -name '*.run.xml' -o \
  -name '*.thm' -o \
  -name '*.toc' -o \
  -name '*.xdv' -o \
  -name '*.synctex' -o \
  -name '*.synctex.gz' -o \
  -name '*.synctex.gz(busy)' \
\) -type f -delete

printf '%s\n' "$output"
