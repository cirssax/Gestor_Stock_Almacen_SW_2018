class ListaUsuariosController < ApplicationController
  def index
    @users = User.all
    @rol = Role.all
  end

  def new
    @user = User.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def create
    #render plain: params[:user].inspect
    @user = User.new(user_path)
    if(@user.save)
      redirect_to users_path
    else
      render new_lista_usuario_path
    end
  end

  def update
    @user = User.find(params[:id])
    if(@user.update(user_params))
      redirect_to users_path
    else
      render :edit
    end
  end

  private
  def user_params
    params.require(:user).permit(:nombre_trabajador, :apellidos_trabajador, :rut, :dv,:fono, :domicilio, :id_rol, :id_estado)
  end
end
