# -*- encoding : utf-8 -*-
ActiveAdmin.register Collection do
  config.clear_sidebar_sections!
  config.sort_order = 'position_asc' # assumes you are using 'position' for your acts_as_list column
  config.paginate   = false
  menu priority: 4

  member_action :multiple_file_loading, method: :post do
    collection = Collection.find params[:id]
    collection_item = CollectionItem.new(
      collection: collection,
      image: params[:collection_item]
    )
    if collection_item.save
      render status: 200, json: { fullscreen_url: collection_item.image.url,
                                  thumb_url: collection_item.image.thumb.url }
    else
      render status: 500
    end
  end

  sortable

  index do
    sortable_handle_column
    column :id
    column :title
    column :created_at
    default_actions
  end

  form :html => { :enctype=> 'multipart/form-data'} do |f|
    f.inputs do
      f.input :title
      f.input :price
      f.input :description
      f.input :note, hint: 'Содержимое этого поля будет отображаться в виде ленточки(например, со ссылкой на акцию)'
      f.input :tag_list, hint: tag_links(Collection)
    end

    f.has_many :collection_items do |item|
      unless item.object.new_record?
        item.input :_destroy, :as => :boolean, :required => false, :label => 'Удалить'
      end
      item.input :image, :as => :file, :hint => (item.object.new_record? ? nil : item.template.image_tag(item.object.image.thumb.url))
      item.input :article
      item.input :price
    end
    f.buttons
  end

  show do |collection|
    attributes_table do
      row :title
      row :price
      row :description
      row :note
      row :tag_list
    end
    panel("Украшения") do
      div id: 'collection_files_dropzone' do
        "Перетащите файлы в эту область"
      end
      div do
        form_tag multiple_file_loading_admin_collection_path(collection), method: :post, multipart: true, id: 'collection_multiupload_form' do
          file_field_tag :collection_item
        end
      end
      table_for collection.collection_items, id: "collection_items_table" do
        column "Фотография" do |item|
          if item.image?
            link_to item.image.url, class: 'igallery_item' do
              image_tag(item.image.thumb.url)
            end
          end
        end
        column "Артикул" do |item|
          item.article
        end
        column "Цена" do |item|
          item.price
        end
      end
    end
  end

  sidebar 'Информация', only: [:new, :edit] do
    div %q(Для того чтобы вставить в "ленточку" ссылку(например на акцию),
      вам придется вставить это чистым html-кодом.)
    div "Например:"
    strong "Эта коллекция участвует в <a class=\"black thin-link\" href=\"/offers/1\">акции</a>"

  end
end
