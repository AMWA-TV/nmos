#!/bin/bash

# TODO: Move some of the common code into functions (DRY)

shopt -s nullglob

# Filename for index in each dir
INDEX=index.md

# Modified version for top level nmos repo -- only does master
for b_or_t in branches; do
    echo "Processing $b_or_t $INDEX..."
    cd "$b_or_t"
    for dir in master/; do
        dirname="${dir%%/}"
        echo "Making $dirname/$INDEX"
        cd "$dir"
            echo -e "# Documentation\n" > "$INDEX"
            for doc in *.md; do
                if [[ "$doc" != "index.md" && "$doc" != "README.md" ]]; then
                    no_ext=${doc%%.md}
                    # Spaces causing problems so rename extracted docs to use underscore
                    underscore_space_doc="${doc// /_}"
                    mv "$doc" "$underscore_space_doc"
                    linktext=${no_ext}
                    echo " - [$linktext]($underscore_space_doc)" >> "$INDEX"
                fi
            done
            cd ..
      done
      cd ..
done

HEAD=index-head.md
CONTENTS=index-contents.md

echo "Making top level $INDEX"

echo "Adding in contents of master $INDEX"
# Shameful but effective - correct the links while copying text
sed 's:(:(branches/master/:' "branches/master/$INDEX" > "$CONTENTS"

# Not adding all the branches and tags

echo >> "$CONTENTS"


cat "$HEAD" "$CONTENTS" > "$INDEX"
