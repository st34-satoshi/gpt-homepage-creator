Rails.application.routes.draw do
  root to: 'home#main'
  post '/line_callback', to: 'linebot#callback'
  get 'health', to: 'application#health'
  resources :homepages, only: [:show]
end
