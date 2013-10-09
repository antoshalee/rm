# -*- encoding : utf-8 -*-
ActiveAdmin.register ContactGroup do
  menu parent: "Текстовое содержимое"
  config.clear_sidebar_sections!
  config.sort_order = 'position_asc' # assumes you are using 'position' for your acts_as_list column
  config.paginate   = false # optional; drag-and-drop across pages is not supported
  sortable

  index do
    sortable_handle_column # inserts a drag handle
    column :name
    default_actions
  end

  form do |f|
    f.inputs do
      f.input :name
      f.input :address
    end

    f.has_many :contacts do |contact|
      unless contact.object.new_record?
        contact.input :_destroy, :as => :boolean, :required => false, :label => 'Удалить'
      end
      contact.input :content, input_html: {rows: 5}
    end
    f.buttons
  end

  show do |group|
    attributes_table do
      row :name
      row :address
    end

    panel("Записи") do
      table_for(group.contacts) do
        column do |contact|
          raw contact.content
        end
      end
    end
  end
end
