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
  root :to => 'products#index'

  resource :types
  root :to =>'types#index'
  get 'types/index', to: 'types#index'
  get 'types/:id/edit', to: 'types#edit', as: 'edit_type'

  get 'sales/index'
  root :to =>"sales#index"

  resource :sales
  root :to =>'sales#index'

  get 'sales/:fecha_venta/', to: 'sales#show', as: 'descrip_sale'

end
