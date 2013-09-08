# encoding: utf-8
ActiveAdmin.register Subscription do
  menu parent: "Журналы"
  filter :kind, :as => :check_boxes, :collection => [['Бумажная', "paper"],['Электронная', "digital"]]
  scope :all
  scope :confirmed
  actions :index, :destroy

  index download_links: true do
    selectable_column
    column :name
    column :kind do |s|
      I18n.t("subscriptions.#{s.kind}")
    end
    column :email
    column :phone
    column :address
    column :confirmed? do |s|
      s.confirmed? ? 'Да' : 'Нет'
    end
    column :created_at
    default_actions
  end
end
