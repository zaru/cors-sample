class Embed::ArticlesController < ApplicationController
  # InvalidAuthenticityToken が発生しないようにする = authenticity_token のチェックをしない
  skip_forgery_protection

  # GET /articles/new
  def new
    response.headers['X-Frame-Options'] = "ALLOW-FROM http://evil.example.net:9999"
    @article = Article.new
  end


  # POST /articles or /articles.json
  def create
    @article = Article.new(article_params)

    respond_to do |format|
      if @article.save
        format.html { redirect_to embed_thanks_url, notice: "Article was successfully created." }
        format.json { render :show, status: :created, location: @article }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_article
      @article = Article.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def article_params
      params.require(:article).permit(:title)
    end
end
