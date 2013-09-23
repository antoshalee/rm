# -*- encoding : utf-8 -*-
ActiveAdmin.register Variable do
  menu parent: "Текстовое содержимое"

  config.clear_sidebar_sections!
  config.paginate   = false # optional; drag-and-drop across pages is not supported
  actions :all, except: :destroy

  controller do
    defaults :finder => :find_by_key
  end

  index do
    column :key
    column :label
    default_actions
  end

  form :html => { :enctype=> 'multipart/form-data'} do |f|
    f.inputs do
      f.input :key
      f.input :label
      f.input :value
    end
    f.buttons
  end

  show do
    attributes_table do
      row :key
      row :label
      row :value
    end
  end
end
