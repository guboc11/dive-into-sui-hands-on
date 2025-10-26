# Overview (추천하는 방법)

![Sui CLI Installation Overview Structure](/images/sui-cli-overview.png)

# Homebrew로 Sui CLI 설치하기 (Mac, Linux 기준)

> **Windows 사용자**는 WSL을 이용하여 Linux를 설치한 후 Sui CLI를 설치하는 것을 권장합니다.

### Homebrew 설치하기

1. [Homebrew 링크](https://brew.sh/)를 클릭하여 Homebrew 홈페이지 접속한다.
2. `Install Homebrew` 아래에 적힌 명령어를 복사하여 터미널에 붙여넣고 실행한다.
   ```bash
   /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
   ```
3. 터미널에 `brew -v`를 입력하고 실행하였을 때 homebrew 버전이 출력되면 설치가 잘 된 것이다. update를 한 번 실행한다.

   ```bash
   brew -v
   brew update
   ```

### Sui CLI 설치하기

4. `brew`를 이용해 `sui cli`를 설치한다.

   ```bash
   brew install sui
   ```

5. `sui --version` 명령어를 실행했을 떄 버전이 나오면 잘 설치된 것이다.
   ```bash
   sui --version
   ```
