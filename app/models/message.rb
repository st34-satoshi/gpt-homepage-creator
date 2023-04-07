class Message < ApplicationRecord
    def self.chat_gpt(message_attributes)
        client = OpenAI::Client.new(access_token: Rails.application.credentials.openai_secret_key)
        response = client.chat(
            parameters: {
                model: "gpt-3.5-turbo",
                messages: [{ role: "user", content: "Hello!"}],
                temperature: 0.7,
            })
    end
end
