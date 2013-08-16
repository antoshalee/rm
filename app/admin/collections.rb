# -*- encoding : utf-8 -*-
ActiveAdmin.register Collection do
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
      f.input :price
      f.input :description
      f.input :note, hint: 'Это поле будет отображаться в виде ленточки(например, со ссылкой на акцию)'
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
end
