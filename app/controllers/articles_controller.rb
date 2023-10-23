class ArticlesController < ApplicationController

  before_action :authenticate_user!
  def new
    @article = Article.new
  end

  def index
    @articles = Article.all
  end

  def create
    @article = current_user.articles.new(article_params)

    if @article.save
      redirect_to @article
    else
      render 'new'
    end
  end

  def show
    @article = Article.find_by(id: params[:id])
    render 'show'
  end


  private

  def article_params
    params.require(:article).permit(:title, :entry, :contents, :user_id) # Replace with the actual permitted attributes
  end
end