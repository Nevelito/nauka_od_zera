class ArticlesController < ApplicationController

  before_action :authenticate_user!
  def new
    @article = Article.new
  end

  def index
    @articles = Article.all
  end

  def create
    # @article = current_user.articles.new(article_params)
    result = Articles::Create.new(article_params).call

    if result[:success] == true
      redirect_to articles_path
    else
      flash[:alert] = result[:errors]
      render :new
    end

  end

  def show
    @article = Article.find_by(id: params[:id])
    render 'show'
  end

  def destroy
    @article = Article.find_by(id: params[:id])
    @article.destroy
    redirect_to articles_path, notice: "Article was successfully deleted."
  end

  def edit
    @article = Article.find_by(id: params[:id])
  end

  def my_articles
    @my_articles = current_user.articles
  end

  # def subscripted_article
  #   my_subscriptions = current_user.subscriptions
  #   @articles = Article.where(id: my_subscriptions.pluck(:article_id))
  #   binding.pry
  # end


  private

  def article_params
    params.require(:article).permit(:title, :entry, :contents, :user_id) # Replace with the actual permitted attributes
  end
end