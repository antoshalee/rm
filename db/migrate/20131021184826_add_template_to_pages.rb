class AddTemplateToPages < ActiveRecord::Migration
  def change
    add_column :pages, :template, :string, default: "standard"
  end
end
