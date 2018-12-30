class TypesController < ApplicationController
  before_action :authenticate_user!

  def index
    @type = Type.all
  end

  def new
    @type = Type.new
  end

  def create
    @type = Type.new(type_params)
    if @type.save
       flash[:succes] = "Almacenamiento correcto"
      redirect_to types_index_path
    else
      render :new
    end
  end

  def edit
    @type = Type.find(params[:id])
  end

  private
  def type_params
    params.require(:type).permit(:descrip_tipo)
  end

end
