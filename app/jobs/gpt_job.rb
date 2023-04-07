class GptJob < ApplicationJob
  queue_as :default

  def perform(message_attributes)
    # chat with GPT
    puts "start job"
    response = Message.chat_gpt(message_attributes)
    puts "end job"
    puts response.dig("choices", 0, "message", "content")
  end
end
