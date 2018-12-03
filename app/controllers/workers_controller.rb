class WorkersController < ApplicationController

  def index
    @Usuarios = Worker.all
  end

  def new
    @ListaRoles = Role.all
    @ListaEstado = State.all
    @worker = Worker.new
  end

  def create
    #render plain: params[:worker].inspect
    @worker = Worker.new(worker_params)
    if @worker.save
        redirect_to workers_path
    else
       render CrearUsuario
    end

  end

  def edit
    @ListaRoles = Role.all
    @ListaEstado = State.all
    @worker = Worker.find(params[:id])
  end

  def update
    @worker = Worker.find(params[:id])
    if @worker.update(worker_params)
      redirect_to workers_path
    else
      render :edit
    end
  end

  private
  def worker_params
    params.require(:worker).permit(:nombre_trabajador, :apellidos_trabajador, :rut, :dv,:fono, :domicilio, :id_rol, :id_estado)
  end

end
