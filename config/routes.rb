require 'sidekiq/web'

Rails.application.routes.draw do
  mount Upmin::Engine => '/admin'
  mount ActionCable.server => '/cable'

  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: '/inbox'
  end

  authenticated :user, -> (u) { u.admin? } do
    mount Sidekiq::Web, at: '/sidekiq'
  end

  root to: 'games#index'

  devise_for :users
  resources :users

  resources :games, only: [:index, :show, :new, :create, :update, :update, :destroy] do
    resources :questions
  end

  %w( 401 404 422 500 ).each do |code|
    match code, to: 'errors#show', code: code, via: :all
  end

  match 'alexa', to: 'alexa#handle', via: :all
  resources :text_messages, only: [:new, :create]
end
