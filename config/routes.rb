Rails.application.routes.draw do
  devise_for :users, module: "users",:path_prefix =>'devise' #rutaspara el modulo de user devise
  resources :users #rutas personalizadas para crear usuarios
  post '/users/new', to: 'users#create'
  patch '/users/:id', to: 'users#update' #update
  put '/users/:id', to: 'users#update' #update


  root 'home#index'
  get '/home/show', to: "home#show", as: 'warnings_descrips'

  #Ruta de los productos
  get 'products/:id/edit_name', to:'products#edit_name', as: 'edit_name'

  resources :products

  resources :types

  #Rutas de las vetnas
  get 'sales/index'

  resources :sales

  get '/sales/:sale_id/', to: 'sales#show', as: 'descrip_sale'

end
