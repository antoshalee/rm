# -*- encoding : utf-8 -*-
ActiveAdmin.register Letter do
  menu parent: "Оптовый отдел"

  config.clear_sidebar_sections!
  config.sort_order = 'position_asc' # assumes you are using 'position' for your acts_as_list column
  config.paginate   = false # optional; drag-and-drop across pages is not supported

  sortable

  index do
    sortable_handle_column # inserts a drag handle
    column :title
    column :image do |l|
      image_tag l.image.main, height: 90
    end
    default_actions
  end

  form :html => { :enctype=> 'multipart/form-data'} do |f|
    f.inputs do
      f.input :title
      f.input :image, hint: 'Размер изображения 130px x 180px. В случае несоответствия, изображение будет приведено к данным размерам автоматически'
      f.input :color, as: :select, collection: Letter::COLORS.map {|color| [I18n.t("letters.colors.#{color}"), color]}
    end
    f.buttons
  end

  show do
    attributes_table do
      row :title
      row :image do |l|
        image_tag l.image.main.url
      end
      row :color do |l|
        I18n.t("letters.colors.#{l.color}")
      end
    end
  end

end
