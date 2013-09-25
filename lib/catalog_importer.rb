# encoding: utf-8
require 'csv'
class CatalogImporter
  def self.test
    self.import "/home/antoshalee/Sites/remix/csv/cat.csv"
  end

  def self.import csv_file_path
    metals = {"Золото" => "gold", "Серебро" => "silver"}

    CSV.foreach csv_file_path, :row_sep => :auto, :col_sep => "," do |row|
      next if row.blank?
      original_id = row[0]

      article = row[1]
      weight = row[2]
      metal = metals[row[3]]
      insert = Catalog::Insert.find_by_name(row[4])
      next if insert.nil?

      category = Catalog::Category.find_by_name(row[5])
      next if category.nil?

      item = Catalog::Item.find_or_initialize_by_article(article)

      item.assign_attributes(weight: weight, metal: metal, insert_id: insert.id, category_id: category.id)
      item.remote_image_url = "http://remixgold.ru/upload/catalog/#{original_id}.jpg"
      if item.changed.present?
        item.save!
      end
    end
  end
end