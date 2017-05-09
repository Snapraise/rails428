class SqsJob < ApplicationJob
  self.queue_adapter = :shoryuken
  queue_as :default

  def perform(*args)
    # Do something later
  end
end
