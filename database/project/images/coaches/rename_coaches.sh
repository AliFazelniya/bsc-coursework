#!/bin/bash

for file in Coach\ \(*\).jpg; do
    [ -f "$file" ] || continue

    number=$(echo "$file" | sed -E 's/^Coach \(([0-9]+)\)\.jpg$/\1/')

    if [[ "$number" =~ ^[0-9]+$ ]]; then
        new_name="${number}.jpg"

        echo "$file -> $new_name"
        mv -- "$file" "$new_name"
    fi
done

echo "Done."
