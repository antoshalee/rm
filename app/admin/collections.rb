# -*- encoding : utf-8 -*-
ActiveAdmin.register Collection do
  config.clear_sidebar_sections!
  config.sort_order = 'position_asc' # assumes you are using 'position' for your acts_as_list column
  config.paginate   = false
  menu priority: 4

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
      table_for(collection.collection_items) do

        column "Артикул" do |item|
          item.article
        end
        column "Цена" do |item|
          item.price
        end
        column "Фотография" do |item|
          if item.image?
            image_tag(item.image.thumb.url)
          end
        end
      end
    end
  end

  sidebar 'Информация', only: [:new, :edit] do
    div %q(Для того чтобы вставить в \"ленточку\" ссылку(например на акцию),
      вам придется вставить это чистым html-кодом.)
    div "Например:"
    strong "Эта коллекция участвует в <a class=\"black thin-link\" href=\"/offers/1\">акции</a>"

  end
end
