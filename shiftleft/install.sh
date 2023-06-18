#!/bin/sh

echo "Hello! I am DevSecOps protection installer (sh)."

GIT_REPO_NAME=kbot-devsecops
GIT_REPO_ROOT=$(git rev-parse --show-toplevel)
GIT_HOOKS_DIR=$(git rev-parse --git-dir)/hooks

echo   "$GIT_REPO_ROOT/$GIT_HOOKS_DIR"

ls     "$GIT_REPO_ROOT/$GIT_HOOKS_DIR"
rm -rf "$GIT_REPO_ROOT/$GIT_HOOKS_DIR/$GIT_REPO_NAME"
echo $0
git clone https://github.com/marynadevops/$GIT_REPO_NAME "$GIT_REPO_ROOT/$GIT_HOOKS_DIR"

cp "$GIT_REPO_ROOT/$GIT_HOOKS_DIR/$GIT_REPO_NAME/shiftleft/pre-commit-hook" \
   "$GIT_REPO_ROOT/$GIT_HOOKS_DIR/pre-commit"
chmod +x "$GIT_REPO_ROOT/$GIT_HOOKS_DIR/pre-commit"

echo "Bye, thanks! DevSecOps protection installed"