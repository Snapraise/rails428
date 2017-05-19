class ImportJob < ApplicationJob
  queue_as :low

  def perform file, record_type
    klass = ("#{record_type.camelize}ImportJob").constantize
    spreadsheet = CSV.read(file.path, headers:true)
    spreadsheet.size.times do |i|
      row = spreadsheet[i].to_hash
      job = klass.perform_later(row: row)
    end
  end

end
