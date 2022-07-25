class Embed::ArticlesController < ApplicationController
  # InvalidAuthenticityToken が発生しないようにする = authenticity_token のチェックをしない
  skip_forgery_protection

  # GET /articles/new
  def new
    # 指定したサイトに埋め込まれた場合だけ X-Frame-Options を返さないで許可する
    if request.referrer.start_with?('http://good.example.jp:9000/')
      response.headers['X-Frame-Options'] = nil
    end

    @article = Article.new
  end

  # POST /articles or /articles.json
  def create
    # CSRF されないようにリクエスト Origin の同一性チェックをしている
    if request.origin.present? &&
      request.origin != 'http://good.example.jp:9000' &&
      request.origin != request.base_url
      raise ActionController::InvalidAuthenticityToken
    end

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
