# Sui CLI Overview

### 터미널에서 sui 명령어 실행 시 나오는 출력 화면

```bash
sui
```

![the screen that appears when running the sui command ](/images/sui-command-output.png)

### Sui 명령어의 하위 명령어들(Sub Commands)

![sub commands of sui command](/images/sub-commands-of-sui.png)

다음과 같이 실행할 수 있다.

```bash
sui start
sui network
sui genesis
sui keytool
sui client
sui move
...
```

많이 쓰이는 하위 명령어는 `client`, `keytool`, `move` 등이 있다.

```bash
sui client
sui keytool
sui move
```

# 많이 쓰이는 명령어

### sui client

- `sui client addresses`: `Sui CLI`로 관리하는 address들을 출력한다.
  ```bash
  sui client addresses
  ```
- `sui client new-address`: 새 address를 생성한다. 어떤 key scheme(암호화 알고리즘)으로 생성할지와 address 별명(alias)을 설정할 수 있다.

  ```bash
  Usage:
  sui client new-address <KEY_SCHEME> [ALIAS] [WORD_LENGTH] [DERIVATION_PATH]

  Help)
  sui client new-address --help

  Ex1)
  sui client new-address ed25519

  Ex2)
  sui client new-address ed25519 test-account
  ```

- `sui client envs`: `Sui CLI`가 network 통신 할 노드 주소 리스트를 출력한다. 현재 env가 어떤 testnet 노드 중 하나로 설정되어 있다면 testnet으로 트랜잭션을 보낼 것이고, mainnet 노드 중 하나로 설정되어 있다면 mainnet으로 트랜잭션을보낼 것이다.
  ```bash
  sui client envs
  ```
- `sui client new-env`

  ```bash
  Usage:
  sui client new-env --alias <ALIAS> --rpc <RPC>

  Ex1)
  sui client new-env --alias sui-mainnet --rpc https://fullnode.mainnet.sui.io:443

  Ex2)
  sui client new-env --alias suiscan-testnet --rpc https://rpc-testnet.suiscan.xyz:443
  ```

- `sui client switch`: 현재 `active-address`나 `active-env`를 다른 것으로 변경할 때 사용하는 명령어이다.

  ```bash
  Usage:
  sui client switch [OPTIONS]

  Options:
  --address <ADDRESS_ALIAS>
  --env <ENV_ALIAS>

  Ex1)
  sui client switch --address boring-cymophane

  Ex2)
  sui client switch --env sui-mainnet
  ```

- `sui client gas`: 현재 `active address`가 소유하고 있는 gas object(Sui Coin Object)의 리스트를 출력한다.

  ```bash
  Usage:
  sui client gas [OPTIONS] [owner_address]

  Ex1)
  sui client gas

  Ex2)
  sui client gas 0x23c11df86fad8d628fe9b7fb6bf0b27be231f995b476ae1cff2a227575e96fad
  ```

- `sui client balance`: 현재 `active address`가 소유한 `sui coin`의 `balance`의 총 합을 출력한다.

  ```bash
  Usage:
  sui client balance [OPTIONS] [ADDRESS]

  Ex1)
  sui client balance

  Ex2)
  sui client balance 0x23c11df86fad8d628fe9b7fb6bf0b27be231f995b476ae1cff2a227575e96fad
  ```

- `sui client transfer-sui`: `sui coin`을 다른 `address`로 보낼 수 있다.

  ```bash
  Usage)
  sui client transfer-sui --to <TO> --sui-coin-object-id <SUI_COIN_OBJECT_ID>

  Ex0)
  // sui coin object id는 sui gas 명령어로 알 수 있다.
  sui client transfer-sui --to <ADDRESS> --sui-coin-object-id <SUI_COIN_OBJECT_ID> --amount <AMOUNT> --gas-budget <GAS_BUDGET_AMOUNT>

  Ex1)
  sui client transfer-sui --to 0x23c11df86fad8d628fe9b7fb6bf0b27be231f995b476ae1cff2a227575e96fad --sui-coin-object-id 0x3b5b7f0d576d3843438ecb163d3fbc2f3531f90e2c5400e38234e586d84f181f --amount 100000 --gas-budget 10000000
  ```

- `sui client publish`: `move package`를 배포할 때 사용한다.

  ```bash
  Usage:
  sui client publish [OPTIONS] [package_path]

  Ex1)
  sui client publish

  Ex2)
  sui client publish ~/Github/some-move-project/

  ```

### sui move

- `sui move new`: 새로운 `move package` 폴더를 생성한다.

  ```bash
  Usage:
  sui move new <NAME>

  Ex1)
  sui move new my_new_move
  ```

- `sui move test`: `move package`의 `tests` 폴더에 있는 test 파일들을 실행한다.

  ```bash
  Usage:
  sui move test [OPTIONS] [filter]

  Ex1)
  sui move test

  Ex2)
  sui move test --path ./my_new_move
  ```

- `sui move build`: 새로운 move package 폴더를 생성한다.

  ```bash
  Usage:
  sui move build [OPTIONS]

  Ex1)
  sui move build

  Ex2)
  sui move build --path ./my_new_move
  ```

### sui keytool

- `sui keytool list`: `Sui CLI`가 관리하는 모든 address의 정보를 출력한다.

  ```bash
  Usage:
  sui keytool list [OPTIONS]

  Help)
  sui keytool list --help

  Ex1)
  sui keytool list
  ```

- `sui keytool export`: `Sui CLI`가 관리하는 address 중 하나의 `private key`를 출력한다.

  ```bash
  Usage:
  sui keytool export [OPTIONS] --key-identity <KEY_IDENTITY>

  Help)
  sui keytool export --help

  Ex1)
  sui keytool export --key-identity priceless-epidote
  ```

- `sui keytool import`: `Sui CLI` 외부에서 생성한 주소를 `Sui CLI`가 관리할 수 있도록 등록한다.

  ```bash
  Usage:
  sui keytool import [OPTIONS] <INPUT_STRING> <KEY_SCHEME> [DERIVATION_PATH]

  **INPUT_STRING은 mnemonic 또는 privatkey

  Ex1)
  sui keytool import "nephew apple grunt retreat easy toe social hold green flight rug banana" ed25519

  Ex2)
  sui keytool import suiprivkey1qqykwkabafdbdcbadbadcbdcbadfbadfbadfbadfbadfb ed25519

  ```
