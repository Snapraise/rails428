class UserImportJob < ApplicationJob
  queue_as :low

  def perform(row:)
    User.create!(row.merge(password: 'Pass1234'))
  end

end
