class TypesController < ApplicationController
  before_action :authenticate_user!

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
    aux = params[:id]
    @types = Type.find(aux)
  end

  private
  def tipo_params
    params.require(:type).permit(:descrip_tipo)
  end

end
