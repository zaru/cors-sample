class VulnerableArticlesController < ApplicationController
  # GET /articles/new
  def new
    response.headers['X-Frame-Options'] = nil
    @article = Article.new
  end

  # POST /articles or /articles.json
  def create
    @article = Article.new(article_params)

    respond_to do |format|
      if @article.save
        format.html { redirect_to article_url(@article), notice: "Article was successfully created." }
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
