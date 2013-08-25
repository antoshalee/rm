# encoding: utf-8
ActiveAdmin.register Subscription do
  menu parent: "Журналы"
  filter :kind, :as => :check_boxes, :collection => [['Бумажная', "paper"],['Электронная', "digital"]]

  index do
    column :name
    column :kind do |s|
      I18n.t("subscriptions.#{s.kind}")
    end
    column :email
    column :phone
    column :address
    column :created_at
  end
end
