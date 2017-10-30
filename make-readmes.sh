#!/bin/bash

# TODO: Move some of the common code into functions (DRY)

# The top-level nmos repo doesn't have docs/ APIs/ or examples/ folders

HEAD=README-head.md
CONTENTS=README-contents.md
README=README.md

echo "Making top level README.md"

echo "## Branches" > $CONTENTS
for dir in branches/*; do
    branch=${dir##*/}
    echo -e "\n[$branch](branches/$branch)" >>  $CONTENTS
done
echo >> $CONTENTS


echo "## Tags" >> $CONTENTS
for dir in tags/*; do
    if [[ $dir != "tags/*" ]]; then   # i.e. there are no tags
        tag=${dir##*/}
        echo -e "\n[$tag](tags/$tag)" >>  $CONTENTS
    fi
done
echo >> $CONTENTS

cat $HEAD $CONTENTS > $README

#for b_or_t in branches tags; do
for b_or_t in branches; do
    echo "Processing $b_or_t..."
    cd $b_or_t
    for dir in */; do
        dirname=${dir%%/}
        README=README.md
        echo "Making $dirname/$README"
        cd $dir
            echo -e "# Documentation for $dirname\n" > $README
            for doc in *.md; do
                if [[ $doc != README.md ]]; then
                    no_ext=${doc%%.md}
                    linktext=${no_ext} 
                    echo " - [$linktext]($doc)" >> $README
                fi
            done

            cd ..
    done
    cd ..
done

