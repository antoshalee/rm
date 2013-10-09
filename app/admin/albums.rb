# -*- encoding : utf-8 -*-
ActiveAdmin.register Album do
  config.clear_sidebar_sections!
  menu priority: 0

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
      f.input :tag_list, hint: tag_links(Album)
    end

    f.has_many :album_items do |album_item|
      unless album_item.object.new_record?
        album_item.input :_destroy, :as => :boolean, :required => false, :label => 'Удалить'
      end
      album_item.input :image, :as => :file, :hint => (album_item.object.new_record? ? nil : "<img src='#{album_item.object.image.thumb.url}' />".html_safe)
      album_item.input :description, :as => :string
    end
    f.buttons
  end

  show do |album|
    attributes_table do
      row :title
      row :content do |album|
        raw album.content
      end
      row :tag_list
    end

    panel("Фотографии") do
      table_for(album.album_items) do
        column "Фотография" do |item|
          if item.image?
            image_tag(item.image.thumb.url)
          end
        end
        column "Описание" do |item|
          item.description
        end
      end
    end
  end
end
