# Generating the GitHub Pages documentation

Eventually this will be automated, but in the meantime, those with write access to the repo must update the GitHub Pages following any change to the documents.

Clone this repo, checkout the gh-pages branch and make

``git clone https://github.com/AMWA-TV/nmos``

``cd nmos``

``git checkout gh-pages``

``make``

Check it's ok and if so push

``make push``

For a new repository, you will need to provide/copy the following into the gh-pages branch:

``Makefile *.sh README-header.md README-GitHubPages.md``
