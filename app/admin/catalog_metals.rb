# -*- encoding : utf-8 -*-
ActiveAdmin.register Catalog::Metal do
  config.clear_sidebar_sections!
  menu parent: "Каталог"
  actions :all, :except => [:show]
  config.sort_order = 'position_asc' # assumes you are using 'position' for your acts_as_list column
  config.paginate   = false # optional; drag-and-drop across pages is not supported
  sortable

  index do
    sortable_handle_column
    column :name
    default_actions
  end

  form do |f|
    f.inputs do
      f.input :name
    end
    f.buttons
  end
end
