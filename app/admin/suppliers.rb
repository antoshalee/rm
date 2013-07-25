# -*- encoding : utf-8 -*-
ActiveAdmin.register Supplier do
  menu parent: "Оптовый отдел"
  config.clear_sidebar_sections!
  config.sort_order = 'position_asc' # assumes you are using 'position' for your acts_as_list column
  config.paginate   = false # optional; drag-and-drop across pages is not supported

  sortable

  index do
    sortable_handle_column # inserts a drag handle
    column :description
    default_actions
  end

  form :html => { :enctype=> 'multipart/form-data'} do |f|
    f.inputs do
      f.input :title
      f.input :description
      f.input :image
    end
    f.buttons
  end

  show do |item|
    attributes_table do
      row :title
      row :description
      row :image do |a|
        image_tag a.image.main.url
      end
    end
  end

end
