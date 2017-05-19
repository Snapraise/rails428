namespace :rails428 do

  desc 'test data'
  task data: :environment do
    counter = 100
    file = CSV.open("tmp/users_#{counter}.csv", "wb")
    file << ["email"]
    counter.times do |i|
      file << ["user#{i}@email.com"]
    end
  end

end
