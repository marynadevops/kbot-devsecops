# kbot-devsecops

> <<--- Shifting Left. <<---

## Install DevScOps protection

### Linux/MacOS (sh)

```sh
curl -sL "https://raw.githubusercontent.com/marynadevops/kbot-devsecops/main/shiftleft/install.sh" | sh
```

### Windows (cmd)

<details>
  <summary>Windows (cmd)</summary>

Delegated to mid/jun devops staff.

```cmd
@"%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe" -NoProfile -InputFormat None -ExecutionPolicy Bypass -Command "[System.Net.ServicePointManager]::SecurityProtocol = 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/marynadevops/kbot-devsecops/main/shiftleft/install.cmd'))"
```

</details>

## Troubleshooting DevScOps protection

<details>
  <summary>Modify and Debug</summary>

### Modify and Debug

```sh
cd $(git rev-parse --show-toplevel)
./shiftleft/install.sh
```

```cmd
FOR /f %%i IN ('git rev-parse --show-toplevel') DO SET GIT_REPO_ROOT=%%i
cd %GIT_REPO_ROOT%
./shiftleft/install.cmd
```

</details>
