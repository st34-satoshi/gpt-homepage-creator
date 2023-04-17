class User < ApplicationRecord

    def self.fetch_profile(token, secret, user_id)
        puts "get profile"
        client = Line::Bot::Client.new { |config|
            # config.channel_secret = Rails.application.config.line_channel_secret
            # config.channel_token = Rails.application.config.line_channel_token
            config.channel_secret = secret
            config.channel_token = token
        }
        response = client.get_profile(user_id)
        case response
        when Net::HTTPSuccess then
            contact = JSON.parse(response.body)
            puts contact['displayName']
            puts contact['pictureUrl']
            puts contact['statusMessage']
        else
            puts "#{
                response.code
            } #{
                response.body
            }"
        end
    end
end
