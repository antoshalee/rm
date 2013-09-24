# -*- encoding : utf-8 -*-
ActiveAdmin.register WholesaleManager do
  menu parent: "Оптовый отдел"

  config.clear_sidebar_sections!
  config.sort_order = 'position_asc' # assumes you are using 'position' for your acts_as_list column
  config.paginate   = false # optional; drag-and-drop across pages is not supported

  sortable

  index do
    sortable_handle_column # inserts a drag handle
    column :name
    default_actions
  end

  form :html => { :enctype=> 'multipart/form-data'} do |f|
    f.inputs do
      f.input :name
      f.input :image
      f.input :description
    end
    f.buttons
  end

  show do
    attributes_table do
      row :name
      row :image do |m|
        image_tag m.image.url
      end
      row :description do |m|
        raw m.description
      end
    end
  end
end
