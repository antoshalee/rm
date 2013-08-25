ActiveAdmin.register Article do
  config.clear_sidebar_sections!
  menu prority: 1

  form :html => { :enctype=> 'multipart/form-data'} do |f|
    f.inputs do
      f.input :title
      f.input :lead, :input_html => {rows: 4}
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
      row :lead
      row :content do |article|
        raw article.content
      end
      row :created_at
    end
  end

end
