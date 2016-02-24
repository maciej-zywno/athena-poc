Rails.application.routes.draw do
  mount Upmin::Engine => '/admin'
  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: '/inbox'
  end
  root to: 'visitors#index'
  devise_for :users
  resources :users

  resources :practices, only: [:index, :show] do
    resources :departments, only: :show do
      resources :patients do
        member do
          post :invite
        end
      end
    end
  end

  %w( 401 404 422 500 ).each do |code|
    match code, to: 'errors#show', code: code, via: :all
  end
end
