class UserImportJob < ApplicationJob
  queue_as :low

  def perform(row:)
    User.where(email: row['email']).first_or_create!(row.merge(password: 'Pass1234'))
  end

end
