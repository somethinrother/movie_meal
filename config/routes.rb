Rails.application.routes.draw do
  namespace :v1, defaults: { format: 'json' } do
    resources :ingredients, only: [:index]
    resources :recipes, only: [:index]
    resources :movies, only: [:index]
  end

  get '*page', to: 'static#index', constraints: ->(req) do
    !req.xhr? && req.format.html?
  end

  root 'static#index'
end
