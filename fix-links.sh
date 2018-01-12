#!/bin/bash

shopt -s nullglob

echo "Fixing links in documents"

# Currently no docs/ dir for this repo, and also need to fix links in index rubric
for file in {branches,tags}/*/*.md index.md index-head.md; do

    # Change %20 escaped spaces in inline links to understores
    perl -ni -e '@parts = split /(\(.*?\.md\))/ ; for ($n = 1; $n < @parts; $n += 2) { $parts[$n] =~ s/%20/_/g; }; print @parts' $file

    # Same but for reference links
    perl -ni -e '@parts = split /(\]:.*?\.md)/ ; for ($n = 1; $n < @parts; $n += 2) { $parts[$n] =~ s/%20/_/g; }; print @parts' $file
done
