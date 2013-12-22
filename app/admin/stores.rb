# -*- encoding : utf-8 -*-
ActiveAdmin.register Store do
  menu parent: "Текстовое содержимое"
  config.clear_sidebar_sections!
  config.sort_order = 'position_asc' # assumes you are using 'position' for your acts_as_list column
  config.paginate   = false
  sortable

  filter :discount

  index do
    sortable_handle_column # inserts a drag handle
    column :name
    default_actions
  end

end
