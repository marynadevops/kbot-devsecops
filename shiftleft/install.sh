#!/bin/sh

echo "Hello! I am DevSecOps protection installer (sh)."

GIT_REPO_NAME=kbot-devsecops
GIT_REPO_ROOT=$(git rev-parse --show-toplevel)
GIT_HOOKS_DIR=$(git config --get core.hooksPath 2>/dev/null || echo ".git/hooks")
LOCAL_HOOKS=$GIT_REPO_ROOT/$GIT_HOOKS_DIR
LOCAL_DEVSECOPS=$LOCAL_HOOKS/$GIT_REPO_NAME/shiftleft

echo   "$LOCAL_HOOKS"
echo                                                     "$LOCAL_DEVSECOPS"
rm -rf                                                   "$LOCAL_DEVSECOPS"
git clone https://github.com/marynadevops/$GIT_REPO_NAME "$LOCAL_DEVSECOPS"
rm -rf                                                   "$LOCAL_DEVSECOPS/.git"

cp "$LOCAL_DEVSECOPS/pre-commit-hook" \
         "$LOCAL_HOOKS/pre-commit"
chmod +x "$LOCAL_HOOKS/pre-commit"

if ! "$LOCAL_DEVSECOPS/gitleaks" version
then
    . "$LOCAL_DEVSECOPS/gitleaks-install.sh" "$LOCAL_DEVSECOPS"
fi

echo "Bye, thanks! DevSecOps protection installed."
