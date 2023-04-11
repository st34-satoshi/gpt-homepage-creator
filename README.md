# GPT Homepage Creator
create homepage using ChatGPT

## LINE account
TODO: QR code

## Get Started
- `docker-compose build`
- `docker-compose run web rails db:create`
- `docker-compose run web rails db:migrate`
- `docker-compose run -e EDITOR=vim web rails credentials:edit` # set line_channel_token
- `docker-compose up`
- `open http://localhost:3011`

### In Production
- copy config/master.key (this file is ignored from git)
    - or you can recreate credentials.yml.enc and master.key:
        - `rm credentials.yml.enc`
        - `docker-compose run -e EDITOR=vim web rails credentials:edit`
            - you need to set `Rails.application.credentials` variables
- `docker-compose -f docker-compose.production.yml build`
- `docker-compose -f docker-compose.production.yml run web rails db:create RAILS_ENV=production DISABLE_DATABASE_ENVIRONMENT_CHECK=1`
- `docker-compose -f docker-compose.production.yml up -d`
- when nginx exit before web started: `docker-compose -f docker-compose.production.yml up -d nginx`

### LINE
When you use line webhook set line_channel_id, line_channel_secret, and line_channel_token in credentials.

### ngrok
- `ngrok http 3011`
- set the url to config.hosts in development.rb

## Development
- generate Home controller `docker-compose run web rails g controller Users`
