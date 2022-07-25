class Embed::VulnerableArticlesController < ApplicationController
  # CSRF 脆弱性のあるコントローラー例
  #
  # InvalidAuthenticityToken が発生しないようにする = authenticity_token のチェックをしない
  skip_forgery_protection

  # GET /articles/new
  def new
    # ALLOW-FROM は廃止され、最新のブラウザでは機能しない
    # そのため悪意のあるサイトにも埋め込みが可能な状態になっている
    response.headers['X-Frame-Options'] = "ALLOW-FROM http://good.example.jp:9000"
    @article = Article.new
  end

  # POST /articles or /articles.json
  def create
    # Request Origin のチェックを確認しないので、許可していない悪意のあるサイトから JS による POST が成功してしまう
    # Access-Control-Allow-Origin で制御をしているので、JS 自体はレスポンスを受け取れないが、サーバ側の実行はされている状態
    response.headers['Access-Control-Allow-Origin'] = "http://good.example.jp:9000"
    @article = Article.new(article_params)

    respond_to do |format|
      if @article.save
        format.html { redirect_to embed_thanks_url, notice: "Article was successfully created." }
        format.json { render json: { result: 'Success!' } }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Only allow a list of trusted parameters through.
    def article_params
      params.require(:article).permit(:title)
    end
end
