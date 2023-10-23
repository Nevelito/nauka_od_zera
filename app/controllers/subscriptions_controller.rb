class SubscriptionsController < ApplicationController
  before_action :authenticate_user!

  def create
    # Rails.logger.debug 'SubscriptionsController#create is called.'
    @article = Article.find(params[:article_id])
    current_user.subscribed_articles << @article
    # SubscriptionMailer.new_subscription_notification(current_user, @article).deliver_later
    current_user.update!(points: current_user.points + 10)

    puts "Current user's points: #{current_user.points}"

    redirect_to @article, notice: 'Subscribed to the article.'
  end

  def destroy
    @subscription = current_user.subscriptions.find(params[:id])
    @subscription.destroy
    # SubscriptionMailer.delete_subscription_notification(current_user, @article).deliver_later
    current_user.update!(points: current_user.points - 10)

    puts "Current user's points: #{current_user.points}"

    redirect_to @subscription.article, notice: 'Unsubscribed from the article.'
  end
end
