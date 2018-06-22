#!/bin/bash

WHITE="\033[1;37m"
CYAN="\033[1;36m"
VERSION=`cat VERSION`

# PUSH_MSG="${CYAN}❯ Pushing new version to ${WHITE}Git Remote Origin${CYAN}..."
GIT_ADD="${CYAN}❯ Adding VERSION and CHANGELOG"
GIT_COMMIT="${CYAN}❯ Adding commit message about version bump"
GIT_TAG="${CYAN}❯ Creating a tag"
PUSH_TAG="${CYAN}❯ Pushed Tag"
PUSH_MSG="${CYAN}❯ Pushing commit message to ${WHITE}Git Remote Origin${CYAN}..."


echo -e "GIT_ADD"
git add CHANGELOG.md VERSION 
echo ""

echo -e "GIT_COMMIT"
git commit -m "Bump version to ${VERSION}."
echo ""

echo -e "$GIT_TAG"
git tag -a -m "Tag version ${VERSION}." "v$VERSION"
echo ""

echo -e "PUSH_TAG"
git push origin --tags
echo ""

echo -e "$PUSH_MSG"
git push origin master
echo 
