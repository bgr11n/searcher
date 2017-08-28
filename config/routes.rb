Rails.application.routes.draw do
  root to: 'data#index'
  get 'search', to: 'data#search'
end
