#!/bin/bash

# Feature -> Develop
if ${{ startsWith(github.head_ref, 'feature') && github.ref == 'develop' }};
then
  # Breaking change
  if ${{ contains(github.event.pull_request.labels.*.name, 'breaking') }};
  then
    echo "::set-output name=inc::premajor"
    echo "::set-output name=preid::alpha"
  else
    echo "::set-output name=inc::preminor"
    echo "::set-output name=preid::alpha"
  fi
# Create release branch
elif ${{ github.head_ref == '' && github.ref == 'refs/heads/release/' }}
then
  echo "::set-output name=inc::prerelease"
  echo "::set-output name=preid::rc"
# Release -> Develop (Bugfixing on release candinate)
elif ${{ startsWith(github.head_ref, 'release') && github.ref == 'develop' }}
then
  echo "::set-output name=inc::prepatch"
  echo "::set-output name=preid::alpha"
# Hotfix -> Develop (hotfix from main)
elif ${{ startsWith(github.head_ref, 'hotfix') && github.ref == 'develop' }};
then
  echo "::set-output name=inc::prepatch"
  echo "::set-output name=preid::alpha"
# Bugfix -> Release
elif ${{ startsWith(github.head_ref, 'bugfix') && github.ref == 'refs/heads/release/' }}
then
  echo "::set-output name=inc::prepatch"
  echo "::set-output name=preid::rc"
# Release -> Main
elif ${{ startsWith(github.head_ref, 'release') && github.ref == 'main' }}
then
  echo "::set-output name=inc::stable"
  echo "::set-output name=preid::"
# Hotfix -> Main
elif ${{ startsWith(github.head_ref, 'hotfix') && github.ref == 'main' }};
then
  echo "::set-output name=inc::prepatch"
  echo "::set-output name=preid::"
fi
