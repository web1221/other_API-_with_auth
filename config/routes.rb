Rails.application.routes.draw do
  resources :destinations do
    resources :reviews
  end
   post 'authenticate', to: 'authentication#authenticate'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
