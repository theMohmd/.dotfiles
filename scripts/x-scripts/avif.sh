#!/bin/bash

avif() {
  find . -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.gif" \) | while read -r img; do
  avif_name="${img%.*}.avif"
  if avifenc "$img" "$avif_name"; then
    echo "Converted $img to $avif_name"
    rm "$img"
    echo "Deleted original file $img"
  else
    echo "Failed to convert $img"
  fi
done
}
