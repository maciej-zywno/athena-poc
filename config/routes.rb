Rails.application.routes.draw do
  mount Upmin::Engine => '/admin'
  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: '/inbox'
  end
  root to: 'visitors#index'
  devise_for :users
  resources :users

  resources :practices, only: [:index, :show] do
    resources :patients, only: [:destroy]

    resources :departments, only: :show do
      resources :patients, only: [:new, :create]
    end
  end
end
