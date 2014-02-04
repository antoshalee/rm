# -*- encoding : utf-8 -*-
ActiveAdmin.register Ckeditor::Picture do
  menu parent: "Текстовое содержимое", priority: 11

  config.batch_actions = false
  actions :all, except: :edit

  filter :data_file_name
  filter :data_content_type
  filter :data_file_size

  index do
    column :data_file_name do |ca|
      ca.data.blank? ? ca.data_file_name : link_to(ca.data_file_name, ca.data.url, target: '_blank')
    end
    column :data_content_type
    column :data_file_size do |ca|
      number_to_human_size ca.data_file_size
    end
    default_actions
  end

  form :html => { :enctype=> 'multipart/form-data'} do |f|
    f.inputs do
      f.input :data
    end
    f.buttons
  end

  show do |ca|
    attributes_table do
      row :data_file_name do
        ca.data.blank? ? ca.data_file_name : link_to(ca.data.url, ca.data.url, target: '_blank')
      end
      row :data_content_type
      row :data_file_size do
        number_to_human_size ca.data_file_size
      end
      if ca.data_content_type.split('/')[0] == 'image'
        row 'Изображение' do
          image_tag ca.data.url, style: "max-width:90%;"
        end
      end
    end
  end
  
end
