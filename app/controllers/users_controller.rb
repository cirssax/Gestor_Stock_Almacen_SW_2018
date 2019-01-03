class UsersController < ApplicationController
  before_action :allow_without_password, only: [:update]
  def index
    if current_user.id_rol != 1
      flash[:warning] = "No posee los roles para esta acción"
    else
      @users = User.all
      @rol = Role.all
    end
  end

  def new
    if current_user.id_rol != 1
      flash[:warning] = "No posee los roles para esta acción"
    else
      @user = User.new
    end

  end

  def edit
    if current_user.id_rol != 1
      flash[:warning] = "No posee los roles para esta acción"
    else
      @user = User.find(params[:id])
    end

  end

  def create
    #render plain: params[:user].inspect
    if current_user.id_rol != 1
      flash[:warning] = "No posee los roles para esta acción"
    else
      @user = User.new(user_params)
      if @user.save
        redirect_to users_path
      else
        render new_user_path
      end
    end

  end

  def update
    if current_user.id_rol != 1
      flash[:warning] = "No posee los roles para esta acción"
    else
      @user = User.find(params[:id])
      if @user.update(user_params)
        redirect_to users_path
      else
        render :edit
      end
    end
  end

  def show
    @user = User.find(params[:id])
  end

  private
  def user_params
    params.require(:user).permit(:password_confirmation,:email,:password ,:nombre_trabajador, :apellidos_trabajador, :rut,:fono, :domicilio, :id_rol, :id_estado)
  end
  def allow_without_password
    if params[:user][:password].blank? && params[:user][:password_confirmation].blank?
      params[:user].delete(:password)
      params[:user].delete(:password_confirmation)
    end
  end
end
