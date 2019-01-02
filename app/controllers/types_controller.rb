class TypesController < ApplicationController
  before_action :authenticate_user!
  #before_action :set_type, only: [:edit]

  def index
    @types = Type.all
  end

  def new
    @types = Type.new
  end

  def create
    @types = Type.new(tipo_params)
    if @types.save
      flash[:succes] = "Almacenamiento correcto"
      redirect_to types_index_path
    else
      render types_new_path
    end
  end

  def edit
    @types = Type.find(params[:id])
  end

  private
  def tipo_params
    params.require(:type).permit(:descrip_tipo)
  end

  def set_type
    @type = Type.find(params[:id])
  end

end
