#!/bin/bash

CYAN="\033[1;36m"
GIT_REVIEW="${CYAN}❯ Review Git Status on Master:"

WHITE="\033[1;37m"
BRANCH_STATUS=`git status`
DISPLAY_GIT_STATUS="${WHITE} ${BRANCH_STATUS}"

# YELLOW="\033[1;33m"
RED="\033[1;31m"
REVIEW_PROMPT="${RED}❯ Are you statisfied with the status of the master branch? [y/N]  "

BIBlue="\033[1;94m" 
GET_OUT="${BIBlue}❯ Please review/correct the status of the master branch before releasing"

perform_release(){
  NUM_OF_TAGS=$(git tag)
  if [[ -z "$NUM_OF_TAGS" ]]; then
    echo "No Tags Found"
    ./scripts/bump_version.sh 
  else
    ./scripts/bump_version.sh 
    ./scripts/update_changelog.sh
    ./scripts/add_tag.sh    
  fi
}

quit_release(){
  echo -e "$GET_OUT"
  exit 1  
}

git_status_review(){
  echo -e "$GIT_REVIEW"
  echo ""
  echo -e "$DISPLAY_GIT_STATUS"
  echo ""
  echo -e "$REVIEW_PROMPT" 
  read -r RESPONSE
    if [ "$RESPONSE" = "Y" ]; then RESPONSE="y"; fi
    if [ "$RESPONSE" = "Yes" ]; then RESPONSE="y"; fi
    if [ "$RESPONSE" = "yes" ]; then RESPONSE="y"; fi
    if [ "$RESPONSE" = "YES" ]; then RESPONSE="y"; fi
    if [ "$RESPONSE" = "y" ]; then
      perform_release
    else
      quit_release
    fi  
}

if [[ $BRANCH=='ref: refs/heads/master' ]]; then
  git_status_review
else 
  echo "releases happen on master branch, you are on $BRANCH"
fi
