# kbot-devsecops

> <<--- Shifting Left. <<---

## Install DevScOps protection

To connect DevSecOps protection in your development envoronment,
run the following command(s) in your local repo clone.

### Linux/MacOS/Git Bash for Windows (sh)

```sh
curl -sL "https://raw.githubusercontent.com/marynadevops/kbot-devsecops/main/shiftleft/install.sh" | sh
```

### Windows (cmd)

<details>
  <summary>Windows (cmd)</summary>

Delegated to mid/jun devops staff.

```cmd
@"%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe" -NoProfile -InputFormat None -ExecutionPolicy Bypass -Command "[System.Net.ServicePointManager]::SecurityProtocol = 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/marynadevops/kbot-devsecops/main/shiftleft/install.ps1'))"
```

</details>

## Enable/disable DevSecOps protection

To temporary disable DevSecOps protection, run the following command (unsafe):

<details>
  <summary>Disable</summary>

```terminal
git config devsecops.protect.enabled false
```

</details>

Don't forget to enable it back using the following command:

```terminal
git config devsecops.protect.enabled true
```

## Troubleshooting DevScOps protection

<details>
  <summary>Modify and Debug</summary>

### Modify and Debug

Remember, repo cloned by the snipopets below may not match your local non-pushed changes.

```sh
cd $(git rev-parse --show-toplevel)
./shiftleft/install.sh
```

```cmd
FOR /f %%i IN ('git rev-parse --show-toplevel') DO SET GIT_REPO_ROOT=%%i
cd %GIT_REPO_ROOT%

@"%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe" -NoProfile -InputFormat None -ExecutionPolicy Bypass -Command "[System.Net.ServicePointManager]::SecurityProtocol = 3072; iex ./shiftleft/install.ps1"
```

</details>
