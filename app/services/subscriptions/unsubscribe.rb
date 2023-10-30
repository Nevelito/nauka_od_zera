module Subscriptions
  class Unsubscribe
    def initialize(params, user,subscription)
      @params = params
      @user = user
      @subscription = subscription
    end

    def call
      cancel_subscription
      cancel_points
      # cancel_sending_mails
    end
    def cancel_subscription
      if @subscription!=nil
        @subscription.destroy
      else
        # error
      end
    end
    def cancel_points
      @user.update!(points: @user.points - 10)
    end
    def cancel_sending_mails
      @article = Article.find(@params[:article_id])
      result = SubscriptionMailer.delete_subscription_notification(@user, @article)

      if result[:success]
        # success
      else
        # error
      end
    end
  end
end

