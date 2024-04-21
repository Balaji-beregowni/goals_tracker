Rails.application.routes.draw do
  # For Goals
  resources :goals do
    resources :okrs, only: [:new, :create]
    member do
      post 'update_okrs'
    end
  end

  # For OKRs
  resources :okrs, only: [:edit, :update, :destroy]
end