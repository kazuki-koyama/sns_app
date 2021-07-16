# Change  -変化を楽しむSNS-
![screen_sample](https://user-images.githubusercontent.com/78887569/123628116-b4a92f00-d84d-11eb-836f-71edfe719d9e.png)

## サイト概要
様々なビフォーアフター写真を投稿し、その変化を見て楽しむことができるSNSサービスです。

### サイトテーマ
すべての変化が、ここに。

### テーマを選んだ理由
"変化"には、成長や努力が現れます。<br>
私自身、未経験からエンジニアになるという大きな変化を決断し、Twitterなどで同じ目標を持つ人の投稿を見て励まされることが少なからずありました。<br>
変わろうとする、成長しようと努力する人同士をつなげ、応援したい。<br>
そんな想いからこのサービスを制作しました。

### ターゲットユーザ
- 年齢：10~30代
- 性別：男女問わず
- 変わりたい・成長したいと思っている人

### 主な利用シーン
- 目標に向けてモチベーションを高めたいとき
- 同じ目標を持つ人と繋がりたいとき

## 機能一覧
- ユーザー側
  - ユーザー認証（新規登録/退会/ログイン/ログアウト）
  - マイページ(閲覧/編集)
  - ゲストログイン
  - 投稿（画像アップロード/一覧表示/詳細表示/編集/削除）
  - いいね
  - コメント
  - ブックマーク（作成/削除/一覧表示）
  - フォロー（フォローする/フォローを外す/フォロー・フォロワーの一覧表示）
  - ハッシュタグ
  - 検索（ユーザー名検索/ハッシュタグ検索）
- 管理者側
  - ユーザー認証（ログイン/ログアウト）
  - ユーザー管理（一覧表示/詳細表示/編集）

その他詳細は[こちら](https://docs.google.com/spreadsheets/d/1bsTQFALETAqbOK16tfoBhx-Z_YkoiaoQ10dfZgg9UGY/edit?usp=sharing)をご覧ください。

## 取り入れた技術
- Webサーバーを冗長化し、ALBで負荷を分散
- 画像をLambdaでリサイズし、S3に保存（画像の種類によりそれぞれリサイズ幅を設定）
- Github Actionsで自動デプロイ
- RuboCopで静的解析を実施
- RSpecでテストを実施
- bulletでN+1問題を検出し、解消

## インフラ構成図
![AWS_architecture](https://user-images.githubusercontent.com/78887569/126017078-803267c7-5ba1-421c-8170-041de9db6328.png)

## ER図
![ER_change](https://user-images.githubusercontent.com/78887569/126017003-b27a71e7-40a9-48a6-821f-6a69c8bf8c4b.png)

## 開発環境
- OS：Linux(CentOS)
- 言語：HTML,CSS,JavaScript,Ruby,SQL
- フレームワーク：Ruby on Rails
- JSライブラリ：jQuery
- IDE：Cloud9
