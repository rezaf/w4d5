Rails.application.routes.draw do

  resources :users do
    resources :subs, only: [:new]
  end
  
  resources :subs, except: [:new] do
    resources :posts, only: [:new]
  end
  
  resources :posts, except: [:new, :index, :destroy]
  
  resource :session, only: [:new, :create, :destroy]

end
