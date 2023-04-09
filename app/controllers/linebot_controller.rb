class LinebotController < ApplicationController
    skip_forgery_protection

    def callback
        body = request.body.read
        signature = request.env['HTTP_X_LINE_SIGNATURE']
        unless client.validate_signature(body, signature)
          error 400 do 'Bad Request' end
        end
        events = client.parse_events_from(body)

        events.each do |event|
          case event
          when Line::Bot::Event::Message
            case event.type
            when Line::Bot::Event::MessageType::Text
                line_message = {
                  message: event.message['text'],
                  reply_token: event['replyToken'],
                  user_id: event['source']['userId']
                }
                GptJob.perform_later line_message
            end
          end
        end
        render status: 200, json: { status: 200, message: "OK" }
    end

    def client
        @client ||= Line::Bot::Client.new { |config|
          config.channel_id = Rails.application.credentials.line_channel_id
          config.channel_secret = Rails.application.credentials.line_channel_secret
          config.channel_token = Rails.application.credentials.line_channel_token
        }
    end
end
