# F&F Public Homebrew Tap

외부 배포가 승인된 F&F CLI와 애플리케이션을 위한 공개 Homebrew Tap입니다.

이 저장소에는 Homebrew Formula, 버전이 고정된 Release 바이너리, SHA-256 체크섬과 공개 릴리스 안내만
포함합니다. 각 제품의 소스 코드와 내부 개발 이력은 포함하지 않습니다.

## AX Link CLI

AX Link CLI는 AX Link 로그인, 등록 키 선택, 모델 provider 연결과 동기화를 지원합니다.

```bash
brew install F-F-WP/public/ax-link
ax-link version
```

GitHub 로그인이나 `HOMEBREW_GITHUB_API_TOKEN`은 필요하지 않습니다.

Homebrew 6 이상에서 위 완전한 설치 이름은 `F-F-WP/public` Tap 전체가 아니라 `ax-link` Formula 하나만 신뢰하도록
등록합니다. 별도의 `brew trust` 명령은 필요하지 않습니다. 자세한 정책은
[Homebrew Tap Trust](https://docs.brew.sh/Tap-Trust)를 참고하세요.

업데이트:

```bash
brew update
brew upgrade F-F-WP/public/ax-link
```

## Windows

Windows에는 Homebrew가 없으므로 PowerShell에서 Release의 zip을 받아 사용자 영역에 설치합니다. 관리자 권한은
필요하지 않습니다. 체크섬을 검증한 뒤 `%LOCALAPPDATA%\Programs\ax-link`에 설치하고 사용자 `Path`에 한 번만
추가합니다. `$version`만 바꾸면 같은 명령으로 업데이트도 됩니다. Windows arm64 바이너리는 `1.4.0`부터 제공됩니다.

```powershell
& {
  $ErrorActionPreference = "Stop"
  $version = "1.4.0"
  $ProgressPreference = "SilentlyContinue"
  [Net.ServicePointManager]::SecurityProtocol = [Net.ServicePointManager]::SecurityProtocol -bor [Net.SecurityProtocolType]::Tls12
  $arch = if ($env:PROCESSOR_ARCHITECTURE -eq "ARM64") { "arm64" } else { "amd64" }
  $base = "https://github.com/F-F-WP/homebrew-public/releases/download/ax-link-v$version"
  $work = Join-Path $env:TEMP "ax-link-$version"
  New-Item -ItemType Directory -Force -Path $work | Out-Null
  Invoke-WebRequest -UseBasicParsing "$base/checksums.txt" -OutFile "$work\checksums.txt"
  $checksums = Get-Content "$work\checksums.txt"
  # arm64 archive가 없는 이전 버전은 Windows의 x64 에뮬레이션으로 amd64를 사용합니다.
  $name = "ax-link_${version}_windows_$arch.zip", "ax-link_${version}_windows_amd64.zip" |
    Where-Object { $n = $_; $checksums | Where-Object { ($_ -split "\s+")[-1] -eq $n } } | Select-Object -First 1
  if (-not $name) { throw "checksums.txt에서 Windows archive를 찾을 수 없습니다" }
  $expected = (($checksums | Where-Object { ($_ -split "\s+")[-1] -eq $name }) -split "\s+")[0]
  Invoke-WebRequest -UseBasicParsing "$base/$name" -OutFile "$work\$name"
  $actual = (Get-FileHash -Algorithm SHA256 "$work\$name").Hash
  if ($actual -ne $expected) { throw "SHA-256 검증 실패: $name" }
  $installDir = Join-Path $env:LOCALAPPDATA "Programs\ax-link"
  Expand-Archive -Force -Path "$work\$name" -DestinationPath $installDir
  Unblock-File "$installDir\ax-link.exe"
  # %USERPROFILE% 같은 변수가 든 기존 Path 항목을 풀어 쓰지 않도록 레지스트리 원문을 읽고 그대로 씁니다.
  $envKey = [Microsoft.Win32.Registry]::CurrentUser.OpenSubKey("Environment", $true)
  $userPath = $envKey.GetValue("Path", "", [Microsoft.Win32.RegistryValueOptions]::DoNotExpandEnvironmentNames)
  if (($userPath -split ";") -notcontains $installDir) {
    $envKey.SetValue("Path", ((@($userPath, $installDir) | Where-Object { $_ }) -join ";"), [Microsoft.Win32.RegistryValueKind]::ExpandString)
    # 새로 여는 터미널·앱이 바뀐 Path를 받도록 환경 변수 변경 알림을 보냅니다.
    [Environment]::SetEnvironmentVariable("AX_LINK_PATH_REFRESH", "1", "User")
    [Environment]::SetEnvironmentVariable("AX_LINK_PATH_REFRESH", $null, "User")
  }
  $envKey.Close()
  $env:Path = "$installDir;$env:Path"
  ax-link version
}
```

- 설치 전에 이미 열려 있던 터미널·Orca·Paseo는 새 `Path`를 모르므로 다시 열어야 합니다.
- 업데이트 중 `ax-link.exe`를 덮어쓸 수 없으면 실행 중인 `ax-link`(Paseo의 OMP 연결 포함)를 종료한 뒤 다시 실행합니다.
- AX Link CLI `1.4.0`부터 Windows의 Orca 앱(`%LOCALAPPDATA%\Programs\Orca`)과 Paseo 앱
  (`%USERPROFILE%\.local\bin\paseo.cmd`, `%LOCALAPPDATA%\Programs\Paseo`)에 포함된 CLI를 PATH에 없어도 자동으로 찾습니다.
  Paseo가 agent로 실행하는 `opencode`·`omp`는 `Path`에 있어야 합니다.
- WSL 안의 agent는 WSL 안에서 Linux 바이너리를 설치하고 따로 setup합니다.

AX Link에 로그인한 뒤 사용할 환경을 연결합니다.

```bash
ax-link login
ax-link key select

# 사용하는 대상 하나를 선택합니다.
ax-link setup paseo
ax-link setup orca
ax-link setup opencode
ax-link setup omp
```

연결된 키가 허용하는 모델과 로컬 반영 상태는 대상별로 확인할 수 있습니다. 새 모델이 아직 반영되지 않았거나
기존 모델이 남아 있으면 CLI가 실행할 `sync` 명령을 함께 안내합니다.

```bash
ax-link models paseo
ax-link models orca
ax-link models opencode
ax-link models omp
```

`sync`에서 HTTP 401이 발생하면 오류에 표시된 `ax-link setup <target>`으로 현재 선택된 키를 다시 연결한 뒤
`ax-link doctor <target>`으로 상태를 확인합니다.

macOS에서 DMG로 Paseo Desktop을 설치했다면 AX Link CLI `1.2.2` 이상이 `/Applications/Paseo.app` 또는
`~/Applications/Paseo.app`의 공식 번들 CLI를 자동으로 찾습니다. AX Link 연결을 위해 Paseo를 Homebrew나 npm으로
다시 설치할 필요는 없습니다.

AX Link CLI `1.3.0`부터 Orca에서 **OpenCode agent**로 연결할 수 있습니다. Orca와 OpenCode CLI를 설치한 뒤
`ax-link setup orca`를 실행하고, Orca의 새 OpenCode agent에서 `/models` → AX Link 모델을 선택합니다.
`sync orca`, `models orca`, `doctor orca`로 연결을 관리할 수 있습니다.

Orca와 같은 호스트·사용자 환경에서 실행하세요. 원격 호스트·WSL은 해당 환경 안에서 setup해야 합니다.
OpenCode 설정과 인증정보를 공유하므로 `uninstall orca`는 같은 정보를 쓰는 OpenCode·Paseo 연결도 해제합니다.

등록된 키가 여러 개라면 `↑` / `↓`로 이동해 `Enter`로 선택합니다. `j` / `k` 이동도 지원하며, `q` 또는
`Ctrl+C`로 기존 선택을 유지한 채 취소할 수 있습니다.

`ax-link setup`은 provider 연결 설정까지만 담당합니다. Paseo, Orca, OpenCode, OMP 및 이를 사용하는 다른 제품의
설치·실행·권한 관리·데이터 처리는 각 제품과 사용자의 책임입니다.

## 무결성 확인

Release에는 플랫폼별 archive와 `checksums.txt`가 함께 제공됩니다. Homebrew Formula도 아키텍처별 SHA-256을
고정해 다운로드 파일을 검증합니다.

```bash
brew test F-F-WP/public/ax-link
```

## 지원 범위

이 저장소는 공개 배포 진입점입니다. 제품 기능과 계정·권한 문의는 각 제품의 공식 지원 채널을 이용해 주세요.
