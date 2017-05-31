Rails.application.routes.draw do
  get 'login/index'
  get '/download/:id', to: 'leave_applications#download', as: 'download'
  devise_for :users

  resources :leave_applications
  resources :approvals
  resources :users

  root 'leave_applications#index'
end
