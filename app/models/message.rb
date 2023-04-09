class Message < ApplicationRecord
    def self.gpt_system
        """
        あなたは優秀なエンジニアです。Userの要件を満たすホームページを作成してください。出力には必ずHTML形式を含めてください。
        """
    end

    def self.chat_gpt(text)
        client = OpenAI::Client.new(access_token: Rails.application.credentials.openai_secret_key)
        response = client.chat(
            parameters: {
                model: "gpt-3.5-turbo",
                messages: [
                    { role: "system", content: Message.gpt_system },
                    { role: "user", content: text }
                ],
                temperature: 0.7,
            })
    end

    def reply_line(text, reply_token)
        message = {
          type: 'text',
          text: text
        }
        client.reply_message(reply_token, message)
    end

    def client
        @client ||= Line::Bot::Client.new { |config|
          config.channel_id = Rails.application.credentials.line_channel_id
          config.channel_secret = Rails.application.credentials.line_channel_secret
          config.channel_token = Rails.application.credentials.line_channel_token
        }
    end
end
