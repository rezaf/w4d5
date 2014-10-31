Rails.application.routes.draw do

  resources :users do
    resources :subs, only: [:new]
  end
  
  resources :subs, except: [:new]
  
  resource :session, only: [:new, :create, :destroy]

end
