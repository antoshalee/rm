class FeedbacksController < ApplicationController
  def create
    @feedback = Feedback.new(params[:feedback])
    @feedback.save!
    render text: ""
  end
end
