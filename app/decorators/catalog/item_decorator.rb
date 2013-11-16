class Catalog::ItemDecorator < Draper::Decorator
  delegate_all

  # "Insert1, Insert2, Insert3"
  def inserts_to_string
    inserts.pluck(:name).join ", "
  end
end
