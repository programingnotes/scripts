#!/bin/bash

# works with a file called VERSION in the current directory,
# the contents of which should be a semantic version number
# such as "1.2.3"

# this script will display the current version, automatically
# suggest a "minor" version update, and ask for input to use
# the suggestion, or a newly entered value.

# once the new version number is determined, the script will
# pull a list of changes from git history, prepend this to
# a file called CHANGES (under the title of the new version
# number) and create a GIT tag.


NOW="$(date +'%B %d, %Y')"
RED="\033[1;31m"

BLUE="\033[1;34m"
PURPLE="\033[1;35m"
RESET="\033[0m"

WHITE="\033[1;37m"
CYAN="\033[1;36m"
GREEN="\033[0;32m"
YELLOW="\033[1;33m"

LATEST_HASH=`git log --pretty=format:'%h' -n 1`

QUESTION="${GREEN}?"
WARN_FLAG="${YELLOW}!"

NOTE_FLAG="${CYAN}❯"
ADJUST_MSG="${NOTE_FLAG} Edit ${WHITE}CHANGELOG.md if necessary. Press enter to continue."
PUSH_MSG="${NOTE_FLAG} Pushing new version to the ${WHITE}origin${CYAN}..."

FIRST="${NOTE_FLAG} Could not find a VERSION file"
SECOND="${RED}This appears to be your first release. Is this correct? ${GREEN}[y/N] ${GREEN}"

confirm_first_release(){
  echo -e "$FIRST"
  echo ""
  echo -e "$SECOND"
  read -r RESPONSE 
    if [ "$RESPONSE" = "" ]; then RESPONSE="y"; fi
    if [ "$RESPONSE" = "Y" ]; then RESPONSE="y"; fi
    if [ "$RESPONSE" = "Yes" ]; then RESPONSE="y"; fi
    if [ "$RESPONSE" = "yes" ]; then RESPONSE="y"; fi
    if [ "$RESPONSE" = "YES" ]; then RESPONSE="y"; fi
    if [ "$RESPONSE" = "y" ]; then
      perform_first_release
    fi
}

perform_first_release(){
  echo "0.1.0" > VERSION
  echo "## Version v0.1.0 ($NOW)" > CHANGELOG.md  
  git log --pretty=format:"  - %s" >> CHANGELOG.md              
  echo "" >> CHANGELOG.md
  echo "" >> CHANGELOG.md
  echo -e "$ADJUST_MSG"
  read
  echo -e "$PUSH_MSG"
  git add VERSION CHANGELOG.md
  git commit -m "Add VERSION and CHANGELOG.md files, Bump version to v0.1.0."
  git tag -a -m "Tag version v0.1.0." "v0.1.0"
  git push origin --tags
  git push origin master
}


if [ -f VERSION ]; then
    CURRENT_VERSION=`cat VERSION`
    BASE_LIST=(`echo $CURRENT_VERSION | tr '.' ' '`)
    V_MAJOR=${BASE_LIST[0]}
    V_MINOR=${BASE_LIST[1]}
    V_PATCH=${BASE_LIST[2]}
    echo -e "${NOTE_FLAG} Current version: ${WHITE}$CURRENT_VERSION"
    echo -e "${NOTE_FLAG} Latest commit hash: ${WHITE}$LATEST_HASH"
    echo ""
    echo ""  

    V_MINOR=$((V_MINOR + 1))
    V_PATCH=0
    SUGGESTED_VERSION="$V_MAJOR.$V_MINOR.$V_PATCH"
    VER_MSG="Your current version is: ${WHITE}$CURRENT_VERSION${WHITE}"
    SUGGEST_VERSION="The new suggested Version is: ${WHITE}$SUGGESTED_VERSION${WHITE}" 
    echo -e "${NOTE_FLAG} $VER_MSG"
    echo -e "${NOTE_FLAG} $SUGGEST_VERSION"
    echo -e "${NOTE_FLAG} Enter a version number: "
    read INPUT_STRING
    if [ "$INPUT_STRING" = "" ]; then
        INPUT_STRING=$SUGGESTED_VERSION
    fi

    echo -e "${NOTE_FLAG} Will set new version to be ${WHITE}$INPUT_STRING"    
    echo $INPUT_STRING > VERSION
else
  confirm_first_release   
fi
