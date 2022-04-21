# README
| tasks            |             |         |          |       |         |                                   |                           |
|------------------|-------------|---------|----------|-------|---------|-----------------------------------|---------------------------|
| No               | 物理名         | 論理名     | 型        | Null  | Default | Enum                              | Enum(ja)                  |
| 1                | id          | ID      | bigint   | FALSE |         |                                   |                           |
| 2                | name        | タスク名    | string   | FALSE |         |                                   |                           |
| 3                | body        | タスク本文   | text     | FALSE |         |                                   |                           |
| 4                | priority    | 優先順位    | integer  | FALSE | 0       | 0:none,1:first, 2:second, 3:third | 0:未設定,1:一番目, 2:二番目, 3:三番目 |
| 5                | ended_at    | 終了期限    | datetime |       |         |                                   |                           |
| 6                | status      | タスク状態   | integer  | FALSE | 0       | 0:new, 1:doing, 2:done            | 0:未着手, 1:着手, 2:完了         |
| 7                | created_at  | 作成日時    | datetime | FALSE |         |                                   |                           |
| 8                | updated_at  | 更新日時    | datetime | FALSE |         |                                   |                           |
|                  |             |         |          |       |         |                                   |                           |
|                  |             |         |          |       |         |                                   |                           |
| categories       |             |         |          |       |         |                                   |                           |
| No               | 物理名         | 論理名     | 型        | Null  | Default | Enum                              | Enum(ja)                  |
| 1                | id          | ID      | bigint   | FALSE |         |                                   |                           |
| 2                | name        | カテゴリー名  | string   | FALSE |         |                                   |                           |
| 3                | created_at  | 作成日時    | datetime | FALSE |         |                                   |                           |
| 4                | updated_at  | 更新日時    | datetime | FALSE |         |                                   |                           |
|                  |             |         |          |       |         |                                   |                           |
| tasks_categories |             |         |          |       |         |                                   |                           |
|                  | 物理名         | 論理名     | 型        | Null  | Default | Enum                              | Enum(ja)                  |
| 1                | id          | ID      | bigint   | FALSE |         |                                   |                           |
| 2                | task_id     | タスクID   | bigint   | FALSE |         |                                   |                           |
| 3                | category_id | カテゴリーID | bigint   | FALSE |         |                                   |                           |
| 4                | created_at  | 作成日時    | datetime | FALSE |         |                                   |                           |
| 5                | updated_at  | 更新日時    | datetime | FALSE |

https://docs.google.com/spreadsheets/d/1WnTMVYiDN5R3grtdywfOnJnu0dr0nVgXxxIWjl8SCjs/edit#gid=0

* Ruby,Rails,PostgreSQL version
ruby 3.0.1
rails 6.1.4.1
psql 14.0