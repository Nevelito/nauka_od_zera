module Subscriptions
  class Subscribe
    def initialize(params, user, article)
      @params = params
      @user = user
      @article = article
    end

    def call
      new_subscription
      adding_points
      sending_mails
    end
    def new_subscription
      if @article
        @user.subscribed_articles << @article
      else
        # error
      end
    end
    def adding_points
      @user.update!(points: @user.points + 10)
    end

    def sending_mails
      SubscriptionMailer.new_subscription_notification(@user, @article).deliver_now
    end
  end
end

