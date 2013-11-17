ActiveAdmin.register Sidebar do
  config.clear_sidebar_sections!
  menu parent: "Текстовое содержимое"

  member_action :partial, method: :get do
    sidebar = Sidebar.find(params[:id])
    render partial: "sidebars/#{sidebar.kind}", locals: { sidebar: sidebar }
  end

  index do
    column :title
    default_actions
  end

  form do |f|
    f.inputs do
      f.input :kind, as: :select, include_blank: false
      f.input :display_on_articles_page
      f.input :display_on_offers_page
    end
    f.has_many :sidebar_items do |sidebar_item|
      unless sidebar_item.object.new_record?
        sidebar_item.input :_destroy, :as => :boolean, :required => false, :label => 'Удалить'
      end
      sidebar_item.input :text, as: :ckeditor, hint: 'Для того чтобы вставить заголовок золотого цвета, используйте формат Heading1'
    end
    f.buttons
  end

  show do |item|
    attributes_table do
      row :title
    end
  end
end
