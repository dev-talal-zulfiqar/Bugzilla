# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  resources :projects do
    resources :bugs, shallow: true
  end

  root to: 'projects#index'
  resources :projects
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
