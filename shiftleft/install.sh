#!/bin/sh

echo "Hello! I am installer"

GIT_REPO_ROOT=$(git rev-parse --show-toplevel)
GIT_HOOKS_DIR=$(git rev-parse --git-dir)/hooks

echo "$GIT_REPO_ROOT/$GIT_HOOKS_DIR"

ls     $GIT_REPO_ROOT/$GIT_HOOKS_DIR
rm -rf $GIT_REPO_ROOT/$GIT_HOOKS_DIR/devsecops
echo $0
