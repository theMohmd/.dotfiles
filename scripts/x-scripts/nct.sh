#!/bin/bash

nct() {
  declare -A components

  while IFS= read -r file; do
    echo "Checking: $file"
    if rg -q "export default" "$file"; then
      component_name=$(basename "$file" .tsx)
      echo "Found component: $component_name"
      components[$component_name]="$file"
    fi
  done < <(find . -type f -name "*.tsx" ! -name "_app.tsx" ! -name "_document.tsx")

  for component in "${!components[@]}"; do
    echo "Component: $component (${components[$component]})"
    rg -l "import .* from ['\"][^'\"]*/$component['\"]" --glob "*.tsx" .
    echo ""
  done
}
