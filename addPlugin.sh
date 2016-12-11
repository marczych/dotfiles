#!/bin/bash

set -euo pipefail

if [ "$#" != "1" ]; then
   echo "Usage: $0 <git url>"
   exit
fi

echo "Adding submodule..."

repo_name=$(echo "$1" | sed 's/^.*\///' | sed 's/\..*$//')

echo $repo_name

git submodule add "$1" vim/bundle/"$repo_name"

echo "Submodule added!"
