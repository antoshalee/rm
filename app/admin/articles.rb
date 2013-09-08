ActiveAdmin.register Article do
  config.clear_sidebar_sections!
  menu prority: 1

  index do
    column :id
    column :title
    column :created_at
    default_actions
  end

  form :html => { :enctype=> 'multipart/form-data'} do |f|
    f.inputs do
      f.input :title
      f.input :content, as: :ckeditor
      f.input :image
    end

    f.buttons
  end

  show do
    attributes_table do
      row :title
      row :image do |article|
        image_tag article.image.url, width: 100
      end
      row :content do |article|
        raw article.content
      end
      row :created_at
    end
  end

end
