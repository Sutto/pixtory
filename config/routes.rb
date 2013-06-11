Pixtory::Application.routes.draw do
  root to: 'root#index'
  resources :moments, only: [:index, :show]

  get 'explore',     to: 'web/moments#index', as: :explore
  get 'explore/:id', to: 'web/moments#show',  as: :explore_moment
  get 'team',        to: 'web/team#index',    as: :team

  get 'moment', to: redirect { |p, req| "/explore/#{req.params[:moment]}" }

end
