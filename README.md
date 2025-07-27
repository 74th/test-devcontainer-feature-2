# Dev Container Feature のテスト

以下のテンプレートを使用

https://github.com/devcontainers/feature-starter

## flyway-8.1.0 を作ってみた

### テンプレートからの変更

- src/color, test/color を削除
- src/hello, test/hello を hello -> flyway-8.1.0名前にリネーム
- .github/workflows/test.yaml にfeaturesの記載があるので、colorを削除、hello -> flyway-8.1.0 に変更

### GitHub Actionsで動かなかったやつ

.github/workflows/release.yaml の変更点PR作るやつが動かない。以下の記述に変えた。

```
git rebase origin/"$branch" || git merge origin/"$branch"
```

↓

```
if git ls-remote --exit-code --heads origin "$branch"; then
    git fetch origin "$branch"
    git rebase origin/"$branch" || git merge origin/"$branch"
fi
```

### devcontainer-feature.json の記述

name, idを記述する。versionは、GitHub Packages上必ずバージョンを変えないといけ内っぽく、0.0.1 と一旦しておく。

```json
{
  "name": "flyway-8.1.0",
  "id": "flyway-8.1.0",
  "version": "0.0.1",
  "description": "A flyway feature",
  "options": {},
  "containerEnv": {
    "PATH": "/flyway:${PATH}"
  },
  "installsAfter": ["ghcr.io/devcontainers/features/common-utils"]
}
```

- 環境変数の設定は devcontainer-feature.json の `containerEnv` に追加する

### テストの作成

test/flyway-8.1.0に test.sh, <シナリオ名>.sh, duplicate.sh を作成

一旦全部同じ内容でよさそう。

scenarios.json は以下のように記述。

```json
{
    "ubuntu": {
        "image": "mcr.microsoft.com/devcontainers/base:ubuntu",
        "features": {
            "flyway-8.1.0": {}
        }
    }
}
```

scenarios.jsonとubuntu.shを削除すれば、追加シナリオなしでテストが動いてくれてる。

### テストの実行

テストは以下のコマンドで実施

```
devcontainer features test --features flyway-8.1.0
```

### 重複インストールへの対応

duplicate.sh は、重複インストールをテストするのに使われる。

install.sh に重複を入れる

```bash
if [ -d "/flyway" ]; then
  echo "Flyway is already installed"
  exit 0
fi
```
