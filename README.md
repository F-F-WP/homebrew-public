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

AX Link에 로그인한 뒤 사용할 환경을 연결합니다.

```bash
ax-link login
ax-link key select

# 사용하는 대상 하나를 선택합니다.
ax-link setup paseo
ax-link setup opencode
ax-link setup omp
```

등록된 키가 여러 개라면 `↑` / `↓`로 이동해 `Enter`로 선택합니다. `j` / `k` 이동도 지원하며, `q` 또는
`Ctrl+C`로 기존 선택을 유지한 채 취소할 수 있습니다.

`ax-link setup`은 provider 연결 설정까지만 담당합니다. Paseo, OpenCode, OMP 및 이를 사용하는 다른 제품의
설치·실행·권한 관리·데이터 처리는 각 제품과 사용자의 책임입니다.

## 무결성 확인

Release에는 플랫폼별 archive와 `checksums.txt`가 함께 제공됩니다. Homebrew Formula도 아키텍처별 SHA-256을
고정해 다운로드 파일을 검증합니다.

```bash
brew test F-F-WP/public/ax-link
```

## 지원 범위

이 저장소는 공개 배포 진입점입니다. 제품 기능과 계정·권한 문의는 각 제품의 공식 지원 채널을 이용해 주세요.
