Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'landing#index'
  resources :topics, except: [:show] do
    resources :posts, except: [:show]
  end
end
