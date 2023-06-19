# @"%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe" -NoProfile -InputFormat None -ExecutionPolicy Bypass -Command "[System.Net.ServicePointManager]::SecurityProtocol = 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/marynadevops/kbot-devsecops/main/shiftleft/install.ps1'))"

echo "Hello! I am DevSecOps protection installer (PowerShell)."

$GIT_REPO_NAME = "kbot-devsecops"
$GIT_REPO_ROOT = git rev-parse --show-toplevel
$GIT_HOOKS_DIR = (git config --get core.hooksPath 2>$null); if ([string]::IsNullOrEmpty($GIT_HOOKS_DIR)) { $GIT_HOOKS_DIR = ".git/hooks" }
$LOCAL_HOOKS = "$GIT_REPO_ROOT\$GIT_HOOKS_DIR"
$LOCAL_DEVSECOPS = "$LOCAL_HOOKS\$GIT_REPO_NAME"
$LOCAL_SHIFTLEFT = "$LOCAL_DEVSECOPS\shiftleft".Replace('\', '/')

echo "`"$LOCAL_HOOKS`""
echo "`"$LOCAL_DEVSECOPS`""
rm -r -fo $LOCAL_DEVSECOPS
git clone https://github.com/marynadevops/$GIT_REPO_NAME $LOCAL_DEVSECOPS
rm -r -fo "$LOCAL_DEVSECOPS\.git"

cp "$LOCAL_SHIFTLEFT/pre-commit-hook" `
       "$LOCAL_HOOKS/pre-commit"

$gitBashPath = (Get-Command -Name 'git' | Select-Object -ExpandProperty Source `
    | ForEach-Object { $_.Replace('\cmd\git.exe', '\bin\bash.exe') })
if ($gitBashPath) {
    start $gitBashPath @("$LOCAL_SHIFTLEFT/gitleaks-install.sh", "$LOCAL_SHIFTLEFT") -Wait -NoNewWindow
}
else {
    echo "Git Bash for Windows is not found."
    echo "gitleaks will be downloaded and installed on the first pre-commit hook call."
}

echo "Bye, thanks! DevSecOps protection installed."
