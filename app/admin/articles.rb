ActiveAdmin.register Article do
  config.clear_sidebar_sections!

  form :html => { :enctype=> 'multipart/form-data'} do |f|
    f.inputs do
      f.input :title
      f.input :lead
      f.input :content, as: :ckeditor
      f.input :image
    end

    f.buttons
  end

end
