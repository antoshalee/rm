require 'csv'
class DiscountImporter
  def self.test
    path = "/home/antoshalee/Sites/remix/csv/dk.csv"
    self.import path
  end

  def self.scan
    path_to_dir = ENV['PATH_TO_CSV_DIR']
    Dir.foreach(path_to_dir) do |file_name|
      if file_name.match /^.+\.csv$/
        full_name = File.join path_to_dir, file_name
        new_name = "#{full_name}process"
        File.rename(full_name, new_name)
        import new_name
        File.delete(full_name)
      end
    end

  end

  def self.import csv_file_path
    CSV.foreach csv_file_path, :row_sep => :auto, :col_sep => ";" do |row|
      next if row.blank?
      card = Card.find_or_initialize_by_number(row[0])
      card.assign_attributes(balance: (row[1] || 0), discount: (row[2] || 0))
      if card.changed.present?
        card.save
      end
    end
  end
end