#!/bin/bash

# Function to convert SVG files to TSX components
icons() {
    local input="${1:-.}"  # Default to current directory if not specified
    local temp_dir=""
    local target_dir=""
    local cleanup_temp=false
    
    # Ask for the component name
    read -p "Enter the component name: " component_name
    
    # Validate component name
    if [[ -z "$component_name" ]]; then
        echo "Error: Component name cannot be empty"
        return 1
    fi
    
    # Check if input is a zip file
    if [[ "$input" == *.zip ]]; then
        # Check if zip file exists
        if [[ ! -f "$input" ]]; then
            echo "Error: Zip file '$input' not found"
            return 1
        fi
        
        # Check if unzip command is available
        if ! command -v unzip &> /dev/null; then
            echo "Error: 'unzip' command not found. Please install unzip to process zip files."
            return 1
        fi
        
        # Create temporary directory
        temp_dir=$(mktemp -d)
        target_dir="$temp_dir"
        cleanup_temp=true
        
        echo "Extracting zip file '$input' to temporary directory..."
        
        # Extract zip file to temp directory
        if ! unzip -q "$input" -d "$temp_dir"; then
            echo "Error: Failed to extract zip file '$input'"
            rm -rf "$temp_dir"
            return 1
        fi
        
        echo "Zip file extracted successfully"
        
        # Debug: Show what files were extracted
        echo "Files in zip:"
        find "$temp_dir" -name "*.svg" | head -10
    else
        # Input is a directory
        target_dir="$input"
        
        # Check if directory exists
        if [[ ! -d "$target_dir" ]]; then
            echo "Error: Directory '$target_dir' not found"
            return 1
        fi
    fi
    
    # Store original directory
    local original_dir=$(pwd)
    
    # Change to target directory
    cd "$target_dir" || {
        echo "Error: Cannot access directory '$target_dir'"
        [[ "$cleanup_temp" == true ]] && rm -rf "$temp_dir"
        return 1
    }
    
    # Find SVG files recursively if we're in a temp directory from zip extraction
    local svg_pattern="Property 1=*.svg"
    local svg_files=()
    
    if [[ "$cleanup_temp" == true ]]; then
        # For zip files, search recursively for SVG files
        while IFS= read -r -d '' file; do
            svg_files+=("$file")
        done < <(find . -name "$svg_pattern" -print0)
        
        if [[ ${#svg_files[@]} -eq 0 ]]; then
            echo "No SVG files found matching pattern '$svg_pattern' in zip file"
            cd "$original_dir"
            rm -rf "$temp_dir"
            return 1
        fi
        
        echo "Found ${#svg_files[@]} SVG files matching pattern"
        
        # Move all found SVG files to the root of temp directory for processing
        for file in "${svg_files[@]}"; do
            local basename_file=$(basename "$file")
            if [[ "$file" != "./$basename_file" ]]; then
                echo "Moving $file to ./$basename_file"
                mv "$file" "./$basename_file"
            fi
        done
    else
        # For directories, check in current location only
        if ! ls $svg_pattern 1> /dev/null 2>&1; then
            echo "No SVG files found matching pattern '$svg_pattern' in $target_dir"
            cd "$original_dir"
            return 1
        fi
    fi
    
    # Create the output file in the original directory
    cd "$original_dir"
    local output_file="${component_name}.tsx"
    
    # Start writing the TSX file
    cat > "$output_file" << 'EOF'
import { SvgIcon, SvgIconProps } from "@mui/material";

EOF
    
    # Go back to target directory for processing
    cd "$target_dir"
    
    # Verify files are accessible
    echo "Files available for processing:"
    ls -la "Property 1="*.svg 2>/dev/null || echo "No files match the pattern in current directory"
    
    # Process each SVG file - FIX: Use proper array iteration instead of glob expansion
    local count=0
    local components_list=()
    
    # Create array of SVG files to process
    local svg_files_to_process=()
    while IFS= read -r -d '' file; do
        svg_files_to_process+=("$file")
    done < <(find . -maxdepth 1 -name "Property 1=*.svg" -print0)
    
    # Process each file in the array
    for svg_file in "${svg_files_to_process[@]}"; do
        # Remove ./ prefix if present
        svg_file="${svg_file#./}"
        
        echo "Processing file: $svg_file"
        
        # Extract variant name from filename
        local variant=$(echo "$svg_file" | sed 's/Property 1=\(.*\)\.svg/\1/')
        
        # Clean variant name (remove spaces, make camelCase)
        local variant_clean=$(echo "$variant" | sed 's/[[:space:]]//g' | sed 's/^\(.\)/\U\1/')
        
        echo "Processing: $svg_file -> ${component_name}${variant_clean}Icon"
        
        # Read SVG content and process it
        local svg_content=$(cat "$svg_file")
        
        # Remove XML declaration and DOCTYPE if present
        svg_content=$(echo "$svg_content" | sed '/<?xml/d' | sed '/<!DOCTYPE/d')
        
        # Convert kebab-case attributes to camelCase
        svg_content=$(echo "$svg_content" | sed -E 's/stroke-width=/strokeWidth=/g')
        svg_content=$(echo "$svg_content" | sed -E 's/stroke-linecap=/strokeLinecap=/g')
        svg_content=$(echo "$svg_content" | sed -E 's/stroke-linejoin=/strokeLinejoin=/g')
        svg_content=$(echo "$svg_content" | sed -E 's/stroke-miterlimit=/strokeMiterlimit=/g')
        svg_content=$(echo "$svg_content" | sed -E 's/stroke-dasharray=/strokeDasharray=/g')
        svg_content=$(echo "$svg_content" | sed -E 's/stroke-dashoffset=/strokeDashoffset=/g')
        svg_content=$(echo "$svg_content" | sed -E 's/fill-rule=/fillRule=/g')
        svg_content=$(echo "$svg_content" | sed -E 's/fill-opacity=/fillOpacity=/g')
        svg_content=$(echo "$svg_content" | sed -E 's/stroke-opacity=/strokeOpacity=/g')
        svg_content=$(echo "$svg_content" | sed -E 's/clip-path=/clipPath=/g')
        svg_content=$(echo "$svg_content" | sed -E 's/clip-rule=/clipRule=/g')
        svg_content=$(echo "$svg_content" | sed -E 's/font-family=/fontFamily=/g')
        svg_content=$(echo "$svg_content" | sed -E 's/font-size=/fontSize=/g')
        svg_content=$(echo "$svg_content" | sed -E 's/font-weight=/fontWeight=/g')
        svg_content=$(echo "$svg_content" | sed -E 's/font-style=/fontStyle=/g')
        svg_content=$(echo "$svg_content" | sed -E 's/text-anchor=/textAnchor=/g')
        svg_content=$(echo "$svg_content" | sed -E 's/dominant-baseline=/dominantBaseline=/g')
        svg_content=$(echo "$svg_content" | sed -E 's/vector-effect=/vectorEffect=/g')
        svg_content=$(echo "$svg_content" | sed -E 's/shape-rendering=/shapeRendering=/g')
        svg_content=$(echo "$svg_content" | sed -E 's/color-interpolation=/colorInterpolation=/g')
        svg_content=$(echo "$svg_content" | sed -E 's/color-interpolation-filters=/colorInterpolationFilters=/g')
        svg_content=$(echo "$svg_content" | sed -E 's/pointer-events=/pointerEvents=/g')
        svg_content=$(echo "$svg_content" | sed -E 's/marker-start=/markerStart=/g')
        svg_content=$(echo "$svg_content" | sed -E 's/marker-mid=/markerMid=/g')
        svg_content=$(echo "$svg_content" | sed -E 's/marker-end=/markerEnd=/g')
        
        # Convert colors to currentColor (but preserve none values)
        svg_content=$(echo "$svg_content" | sed -E 's/fill="[^"]*"/fill="currentColor"/g')
        svg_content=$(echo "$svg_content" | sed -E 's/stroke="[^"]*"/stroke="currentColor"/g')
        svg_content=$(echo "$svg_content" | sed -E 's/fill:[^;")]*([;")])/fill:currentColor\1/g')
        svg_content=$(echo "$svg_content" | sed -E 's/stroke:[^;")]*([;")])/stroke:currentColor\1/g')
        
        # Restore none values
        svg_content=$(echo "$svg_content" | sed 's/fill="currentColor"/fill="currentColor"/g' | sed 's/fill="none"/fill="none"/g')
        svg_content=$(echo "$svg_content" | sed 's/stroke="currentColor"/stroke="currentColor"/g' | sed 's/stroke="none"/stroke="none"/g')
        
        # Extract the inner content of the SVG (everything between <svg> tags)
        local inner_svg=$(echo "$svg_content" | sed -n 's/.*<svg[^>]*>\(.*\)<\/svg>.*/\1/p')
        
        # If that didn't work, try a more robust approach
        if [[ -z "$inner_svg" ]]; then
            # Remove opening svg tag and closing svg tag
            inner_svg=$(echo "$svg_content" | sed 's/<svg[^>]*>//' | sed 's/<\/svg>//')
        fi
        
        # Clean up whitespace in inner_svg
        inner_svg=$(echo "$inner_svg" | sed 's/^[[:space:]]*//' | sed 's/[[:space:]]*$//')
        
        # Write the component function to the output file in original directory
        cat >> "$original_dir/$output_file" << EOF
export function ${component_name}${variant_clean}Icon(props: SvgIconProps) {
	return (
		<SvgIcon {...props}>
			${inner_svg}
		</SvgIcon>
	);
}

EOF
        ((count++))
        components_list+=("${component_name}${variant_clean}Icon")
    done
    
    # Return to original directory
    cd "$original_dir"
    
    # Clean up temporary directory if created
    if [[ "$cleanup_temp" == true ]]; then
        rm -rf "$temp_dir"
        echo "Temporary files cleaned up"
    fi
    
    echo "Generated $output_file with $count icon components"
    echo "Components created:"
    
    # Show the components that were created
    for component in "${components_list[@]}"; do
        echo "  - $component"
    done
    return 0
}
