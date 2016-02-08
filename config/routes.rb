Rails.application.routes.draw do
  mount Upmin::Engine => '/admin'
  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: '/inbox'
  end
  root to: 'visitors#index'
  devise_for :users
  resources :users
end
