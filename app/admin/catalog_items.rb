# -*- encoding : utf-8 -*-
ActiveAdmin.register Catalog::Item do
  menu parent: "Каталог"
  filter :category
  filter :metal, :as => :select, collection: Catalog::Item::METALS.map{|m| [I18n.t("catalog.metals.#{m}"), m]}
  filter :insert
  filter :article

  index do
    column :id
    column :category
    column :metal
    column :insert
    column :article
    column :created_at
    default_actions
  end

  form do |f|
    f.inputs do
      f.input :category
      f.input :metal, collection: Catalog::Item::METALS.map{|m| [t("catalog.metals.#{m}"), m]}
      f.input :insert
      f.input :article
      f.input :weight
      f.input :image
    end
    f.buttons
  end

  show do
    attributes_table do
      row :id
      row :category
      row :metal do |item|
        t("catalog.metals.#{item.metal}")
      end
      row :insert
      row :article
      row :created_at
      row :image do |item|
        image_tag item.image
      end
    end
  end
end
