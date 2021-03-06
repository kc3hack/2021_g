# Smart Box

[![KC3Hack](https://kc3.me/hack/wp-content/uploads/2021/01/kc3hack2021ogp@2x.png)](https://kc3.me/hack)

## プロダクト名

QR コードで収納管理をするアプリケーション　**SmartBox**

## プロダクト説明

### 背景

モノの収納について、誰しもが「モノをどこにしまったかわからなくなる」という経験がある。

それを解決する方法として 従来の生活術「**ラベリング収納**」というものが！  
（ラベリング収納：紙に箱の中身を手書きで記入し、箱に貼り付ける収納術）

しかし、このラベリング収納には「**あともう一押し！**」の課題があります。

- 紙 1 枚に書ける箱の中のアイテム数は限られており、情報量が少ない
- 手書きだとアイテムの追加削除の編集が難しい
- 箱のラベル紙を見れば誰でも中身を知ることができるため、プライバシーの保護ができない

以上 3 点の課題を解決する、これからの新しいラベリング収納は、  
->　**スマホアプリ × 管理 × プライバシー**

-----> QR コードで収納管理が行えるアプリ**SmartBox**を開発！

### 主な機能

- ＱＲコード読み取り
- アイテムの追加削除
- ＱＲコードの画像保存（->LINE の公式トークに送信でコンビニ等で印刷可能）

### ターゲット

- モノの管理をプライバシーを保護しつつ、アイテムの管理もしつつ行いたいユーザー向け

### コアバリュー

- 従来の紙媒体でのラベリング収納に比べて**情報量を多く**管理ができる
- プライバシーを保護しつつモノの管理ができる

### 発展性

- 郵便物 × SmartBox  
  … 普段届く郵便物も SmartBox を使えば、段ボールの中身をプライバシーを保護しつつ管理可能に
- モノ探し × SmartBox + 検索機能  
  … 最初にボックスの登録さえしてしまえば、SmartBox 内でアイテム検索するだけで効率化が可能に

## 技術説明

- [機能一覧](https://github.com/kc3hack/2021_g/wiki/Features)
- [開発用語集](https://github.com/kc3hack/2021_g/wiki/Glossary)

### エンジニア

#### フロントエンド

- Flutter

#### バックエンド

- 言語：Golang
  - ORM：[go-gorm/gorm](https://github.com/go-gorm/gorm)
  - web フレームワーク：[labstack/echo](https://github.com/labstack/echo)
  - Openapi からコントローラーの自動生成：[deepmap/oapi-codegen](https://github.com/deepmap/oapi-codegen)
  - アーキテクチャ：クリーンアーキテクチャベース
  - QR コード作成：[yeqown/go-qrcode](https://github.com/yeqown/go-qrcodes)
  - ホットリロード：[oxequa/realize](https://github.com/oxequa/realize)
- API ドキュメント：Swagger
  - ビューワー：Swagger Viewer（[こちら](https://kc3hack.github.io/2021_g/openapi_viewer/index.html#/)）
  - モックサーバー：Postman
- DB：MySQL
  - [ER 図](https://github.com/kc3hack/2021_g/wiki/ER)
- コンテナオーケストレータ：Docker Compose
- CI/CD：Github Action
  - golangci-lint
- 認証：AWS cognito
- サーバ構成：(Client) -> ALB <-> cognito -> EC2 -> RDS

### デザイナー

UI/UX

- テーマカラーは#7AD0CE。生活になじむような色を意識。

- アプリケーションの操作において、重要度の高い「QR コード読み取り」「ボックスの一覧表示」「QR コード印刷」をボトムナビゲーションバーにボタンとして設置。ユーザーはボトムナビゲーションバーから簡単に主要な操作を行うことができるようになる。

- アイテム・ボックス追加ボタンは、アクセントカラーの#EE989D で目立たせる配色にして、ユーザーにアイテム・ボックス追加機能を分かりやすくみせる。

ロゴ

- 段ボールの中身をこのアプリケーションでスキャンすることで可視化できるということをイメージしたデザイン
- テーマカラーを基調とした配色

その他

- プロトタイプレビュー（https://xd.adobe.com/view/81203d16-2656-4cde-b740-0a7060b47641-d473/)
- プレゼン資料レビュー（https://drive.google.com/file/d/1wPc10BsXp02PAGS-PYOGuN4_ChcSyI9D/view?usp=sharing）

## 使用技術

Flutter + AWS ?

デザイン：Xd、AdobeIllustrator

## ドキュメント

- API: https://kc3hack.github.io/2021_g/openapi_viewer/index.html
- DB: https://github.com/kc3hack/2021_g/wiki/ER
