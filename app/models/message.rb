class Message < ApplicationRecord
    before_create -> {
        self.uuid = SecureRandom.alphanumeric(10)
        self.access_count = 0
    }

    def self.create_from(line_message)
        Message.create(
            user_message: line_message[:message],
            reply_token: line_message[:reply_token],
            user_id: line_message[:user_id],
        )
    end

    def gpt_system
        """
        あなたは優秀なエンジニアです。Userの要件を満たすホームページを作成してください。出力には必ずHTML形式を含めてください。
        """
    end

    def chat_gpt(text)
        logger.info "start chat gpt"
        client = OpenAI::Client.new(access_token: Rails.application.credentials.openai_secret_key)
        response = client.chat(
            parameters: {
                model: "gpt-3.5-turbo",
                messages: [
                    { role: "system", content: gpt_system },
                    { role: "user", content: text }
                ],
                temperature: 0.7,
            })
        logger.info "finish chat gpt"
        logger.info response
        gpt_message = response.dig("choices", 0, "message", "content")
        update(gpt_message: gpt_message)
    end

    def reply_line(reply_token)
        message_gpt = {
          type: "text",
          text: gpt_message
        }
        if valid_html
            message_url = {
              type: "text",
              text: "ホームページを作成しました。以下のURLにアクセスして確認してください。\n#{Rails.application.config.my_domain + "/homepage/" + uuid}"
            }
            client.reply_message(reply_token, [message_gpt, message_url])
        else
            client.reply_message(reply_token, message_gpt)
        end
    end

    def client
        @client ||= Line::Bot::Client.new { |config|
          config.channel_id = Rails.application.config.line_channel_id
          config.channel_secret = Rails.application.config.line_channel_secret
          config.channel_token = Rails.application.config.line_channel_token
        }
    end

    def html_text
        return false unless valid_html
        '<!DOCTYPE html>' + gpt_message.split('<!DOCTYPE html>')[1].split('</html>')[0] + '</html>'
    end

    def valid_html
        return false if gpt_message.nil?
        gpt_message.scan('<!DOCTYPE html>').length == 1 && gpt_message.scan('</html>').length == 1
    end
end
