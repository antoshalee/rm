# -*- encoding : utf-8 -*-
ActiveAdmin.register Page do
  config.clear_sidebar_sections!
  menu parent: "Текстовое содержимое"

  collection_action :select_box_options, method: :get do
    render json: Page.select([:url, :title])
  end

  index do
    column :title
    column :url
    default_actions
  end

  form do |f|
    f.inputs do
      f.input :title
      f.input :sidebar, input_html: {class: 'sidebar_changer'}
      f.input :url
      f.input :content, as: :ckeditor
      f.input :submenu, input_html: {rows: 10}
      f.input :template, as: :select, collection: Page.template.values
    end

    f.buttons
  end

  show do |item|
    attributes_table do
      row :title
      row :url
      row :content do |page|
        raw page.content
      end
      row :template
      row :created_at
      row :updated_at
    end
  end

  sidebar 'Предпросмотр сайдбара', :only => [:edit, :new] do
    if resource.sidebar.present?
      render :partial => "sidebars/#{resource.sidebar.kind}", locals: {sidebar: resource.sidebar}
    end
  end

end
