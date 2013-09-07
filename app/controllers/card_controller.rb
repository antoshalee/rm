# encoding: utf-8
class CardController < ApplicationController
  def index
  end

  def check
    card = Card.find_by_number(params[:number])
    if card
      render json: {message: "Ваша скидка #{card.discount}%"}
    else
      render json: {message: "Неверный номер карты"}
    end
  end
end
