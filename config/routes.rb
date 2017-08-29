Rails.application.routes.draw do
  root to: 'language_data#index'
  get 'search', to: 'language_data#search'
end
