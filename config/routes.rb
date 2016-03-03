require 'sidekiq/web'

Rails.application.routes.draw do
  mount Upmin::Engine => '/admin'

  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: '/inbox'
  end

  authenticated :user, -> (u) { u.admin? } do
    mount Sidekiq::Web, at: '/sidekiq'
  end

  root to: 'visitors#index'

  devise_for :users
  resources :users

  resources :practices, only: [:index, :show] do
    resources :insurance_packages, only: :index
    resources :providers, only: :index do
      member do
        post :invite
      end
    end

    resources :departments, only: [:index, :show] do
      resources :patients do
        member do
          post :invite
        end
      end
    end
  end

  resources :treatments, only: [:index, :show] do
    resources :questions
  end

  %w( 401 404 422 500 ).each do |code|
    match code, to: 'errors#show', code: code, via: :all
  end

  match 'alexa', to: 'alexa#handle', via: :all
  resources :text_messages, only: [:new, :create]
end
