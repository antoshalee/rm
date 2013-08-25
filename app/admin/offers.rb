# encoding: utf-8
ActiveAdmin.register Offer do
  config.clear_sidebar_sections!
  menu priority: 5

  index do
    column :title
    column :date_start
    column :date_finish
    column :is_main
    default_actions
  end

  form :html => { :enctype=> 'multipart/form-data'} do |f|
    f.inputs do
      f.input :title
      f.input :date_start
      f.input :date_finish
      f.input :lead, :input_html => {rows: 4}
      f.input :content, as: :ckeditor
      f.input :image
      f.input :tag_list
      f.input :is_main
      f.input :discount
    end

    f.buttons
  end

  show do |item|
    attributes_table do
      row :title
      row :date_start
      row :date_finish
      row :lead
      row :content
      row :tag_list
      row :image do |a|
        image_tag a.image.url
      end
      row :is_main do |item|
        item.is_main? ? 'Да' : 'Нет'
      end
      row :discount do |item|
        item.discount? ? 'Да' : 'Нет'
      end
    end
  end

end
