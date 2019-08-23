Rails.application.routes.draw do
  namespace :v1, defaults: { format: 'json' } do
    resources :ingredients
  end
end
