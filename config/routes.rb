Rails.application.routes.draw do
  get 'projects/index'
  get 'welcome/index'
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :projects
  resources :prouses do
    post "/adddev", :to => "prouse#adddev", :as => "adddev"
    post "/addqa", :to => "prouse#addqa", :as => "addqa"
    post "/removedev", :to => "prouse#removedev", :as => "removedev"
    post "/removeqa", :to => "prouse#removeqa", :as => "removeqa"
  end
  root to: "welcome#index"
end
