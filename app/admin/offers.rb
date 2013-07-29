ActiveAdmin.register Offer do
  config.clear_sidebar_sections!
  index do
    column :title
    column :date_start
    column :date_finish
    default_actions
  end

end
