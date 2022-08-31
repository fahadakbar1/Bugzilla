Rails.application.routes.draw do

  default_url_options :host => "http://localhost:3000"
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :projects do
    resources :bugs
  end

  resources :prouses do
    post "/adddev", :to => "prouse#adddev", :as => "adddev"
    post "/addqa", :to => "prouse#addqa", :as => "addqa"
    post "/removedev", :to => "prouse#removedev", :as => "removedev"
    post "/removeqa", :to => "prouse#removeqa", :as => "removeqa"
  end

  post "/assign", :to => "bugs#assign", :as => "assign"
  post "/markcomplete", :to => "bugs#markcomplete", :as => "markcomplete"


  root to: "welcome#index"
end
