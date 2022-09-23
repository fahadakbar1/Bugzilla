# frozen_string_literal: true

Rails.application.routes.draw do
  default_url_options host: 'http://localhost:3000'
  devise_for :users

  resources :projects do
    resources :bugs, except: :index
  end

  resources :prouses do
    post '/add_developer', to: 'prouse#add_developer', as: 'add_developer'
    post '/add_qa', to: 'prouse#add_qa', as: 'add_qa'
    post '/remove_developer', to: 'prouse#remove_developer', as: 'remove_developer'
    post '/remove_qa', to: 'prouse#remove_qa', as: 'remove_qa'
  end

  post '/assign', to: 'bugs#assign', as: 'assign'
  post '/markcomplete', to: 'bugs#markcomplete', as: 'markcomplete'

  root to: 'projects#welcome'
end
