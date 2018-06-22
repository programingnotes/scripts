#!/bin/bash

# Your version was bumped by bumpversion.sh but changelong
# current version reflects new release 
# new release has no new commits yet 
# needs the version before current version so to to reflect 
# the changes that took place beofore this current version was

WHITE="\033[1;37m"
# CYAN="\033[1;36m"
GREEN="\033[0;32m"
YELLOW="\033[1;33m"
RED="\033[1;31m"

QUESTION="${GREEN}?"
WARN_FLAG="${YELLOW}!"

NOTE_FLAG="${RED}❯"
NOW="$(date +'%B %d, %Y')"
UPDATED_VERSION=`cat VERSION`
LATEST_HASH=`git log --pretty=format:'%h' -n 1`

BASE_LIST=(`echo $UPDATED_VERSION | tr '.' ' '`)
V_MAJOR=${BASE_LIST[0]}
V_MINOR=${BASE_LIST[1]}
V_PATCH=${BASE_LIST[2]}

V_MINOR=$((V_MINOR - 1))
V_PATCH=0
SUGGESTED_PREVIOUS_VERSION="$V_MAJOR.$V_MINOR.$V_PATCH"
# SUGGESTION="Suggested : ${WHITE}$SUGGESTED_PREVIOUS_VERSION${WHITE}" 

# echo -e "${NOTE_FLAG} Your current version: ${WHITE}$UPDATED_VERSION"
# echo ""
# echo -e "${NOTE_FLAG} $SUGGESTION"
# echo -e "${NOTE_FLAG} Enter a COMMIT version number: "
# read INPUT_STRING
# if [ "$INPUT_STRING" = "" ]; then
#     INPUT_STRING=$SUGGESTED_PREVIOUS_VERSION
# fi

ADJUST_MSG="${NOTE_FLAG} Edit ${WHITE}CHANGELOG.md ${WHITE}if necessary${RED}. Press enter to continue"
# PUSH_MSG="${CYAN}❯ Pushing new version to the ${WHITE}origin${CYAN}..."

echo "## Version $UPDATED_VERSION (on $NOW)" > tmpfile
git log --pretty=format:" - %s" "v$SUGGESTED_PREVIOUS_VERSION"... HEAD >> tmpfile
echo "" >> tmpfile
echo "" >> tmpfile
cat CHANGELOG.md >> tmpfile
mv tmpfile CHANGELOG.md
echo -e "$ADJUST_MSG"
read
# echo -e "$PUSH_MSG"
