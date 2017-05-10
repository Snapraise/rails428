class SidekiqJob < ApplicationJob
  self.queue_adapter = :sidekiq
end
