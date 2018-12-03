Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  #resource :workers
  # nombre del metodo http + nombre del servicio o recurso (URL) + to: + nombre del controlador + # + metodo del controlador
  get '/workers', to: 'workers#index'
  get '/workers/new', to: 'workers#new'
  post '/workers', to: 'workers#create' #Con este se crea el trabajador
  get '/worker/:id/', to: 'workers#show', as: 'worker' #Para editar se necesita esta ruta, ya que se necesita la invocacion
  get '/workers/:id/edit', to: 'workers#edit', as: 'edit_worker'
  patch '/worker/:id', to: 'workers#update' #update
  put '/worker/:id', to: 'workers#update' #update
end
