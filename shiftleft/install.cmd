@ECHO OFF

ECHO "Hello! I am DevSecOps protection installer (cmd)."

SET GIT_REPO_NAME=kbot-devsecop
FOR /f %%i IN ('git rev-parse --show-toplevel') DO SET GIT_REPO_ROOT=%%i
FOR /f %%i IN ('git config --get core.hooksPath 2>NUL || echo.".git/hooks"') DO SET GIT_HOOKS_DIR=%%i
SET LOCAL_HOOKS=%GIT_REPO_ROOT%/%GIT_HOOKS_DIR%
SET LOCAL_DEVSECOPS=%LOCAL_HOOKS%/%GIT_REPO_NAME%/shiftleft

ECHO   "%LOCAL_HOOKS%"
ECHO                                                      "%LOCAL_DEVSECOPS%"
RMDIR /s /q                                               "%LOCAL_DEVSECOPS%"
git clone https://github.com/marynadevops/%GIT_REPO_NAME% "%LOCAL_DEVSECOPS%"
RMDIR /s /q                                               "%LOCAL_DEVSECOPS%/.git"

COPY "%LOCAL_DEVSECOPS:/=\%\pre-commit-hook" ^
             "%LOCAL_HOOKS%/pre-commit"

ECHO "gitleaks will be downloaded and installed on first pre-commit hook call."

ECHO "Bye, thanks! DevSecOps protection installed."
