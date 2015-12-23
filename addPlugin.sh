#!/bin/bash

if [ "$#" != "1" ]
then
   echo "Usage: $0 <git url>"
   exit
fi

echo "Adding submodule..."

REPONAME=$(echo "$1" | sed 's/^.*\///' | sed 's/\..*$//')

echo $REPONAME

git submodule add "$1" vim/bundle/$REPONAME

echo "Submodule added!"
