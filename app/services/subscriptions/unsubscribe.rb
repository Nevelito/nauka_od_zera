module Subscriptions
  class Unsubscribe
    def initialize(params, user,subscription,article)
      @params = params
      @user = user
      @subscription = subscription
      @article = article
    end

    def call
      cancel_subscription
      cancel_points
      cancel_sending_mails
    end
    def cancel_subscription
      if @subscription
        @subscription.destroy
      else
        flash[:alert] = "Error deleting the subscription."
        redirect_to @article
      end
    end
    def cancel_points
      @user.update!(points: @user.points - 10)

    rescue StandardError => e
      puts "Error in cancel_points: #{e.message}"
    end
    def cancel_sending_mails
      SubscriptionMailer.delete_subscription_notification(@user, @article).deliver_now

    rescue StandardError => e
      puts "Error in sending_mails: #{e.message}"
    end
  end
end

