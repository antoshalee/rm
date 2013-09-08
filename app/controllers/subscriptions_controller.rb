class SubscriptionsController < ApplicationController
  def new
    @subscription = Subscription.new
  end

  def create
    @subscription = Subscription.new(params[:subscription])
    if @subscription.save
      SubscriptionsMailer.ask_confirmation(@subscription).deliver
    else
      render action: :new
    end
  end

  def confirm
    subscription = Subscription.find_by_confirmation_token(params[:confirmation_token])
    if subscription
      subscription.confirmed_at = Time.now
      subscription.save
    else
      render 'confirmation_fail'
    end
  end
end
