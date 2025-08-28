#!/bin/bash

# Get latest screenshot
IMG=$(ls -t ~/Pictures/Screenshots/* | head -n 1)

# Random output base (no .txt!)
OUT="/tmp/ocrshot.$RANDOM"

# Run OCR
tesseract "$IMG" "$OUT" -l fas

# Show result
cat "$OUT.txt"
