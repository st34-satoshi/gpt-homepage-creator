class GptJob < ApplicationJob
  queue_as :default

  def perform(*args)
    # Do something later
    puts "start job"
    puts "sleep 5 seconds"
    sleep 5
    puts "end job"
  end
end
