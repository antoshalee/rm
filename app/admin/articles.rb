# -*- encoding : utf-8 -*-
ActiveAdmin.register Article do
  config.clear_sidebar_sections!
  menu parent: "Текстовое содержимое"
  config.sort_order = "published_at_desc"

  index do
    column :id
    column :title
    column :published_at
    default_actions
  end

  form :html => { :enctype=> 'multipart/form-data'} do |f|
    f.inputs do
      f.input :title
      f.input :sidebar, input_html: {class: 'sidebar_changer'}
      f.input :content, as: :ckeditor
      f.input :image, :hint => (f.object.new_record? ? nil : "<img src='#{f.object.image.thumb.url}' />".html_safe)
      if (f.object.image.present?)
        f.input :remove_image, :as=> :boolean, :required => false, :label => 'Удалить изображение'
      end
      f.input :published_at
    end

    f.buttons
  end

  show do |article|
    attributes_table do
      row :title
      if article.image.present?
        row :image do |article|
          image_tag article.image.thumb.url
        end
      end
      row :content do |article|
        raw article.content
      end
      row :published_at
    end
  end

  sidebar 'Предпросмотр сайдбара', :only => [:edit, :new] do
    render :partial => "admin/sidebar", locals: {block: resource.sidebar}
  end
end
