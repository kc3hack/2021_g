# データベース構成（MySQL）

- pr: primary key, 該当するものには o を書く
- uq: unique key, 該当するものには数字を書く、同じ数字は複合 unique key
- fk: foreign key, テーブルを書く

## hoge

| name      | Type     | pr  | required | uq  | fk(onupdate, ondelete) | default | description |
| --------- | -------- | --- | -------- | --- | ---------------------- | ------- | ----------- |
| id        | int      | o   | True     |
| createdAt | Datetime |     | True     |
| updatedAt | Datetime |     | True     |
| deletedAt | Datetime |     | True     |
| name      | string   |     | True     |
