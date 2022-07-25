class Embed::ThanksController < ApplicationController
  def show
    # request.referrer は http://form.example.com:3000/ になる
    # つまりサンクスページを特定の URL に対してだけ許可する処理を動的にすることは難しい
    # ALLOW-FROM が使えていた時代の時はホワイトリスト URL の数だけ許可するようにすれば良かったが…
    # response.headers['X-Frame-Options'] = "ALLOW-FROM http://good.example.jp:9000"
    # 廃止されているため問答無用で nil にし、X-Frame-Options 自体を出力しないようにしている
    response.headers['X-Frame-Options'] = nil
  end
end
