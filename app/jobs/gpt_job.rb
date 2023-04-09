class GptJob < ApplicationJob
  queue_as :default

  def perform(line_message)
    logger.info "start job"
    message = Message.create_from(line_message)
    # chat with GPT
    response = Message.chat_gpt(line_message[:message])

    message = Message.new
    # TODO: save message to DB
    # reply to Line
    message.reply_line(response.dig("choices", 0, "message", "content"), line_message[:reply_token])
    logger.info "end job"
  end
end
