# README
# ネコ専用動画・画像投稿SNS『MEW』
![logo](https://user-images.githubusercontent.com/59902916/88170474-b9865b80-cc58-11ea-94ac-a3fedc4f7deb.jpg)

## http://www.mewjp.com/
# 概要
本アプリケーションはネコ好きが集い自分のお気に入り画像・動画を投稿し共有する、ソーシャルネットワーキングサービスです。

開発目的は殺処分問題改善に貢献する事です。

捨てられたりペットショップで売れ残ったネコは、次の里親や保護先が見つからない場合、保健所で殺処分されてしまいます。

本アプリケーション上に良質なネコ飼い主コミュニティを形成。動物愛護センターに保護されているネコと譲受人のマッチングを図る事で、問題改善に貢献出来ればと思い開発しました。

# 本番環境
- デプロイ先 : Amazon EC2
- ログイン画面下部に「ゲストユーザーとしてログイン」を実装
 
# 開発経緯
1. 譲受人を増やす事で殺処分数を減らす
    - 本アプリケーションのSNS機能でユーザー間の交流を促し、良質なネコ飼い主コミュニティを形成する。
      - コミュニテイの新規参入者を増やし、保護されているネコと譲受人のマッチングを図る。
      - 良質なコミュニティを形成する事で、悪戯や悪意あるユーザーが入ることを防ぐ。
1. ネコ好きの人に楽しんでもらう
    - ユーザーが飼っているネコの画像・動画を投稿し、いいねやコメントをもらう事で承認欲求を満たしてもらう。
    - 共通の好きな事があるユーザー同士で繋がりを持ってもらう
1. ユーザーにYouTubeのネコアカウントを開設促し、運営が動画編集を受注する
    - ネコの日常をスマートフォンで撮影する事から初められるので、YouTubeの参入障壁が低い。
      - 保護されているネコや譲渡されたネコの様子を動画で公開すれば、殺処分問題の浸透に繋がる(YouTubeに動画を公開している施設あり)

# DEMO
## 画像・動画投稿機能
![DEMO1](https://user-images.githubusercontent.com/59902916/88168920-1a606480-cc56-11ea-9ed1-595d9d300d97.gif)

## コメント いいね お気に入り登録機能
![DEMO2](https://user-images.githubusercontent.com/59902916/88169016-4a0f6c80-cc56-11ea-966e-02e6de078975.gif)

## 動物愛護センター位置、サイト情報検索機能
![DEMO3](https://user-images.githubusercontent.com/59902916/88169028-50054d80-cc56-11ea-85d4-882ada2fc985.gif)

# 工夫したポイント
- 動物愛護センター位置とサイト情報が直感的に分かりやすくする為、Google Maps APIを用いて検索機能を実装した
- いいねやフォロー機能にAjaxを使用しUXにも気を配った

# 機能一覧
- 画像投稿機能
- 動画投稿機能
- フォロー機能
- いいね機能
- お気に入り登録
- コメント機能
- 動物愛護センター位置、サイト情報検索機能
- 投稿検索
- ユーザー検索機能
- ダイレクトメッセージ機能
- ユーザー登録、更新、削除
- プロフィール画像登録と更新
- YouTubeチャンネルURL登録機能
- ログイン/ログアウト機能

# 使用技術
## フロントエンド
- HTML/CSS
- Haml
- Scss
- jQuery
- bootstrap4
## バックエンド
- Ruby 2.6.5
- Ruby on Rails 6.0.3.2
## インフラ
- AWS
  - EC2
  - S3 
  - Route 53
- MySQL 5.6
- nginx 1.16.1
- Docker, docker-compose
- CircleCI, Capistrano (CI/CD)

## API
- Google Maps JavaScript

# 課題や今後実装したい機能
- グループ作成
- 画像トリミング機能
- 施設寄付の決済機能(PAY.JP API)

# DB設計
## ER図
![mew_erdb](https://user-images.githubusercontent.com/59902916/88169608-2ef12c80-cc57-11ea-805f-3d3e8d05f0ae.jpg)
## Userテーブル
|Column|Type|Options|
|------|----|-------|
|name|string|null: false|
|email|string|null: false|
|encrypted_password|string|null: false|
|profile|text||
|image|text||
|youtube|text||

### Association
- has_many :posts
- has_many :relationships
- has_many :comments
- has_many :like_relationships
- has_many :favorite_relationships
- has_many :messages
- has_many :entries


## Postテーブル
|Column|Type|Options|
|------|----|-------|
|content|text||
|picture|text||
|user_id|bigint|null: false|

### Association
- has_many :comments
- has_many :like_relationships
- has_many :favorite_relationships
- belongs_to :user


## Commentテーブル
|Column|Type|Options|
|------|----|-------|
|text|text||
|user_id|integer|null: false|
|post_id|integer|null: false|

### Association
- belongs_to :user
- belongs_to :post

## relationshipsテーブル
|Column|Type|Options|
|------|----|-------|
|follower_id|integer||
|followed_id|integer||

### Association
- belongs_to :follower
- belongs_to :followed


## Like_relationshipsテーブル
|Column|Type|Options|
|------|----|-------|
|user_id|integer||
|post_id|integer||

### Association
- belongs_to :user
- belongs_to :post

## favorite_relationshipsテーブル
|Column|Type|Options|
|------|----|-------|
|user_id|integer||
|post_id|integer||

### Association
- belongs_to :user
- belongs_to :post


## Messageテーブル
|Column|Type|Options|
|------|----|-------|
|body|text||
|user_id|integer|null: false|
|room_id|integer|null: false|

### Association
- belongs_to :user
- belongs_to :room


## Entryテーブル
|Column|Type|Options|
|------|----|-------|
|user_id|integer|null: false|
|room_id|integer|null: false|

### Association
- belongs_to :user
- belongs_to :room

## Roomテーブル
|Column|Type|Options|
|------|----|-------|
|name|string||

### Association
- has_many :messages
- has_many :entries