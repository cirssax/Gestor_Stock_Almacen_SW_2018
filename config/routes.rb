Rails.application.routes.draw do
  devise_for :users, module: "users"
  resources :users


  root 'home#index'

  #Ruta de los productos
  get 'products/index'
  root :to => "products#index"

  resources :products
  root 'products#index'

  #Rutas para el crud de usuarios
  #get 'lista_usuarios/index', to:'lista_usuarios#index'
  #get 'lista_usuarios/new', to:'lista_usuarios#new'
  #get 'lista_usuarios/:id/edit', to:'lista_usuarios#edit'

  resources :lista_usuarios
  resource :types
  root 'types#new'

  get 'sales/index'
  root :to =>"sales#index"

  resource :sales
  root 'sales#index'
  

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  #root 'home#index'
  #delete '/users/sign_out', to:'devise/sessions#destroy'

  #get 'users/sign_in', to: 'devise/registrations#new'
  #resource :users
  # nombre del metodo http + nombre del servicio o recurso (URL) + to: + nombre del controlador + # + metodo del controlador
  #get '/workers', to: 'workers#index'
  #get '/workers/new', to: 'workers#new'
  #post '/workers', to: 'users#create' #Con este se crea el trabajador
  #get '/worker/:id/', to: 'workers#show', as: 'worker' #Para editar se necesita esta ruta, ya que se necesita la invocacion
  #get '/workers/:id/edit', to: 'workers#edit', as: 'edit_worker'
  #patch '/users/:id', to: 'users#update' #update
  #put '/users/:id', to: 'users#update' #update
end
