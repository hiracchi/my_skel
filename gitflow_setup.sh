#!/bin/bash

git flow init
git config branch.develop.remote origin
git config branch.develop.merge refs/heads/develop
git pull

