# README
# ネコ専用動画・画像投稿SNS『MEW』
http://www.mewjp.com/
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
gifで動画や写真を貼って、ビューのイメージを掴んでもらいます

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
## API
- Google Maps JavaScript
## インフラ
- AWS
  - EC2
  - S3 
  - Route 53
- MySQL 5.6
- nginx 1.16.1

# 課題や今後実装したい機能
- グループ作成
- 画像トリミング機能
- 施設寄付の決済機能(PAY.JP API)

# DB設計

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