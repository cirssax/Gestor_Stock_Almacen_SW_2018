class UsersController < ApplicationController
  before_action :allow_without_password, only: [:update]
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
    @user = User.new(user_params)
    if @user.save
      redirect_to users_path
    else
      render new_user_path
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to users_path
    else
      render :edit
    end
  end

  private
  def user_params
    params.require(:user).permit(:password_confirmation,:email,:password ,:nombre_trabajador, :apellidos_trabajador, :rut, :dv,:fono, :domicilio, :id_rol, :id_estado)
  end
  def allow_without_password
    if params[:user][:password].blank? && params[:user][:password_confirmation].blank?
      params[:user].delete(:password)
      params[:user].delete(:password_confirmation)
    end
  end
end
