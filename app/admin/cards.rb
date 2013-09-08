ActiveAdmin.register Card do
  filter :number
  filter :discount
  actions :all, except: [:show]

  index do
    selectable_column
    column :number
    column :discount
    default_actions
  end
end
