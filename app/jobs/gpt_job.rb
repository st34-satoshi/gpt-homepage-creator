class GptJob < ApplicationJob
  queue_as :default

  def perform(line_message)
    logger.info "start job"
    message = Message.create_from(line_message)
    # chat with GPT
    response = message.chat_gpt(line_message[:message])
    # reply to Line
    message.reply_line(line_message[:reply_token])
    logger.info "end job"
  end
end
