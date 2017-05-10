class SqsHighJob < SqsJob
  queue_as :high

  def perform(*args)
    # Do something later
  end
end
