Rails.application.routes.draw do
  resources :conversations, only: [:index, :show]  do
    resources :messages, controller: 'texts', only: [:index, :show]
  end
  resources :messages, controller: 'texts', only: [:create]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
