# CSRF やクリックジャッキングの対策と例

## docker化

### セットアップ
1. `docker-compose up -d`
1. `docker-compose exec app bash`
1. `bundle install`(初回のみ)
1. `rails db:migtate`

## 動作(コンテナの中で)
```bash
$ ralis s -b 0.0.0.0

$ cd ./client_site
$ php -S 0.0.0.0:9000
$ php -S 0.0.0.0:9999
```

`/etc/hosts` ファイルを修正してローカルホストをクロスドメインでアクセスできるようにする

```
127.0.0.1 form.example.com
127.0.0.1 good.example.jp
127.0.0.1 evil.example.net
```

- アプリケーション : http://form.example.com:3001/articles
- 正規の埋め込みページ : http://good.example.jp:9000/good.html
- 悪意のあるページ : http://evil.example.net:9999/evil.html
