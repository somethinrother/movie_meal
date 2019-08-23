Rails.application.routes.draw do
  namespace :v1, defaults: { format: 'json' } do
    get 'ingredients', to: 'ingredients#index'
  end
end
