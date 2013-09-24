class ArticleDecorator < Draper::Decorator
  delegate_all

  def published_at
    # I18n.l(@article.published_at, format: '%d.%m.%Y')
    object.published_at.strftime("%d.%m.%Y")
  end

end
