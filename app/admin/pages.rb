# -*- encoding : utf-8 -*-
ActiveAdmin.register Page do
  config.clear_sidebar_sections!
  menu parent: "Текстовое содержимое"

  index do
    column :title
    column :url
    default_actions
  end

  form do |f|
    f.inputs do
      f.input :title
      f.input :url
      f.input :content, as: :ckeditor
    end
    f.has_many :sidebar_items do |sidebar_item|
      unless sidebar_item.object.new_record?
        sidebar_item.input :_destroy, :as => :boolean, :required => false, :label => 'Удалить'
      end
      sidebar_item.input :text, as: :ckeditor, hint: 'Для того чтобы вставить заголовок золотого цвета, используйте формат Heading1'
    end
    f.buttons
  end

  show do |item|
    attributes_table do
      row :title
      row :url
      row :content do |page|
        raw page.content
      end
      row :created_at
      row :updated_at
    end
  end

end
