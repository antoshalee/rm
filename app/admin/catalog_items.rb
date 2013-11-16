# -*- encoding : utf-8 -*-
ActiveAdmin.register Catalog::Item do
  menu parent: "Каталог"
  filter :category
  filter :article
  decorate_with Catalog::ItemDecorator

  index do
    column :id
    column :category
    column :metals_to_string
    column :inserts_to_string
    column :article
    column :created_at
    default_actions
  end

  form do |f|
    f.inputs do
      f.input :category
      f.input :inserts, as: :check_boxes
      f.input :metals, as: :check_boxes
      f.input :article
      f.input :weight
      f.input :image, :hint => (f.object.new_record? ? nil : "<img src='#{f.object.image.thumb.url}' />".html_safe)
      if (f.object.image.present?)
        f.input :remove_image, :as=> :boolean, :required => false, :label => 'Удалить изображение'
      end
    end
    f.buttons
  end

  show do
    attributes_table do
      row :id
      row :category
      row :metals_to_string
      row :inserts_to_string
      row :article
      row :created_at
      row :image do |item|
        if item.image.present?
          image_tag item.image.thumb.url
        end
      end
    end
  end
end
