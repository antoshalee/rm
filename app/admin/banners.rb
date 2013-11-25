ActiveAdmin.register Banner do
  config.clear_sidebar_sections!
  config.sort_order = 'position_asc' # assumes you are using 'position' for your acts_as_list column
  config.paginate   = false # optional; drag-and-drop across pages is not supported
  menu priority: 2

  sortable

  index do
    sortable_handle_column # inserts a drag handle
    column :text
    column :image do |banner|
      "<a href='#{admin_banner_path(banner)}'><img src='#{banner.image.url}' width='300' /></a>".html_safe
    end
    column :url
    default_actions
  end


  form :html => { :enctype=> 'multipart/form-data'} do |f|
    f.inputs do
      f.input :image
      f.input :text, as: :ckeditor
      f.input :url
    end
    f.buttons
  end

  show do
    attributes_table do
      row :image do |banner|
        image_tag banner.image.url, width: 600
      end

      row :text do |banner|
        raw banner.text
      end
      row :url
    end
  end

end
