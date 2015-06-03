# -*- encoding : utf-8 -*-
EasymealWebsite::Application.routes.draw do
  
  namespace :admin do
    get "/", to: "dashboard#index", as: "dashboard_index"
    get "/recipes", to: "recipes#index", as: "recipes"
    get "/recipes/:id", to: "recipes#show", as: "recipe"
    post "/recipes/:id/validate", to: "recipes#validate", as: "recipe_validate"
    post "/recipes/:id/refuse", to: "recipes#refuse", as: "recipe_refuse"
  end
  
  resources :stocks
  post "/stock_alim", to: "stocks#associate_to_stock", as: "associate_to_stock"
  post "/stock_reinit", to: "stocks#reinit_stock", as: "reinit_stock"
  post "/stock_alim_remove", to: "stocks#remove_alim_stock", as: "remove_alim_stock"
  post "/stock_alim_update", to: "stocks#stock_alim_update", as: "stock_alim_update"

  devise_for :users, controllers: { registrations: 'registrations' }
  resources :allergen_and_favorite_aliments

  resources :categories, except: [:destroy, :edit, :update, :create, :new] 

  # resources :recipes
  resources :recipes do
    get :autocomplete_aliment_name, :on => :collection
  end
  get "/aliments/pending_recipes", to: "recipes#pendingRecipes"

  resources :aliments, except: [:destroy, :new, :create]
  get "/aliments/search", to: "aliments#search", as: "get_searched_aliments"

  resources :shopping_lists
  post "/shopping_lists_alim", to: "shopping_lists#associate_to_shopping_lists", as: "associate_to_shopping_lists"
  post "/shopping_lists_alim_reinit", to: "shopping_lists#reinit_shopping_lists", as: "reinit_shopping_lists"
  post "/shopping_lists_alim_remove", to: "shopping_lists#remove_alim_list", as: "remove_alim_list"
  post "/shopping_lists_alim_update", to: "shopping_lists#alim_list_update", as: "alim_list_update"
  post "/shopping_lists_alim_validate", to: "shopping_lists#alim_list_validate", as: "alim_list_validate"

  resources :stores

  resources :menu_schedules, only: [:index, :planning_generation]
  post "/menu_schedule/planning_generation", to: "menu_schedules#planning_generation", as: "menu_schedule_planning_generation"
  post "/menu_schedule/associate", to: "menu_schedules#associate", as: "menu_schedule_associate"
  post "/menu_schedule/dissociate", to: "menu_schedules#dissociate", as: "menu_schedule_dissociate"

  resources :homes

  resources :weight_points, except: [:edit, :update, :destroy]

  resources :diet_types

  resources :diseases

  resources :users, except: [:new, :destroy, :edit, :index, :create]

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

  get "downloads/documentation_utilisateur"
  
  get "downloads/documentation_technique"

end
