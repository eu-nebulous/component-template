#!/usr/bin/env bash

set -u
set -e

NAME=$1

cp -rf .gitignore .yamllint LICENSE noxfile.py java-spring-boot-demo zuul.d ../$NAME/
mkdir -p ../$NAME/charts
rsync --recursive --delete charts/nebulous-component-template/ ../$NAME/charts/nebulous-$NAME/
cd ../$NAME/
sed -i 's/nebulous-component-template-apply-helm-charts/nebulous-platform-apply-helm-charts/g' zuul.d/project.yaml 
find -name .git -prune -o -type f -print0 | xargs -0 sed -i "s/component-template/${NAME}/g"
git review -s
git add -A
git commit -m 'Init repo from the component-template'
git review
