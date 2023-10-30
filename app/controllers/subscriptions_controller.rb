class SubscriptionsController < ApplicationController
  before_action :authenticate_user!

  def create
    Subscriptions::Subscribe.new(params,current_user).call
    article
    redirect_to @article, notice: 'Subscribed to the article.'
  end

  def destroy

    subscription
    Subscriptions::Unsubscribe.new(params,current_user,@subscription).call
    redirect_to @subscription.article, notice: 'Unsubscribed from the article.'
  end

  private

  def subscription
    @subscription = current_user.subscriptions.find_by(user_id: current_user.id, article_id: params[:article_id])
  end

  def article
    @article = Article.find(params[:article_id])
  end


end
