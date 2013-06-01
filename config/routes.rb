Pixtory::Application.routes.draw do
  root to: 'root#index'
  resources :moments, only: [:index, :show]
end
