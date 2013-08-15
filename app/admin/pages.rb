ActiveAdmin.register Page do
  config.clear_sidebar_sections!

  index do
    column :title
    column :url
    default_actions
  end

  form do |f|
    f.inputs do
      f.input :title
      f.input :url
      f.input :content, as: :ckeditor
    end

    f.buttons
  end

end
