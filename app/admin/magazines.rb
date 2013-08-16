# encoding: utf-8
ActiveAdmin.register Magazine do
  menu parent: "Журналы"
  config.clear_sidebar_sections!
  config.sort_order = 'position_desc' # assumes you are using 'position' for your acts_as_list column
  config.paginate   = false # optional; drag-and-drop across pages is not supported

  sortable
  actions :all, :except => [:show]

  index do
    sortable_handle_column # inserts a drag handle
    column :title
    column :lead
    column :url
    default_actions
  end

  form do |f|
    f.inputs do
      f.input :title
      f.input :lead
      f.input :url
    end

    f.buttons
  end

end
