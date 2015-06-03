EasymealWebsite::Application.routes.draw do
  
  devise_for :users
  resources :allergen_and_favorite_aliments

  resources :categories, except: [:destroy, :edit, :update, :create, :new] 

  resources :recipes

  resources :aliments, except: [:destroy, :new, :create]

  resources :shopping_lists

  resources :stores

  resources :menu_schedules

  resources :homes

  resources :weight_points, except: [:edit, :update, :destroy]

  resources :diet_types

  resources :diseases

  resources :users, except: [:new, :destroy, :edit]

  get "/users/:id/edit/general", to: "users#edit", as: "edit_user"
  
  post "/homes/search", to: "homes#search", as: "search_homes"
  post "/homes/choose", to: "homes#choose", as: "choose_homes"

  post "/diet_types_users", to: "diet_types#add_to_user", as: "add_to_user"
  post "/diseases_users", to: "diseases#add_disease_to_user", as: "add_disease_to_user"

  get "/a_propos", to: "a_propos#a_propos", as: "a_propos"
  get "/recipes_select", to: "recipes#recipes_select", as: "recipes_select"

  root to: 'home#index'
  
  get "/index(.:format)", to: "home#index"
  
  post "/session/create", to: "sessions#create"
  
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
