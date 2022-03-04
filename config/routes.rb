# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  resources :projects do
    resources :bugs, shallow: true
  end
  post '/projects/:id', to: 'projects#remove_user_from_project', as: :remove_user_from_project

  root to: 'projects#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  # get '*path' => redirect('/')
end
