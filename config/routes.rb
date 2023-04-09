Rails.application.routes.draw do
  post '/line_callback', to: 'linebot#callback'
  get 'health', to: 'application#health'
  resources :homepages, only: [:show]
end
