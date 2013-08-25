ActiveAdmin.register Feedback do
  config.clear_sidebar_sections!
  actions :all, :except => [:new, :edit]
  menu priority: 8

  index do
    column :name
    column :email
    column :text
    column :created_at
    default_actions
  end

  show do
    attributes_table do
      row :name
      row :email
      row :text
      row :created_at
    end
  end
end
