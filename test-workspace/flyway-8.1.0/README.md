# flyway-8.1.0 テスト用ワークスペース

```bash
# テーブルの確認。まず、テーブルが作られていないのを確認できる。
./show_tables.sh

# flywayの実行
./flyway_migrate.sh

# テーブルの確認。テーブルが作成されているのを確認できる。
./show_tables.sh
```
