# -*- encoding : utf-8 -*-
ActiveAdmin.register Album do
  config.clear_sidebar_sections!

  index do
    column :id
    column :title
    column :created_at
    default_actions
  end

  form :html => { :enctype=> 'multipart/form-data'} do |f|
    f.inputs do
      f.input :title
      f.input :content, as: :ckeditor
    end

    f.has_many :album_items do |album_item|
      unless album_item.object.new_record?
        album_item.input :_destroy, :as => :boolean, :required => false, :label => 'Удалить'
      end
      album_item.input :image, :as => :file, :hint => (album_item.object.new_record? ? nil : album_item.template.image_tag(album_item.object.image.thumb.url))
    end
    f.buttons
  end

  show do |album|
    attributes_table do
      row :title
      row :content
    end
    panel("Фотографии") do
      table_for(album.album_items) do
        column "" do |item|
          if item.image?
            image_tag(item.image.thumb.url)
          end
        end
      end
    end
  end
end
