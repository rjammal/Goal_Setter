Rails.application.routes.draw do
  
  resources :users, only: [:create, :new, :show] do
    resources :user_comments, shallow: true, only: [:create, :destroy]
  end
  resource :session, only: [:create, :new, :destroy]
  resources :goals do
    resources :goal_comments, shallow: true, only: [:create, :destroy]
  end
end
