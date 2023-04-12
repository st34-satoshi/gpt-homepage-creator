class GptJob < ApplicationJob
  queue_as :default

  def perform(line_message)
    logger.info "start job"
    message = Message.create_from(line_message)
    template_message = message.template
    if template_message
      message.update(gpt_message: template_message.gpt_message)
      message.reply_line(line_message[:reply_token])
      logger.info "end job template."
      return
    end
    # chat with GPT
    response = message.chat_gpt(line_message[:message])
    # reply to Line
    message.reply_line(line_message[:reply_token])
    logger.info "end job"
  end
end
