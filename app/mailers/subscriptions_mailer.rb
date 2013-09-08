# encoding: utf-8
class SubscriptionsMailer < ActionMailer::Base
  default from: ENV['SYSTEM_EMAIL']

  def ask_confirmation subscription
    @subscription = subscription
    mail(to: subscription.email, subject: "Подтверждение подписки")
  end
end
