# プロジェクト名：『PinPoint』
<img width="500" src="app/assets/images/ogp.png"><br>
<br>

# 目次
- [サービス概要](#サービス概要)
- [サービスURL](#サービスurl)
- [サービス開発の背景](#サービス開発の背景)
- [機能紹介](#機能紹介)
- [技術構成について](#技術構成について)
  - [使用技術](#使用技術)
  - [ER図](#er図)
  - [画面遷移図](#画面遷移図)<br>
<br>

# サービス概要
地図に任意のピンを複数刺してオリジナルのマップを作ることができるサービスです。
ピンにはそれぞれ画像や文章を添えることができるので、ピンを刺した場所の情報や思い出の記録として使えます。
作成したマップは投稿したり共有することができるので投稿一覧から気になるエリアの情報を探したり、
友人との外出する際の目的地の共有などに使うことができます

# サービスURL
### https://pinpoint-map.com<br>
<br>

# サービス開発の背景
私は、外出で訪れる場所で買い物や食事をするときに、現地で探すことがよくあります。<br>
ですが、現地にいながら行きたい場所を探すのも、見つけた場所に行こうとして住所を検索して経路を確認するのも意外と大変です。<br>
こういった経験から、地図を見ながら周辺の行きたい場所を探すことが出来るようなアプリを開発する事にしました。<br>

そこで、私はSNSの機能と地図を組み合わせることを思いつきました。<br>
地図を見ながら行きたい場所を探せるようにするといっても、その数えきれないような情報を自分一人で集めてアプリの地図に表示させるのは現実的ではありません。<br>
しかしSNSという形式にすれば、ユーザーさえいれば常に最新の情報が勝手に集まってくるため、SNSの形式にすることにしました。<br>
<br>

# 機能紹介

・ログイン不要
<br>

| トップページ |
| :---: | 
| [![Image from Gyazo](https://i.gyazo.com/447c1ab9fef88dab9bc7c165ae892439.png)](https://gyazo.com/447c1ab9fef88dab9bc7c165ae892439) |
| <p align="left">画面左側のタイムラインの投稿をクリックすることで投稿されたマップを閲覧することができます。<br> ピンをクリックすることで詳細が表示されます。<p> |
<br>
・ログインが必要

| 投稿機能 |
| :---: | 
| [![Image from Gyazo](https://i.gyazo.com/c0ecf1b17d5d1ce0d7ebdc5e859b4cb7.gif)](https://gyazo.com/c0ecf1b17d5d1ce0d7ebdc5e859b4cb7) |
| <p align="left">投稿画面では投稿したい内容を入力し、フォーム右下の投稿ボタンをクリックすることでマップを投稿できます。<br> 座標がわからない場合は住所を入力後、右にある検索ボタンをクリックすることで自動で入力されます。<p> |
| [![Image from Gyazo](https://i.gyazo.com/218154bc098e803ab43e356325be5c39.gif)](https://gyazo.com/218154bc098e803ab43e356325be5c39) |
| <p align="left">２つ以上ピンを追加したい場合は「ピンを追加」というボタンをクリックすることで新しい入力フォームが追加されていきます。<br> 必要ない場合は削除をクリックしてください。<p> |
<br>

| 編集/削除機能 |
| :---: | 
| [![Image from Gyazo](https://i.gyazo.com/6c617ab46007bb27e701dc9e4b9e0abd.gif)](https://gyazo.com/6c617ab46007bb27e701dc9e4b9e0abd) |
| <p align="left">自身の投稿は編集することができます。<br> 編集画面ではマップの名前の変更、ピンの追加、ピンの編集が可能です。<p> |
| [![Image from Gyazo](https://i.gyazo.com/eab8aacce9df3dc197468acb775ac896.gif)](https://gyazo.com/eab8aacce9df3dc197468acb775ac896) |
| <p align="left">作成したマップを削除することができます。<p> |
<br>

| プロフィール機能 |
| :---: | 
| [![Image from Gyazo](https://i.gyazo.com/09ebde0841cb6eb5165522a6bb138027.gif)](https://gyazo.com/09ebde0841cb6eb5165522a6bb138027) |
| <p align="left">ヘッダー右端のプロフィール画像からタブを表示させ、自身のアカウント名をクリックするとプロフィールを確認できます。<br> プロフィールの編集ではアカウント名の変更とプロフィール画像の設定が可能です。<p> |
<br>

| マイページ機能 |
| :---: | 
| [![Image from Gyazo](https://i.gyazo.com/06e1200e04aab92cb703e8ebadbaecb2.gif)](https://gyazo.com/06e1200e04aab92cb703e8ebadbaecb2) |
| <p align="left">ヘッダー右端のプロフィール画像からタブを表示させ、マイページをクリックすると自身の投稿とお気に入りにした投稿を確認できます。<p> |
<br>

| ログアウト |
| :---: | 
| [![Image from Gyazo](https://i.gyazo.com/f6e00c33c690a944be68af3b7201e36b.gif)](https://gyazo.com/f6e00c33c690a944be68af3b7201e36b) |
| <p align="left">ヘッダー右端のプロフィール画像からタブを表示させ、ログアウトをクリックするとログアウトすることができます。<p> |
<br>

# 技術構成について

## 使用技術
| カテゴリ | 技術内容 |
| --- | --- | 
| バックエンド | Ruby 3.3.5 / Ruby on Rails 8.0.1（APIモード） |
| フロントエンド | JavaScript |
| CSSフレームワーク | Bootstrap |
| Web API | Google API |
| データベースサーバー | MySQL |
| 環境構築 | Docker |
| インフラ | Heroku |
| ファイルサーバー | Google Cloud Storage |
| バージョン管理ツール | GitHub |
<br>

## ER図
draw.io：https://drive.google.com/file/d/11OYp4d_cBpnRXFWnEE8uZN-l4pOJQwmD/view?usp=drive_link

## 画面遷移図
Figma：https://www.figma.com/design/z8oIaDpDxaxCe3kVMdqtfU/Untitled?node-id=9-31&node-type=frame&t=1qODjWwzMJDepswb-0
