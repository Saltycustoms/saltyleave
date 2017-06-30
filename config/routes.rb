Rails.application.routes.draw do
  get 'login/index'
  get 'leave_types/index'
  get '/download/:id', to: 'leave_applications#download', as: 'download'
  devise_for :users

  resources :leave_types
  resources :leave_applications
  put "leave_applications/:id/review", to: "leave_applications#review", as: "review"
  resources :approvals
  resources :users

  root 'leave_applications#index'
end
