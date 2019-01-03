class TypesController < ApplicationController
  before_action :authenticate_user!
  def index
    @types = Type.all
  end

  def new
    if current_user.id_rol != 1
      flash[:warning] = "No posee los roles para esta acción"
    else
      @types = Type.new
    end

  end

  def create
    if current_user.id_rol != 1
      flash[:warning] = "No posee los roles para esta acción"
    else
      @types = Type.new(tipo_params)
      if @types.save
        flash[:succes] = "Almacenamiento correcto"
        redirect_to types_index_path
      else
        render types_new_path
      end
    end
  end

  def edit
    if current_user.id_rol != 1
      flash[:warning] = "No posee los roles para esta acción"
    else
      @types = Type.find(params[:id])
    end

  end

  def show
    @tipo = Type.find(params[:id])
    @productos = Product.select("products.nombre_producto").where("products.id_tipo = (?) ", Type.select("types.id").where("types.id='"+params[:id]+"'"))
    @cantidad =  @productos.length.to_s
  end

  private
  def tipo_params
    params.require(:type).permit(:descrip_tipo)
  end
end
