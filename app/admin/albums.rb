# -*- encoding : utf-8 -*-
ActiveAdmin.register Album do
  config.clear_sidebar_sections!
  menu priority: 0

  member_action :multiple_file_loading, method: :post do
    album = Album.find params[:id]
    album_item = AlbumItem.new(
      album: album,
      image: params[:album_item]
    )
    if album_item.save
      render status: 200, json: {thumb_url: album_item.image.thumb.url}
    else
      render status: 500
    end
  end

  index do
    column :id
    column :title
    column :published_at
    default_actions
  end

  form :html => { :enctype=> 'multipart/form-data'} do |f|
    f.inputs do
      f.input :title
      f.input :content, as: :ckeditor
      f.input :tag_list, hint: tag_links(Album)
      f.input :published_at
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
      row :published_at
    end

    panel("Фотографии") do
      div id: 'album_files_dropzone' do
        "Перетащите файлы в эту область"
      end
      div do
        form_tag multiple_file_loading_admin_album_path(album), method: :post, multipart: true, id: 'album_multiupload_form' do
          file_field_tag :album_item
        end
      end
      table_for album.album_items, id: "album_items_table" do
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
