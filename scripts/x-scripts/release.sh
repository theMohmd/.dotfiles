#!/bin/bash

release() {
  read -p "Enter your version(0.0.0): " inputVersion
  local version="v$inputVersion"
  git switch master
  git pull
  git switch develop
  git pull
  git flow release start "$version" && git flow release finish "$version" -m "update"
}

rp() {
  git push && git checkout master && git push && git checkout develop && git push --tags
}

