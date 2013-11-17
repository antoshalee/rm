# encoding: utf-8
ActiveAdmin.register Offer do
  menu parent: "Текстовое содержимое"
  config.clear_sidebar_sections!
  config.sort_order = 'position_asc' # assumes you are using 'position' for your acts_as_list column
  config.paginate   = false
  sortable

  filter :discount

  index do
    sortable_handle_column # inserts a drag handle
    column :title
    column :date_start
    column :date_finish
    column :is_main do |offer|
      offer.is_main? ? 'Да' : 'Нет'
    end
    column :discount do |offer|
      offer.discount? ? 'Да' : 'Нет'
    end
    default_actions
  end

  form :html => { :enctype=> 'multipart/form-data'} do |f|
    f.inputs do
      f.input :title
      f.input :sidebar, input_html: {class: 'sidebar_changer'}
      f.input :date_start
      f.input :date_finish
      f.input :lead, :input_html => {rows: 4}
      f.input :content, as: :ckeditor
      f.input :image
      f.input :tag_list
      f.input :is_main, label: t("activerecord.attributes.offer.is_main") + " (если галочка выставлена, данная акция будет отображаться самой большой на странице акций)"
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
      row :content do |offer|
        raw offer.content
      end
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

  sidebar 'Предпросмотр сайдбара', :only => [:edit, :new] do
    if resource.sidebar.present?
      render :partial => "sidebars/#{resource.sidebar.kind}", locals: {sidebar: resource.sidebar}
    end
  end

end
