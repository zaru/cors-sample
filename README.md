# CSRF やクリックジャッキングの対策と例

## コンテナ起動

```
docker-compose up -d
```

## ホストOSの設定

ホストの`/etc/hosts` ファイルを修正してローカルホストをクロスドメインでアクセスできるようにする

```
127.0.0.1 form.example.com
127.0.0.1 good.example.jp
127.0.0.1 evil.example.net
```
## 各ページ

- アプリケーション : http://form.example.com:3001/articles
- 正規の埋め込みページ : http://good.example.jp:9000/good.html
- 悪意のあるページ : http://evil.example.net:9999/evil.html
