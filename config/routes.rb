Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resource :workers
  # nombre del metodo http + nombre del servicio o recurso (URL) + to: + nombre del controlador + # + metodo del controlador
  get 'workers/ListaUsuarios', to: 'workers#ListarUsuarios'
  get 'workers/Nuevo', to: 'workers#CrearUsuario'

end
