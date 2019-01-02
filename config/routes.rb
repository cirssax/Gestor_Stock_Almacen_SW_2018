Rails.application.routes.draw do
  devise_for :users, module: "users",:path_prefix =>'devise' #rutaspara el modulo de user devise
  resources :users #rutas personalizadas para crear usuarios
  post '/users/new', to: 'users#create'
  patch '/users/:id', to: 'users#update' #update
  put '/users/:id', to: 'users#update' #update


  root 'home#index'

  #Ruta de los productos
  get 'products/index'
  root :to => "products#index"

  resources :products


  #Ruta de los tipos
  #get '/types/index', to: 'types#index'
  #get '/types/new', to: 'types#new'
  #post '/types', to: 'types#create'
  #get '/types/:id/edit', to: 'types#edit', as: 'types_edit'
  #patch '/types/:id', to: 'types#update'
  #put '/types/:id', to: 'types#update'
  #root :to =>'types#index'
  resources :types

  #Rutas de las vetnas
  get 'sales/index'


  resources :sales

  get '/sales/:fecha_venta/', to: 'sales#show', as: 'descrip_sale'

end
