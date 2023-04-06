# GPT Homepage Creator
create homepage using ChatGPT

## LINE account
TODO: QR code

## Get Started
- `docker-compose build`
- `docker-compose run web rails db:create`
- `docker-compose up`
- `open http://localhost:3011`

### LINE
When you use line webhook set line_channel_id, line_channel_secret, and line_channel_token in credentials.

### ngrok
- `ngrok http 3011`
- set the url to config.hosts in development.rb

## Development
- generate Home controller `docker-compose run web rails g controller Users`
