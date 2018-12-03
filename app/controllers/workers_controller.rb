class WorkersController < ApplicationController

  def ListarUsuarios
    @Usuarios = Worker.all
  end

  def CrearUsuario
    @ListaRoles = Role.all
    @ListaEstado = Array.new
    @ListaEstado = [[:name =>"ACTIVO", :id=>"1"][:name =>"INACTIVO", :id=>"0"]]
  end

  def create
    #render plain: params[:worker].inspect
    @worker = Worker.new worker_params

  end

  private
  def worker_params
    params.require(:worker).permit(:nombre_trabajador, :apellidos_trabajador, :rut, :dv,:fono, :domicilio, :id_rol, :estado)
  end

end
