class ProductsController < ApplicationController
  before_action :authenticate_user!

  def index
    @Productos = Product.all
    @Tipos = Type.all
  end

  def new
    @producto = Product.new
    @Tipos = Type.all
  end

  def create
    @producto = Product.new(producto_params)

    if @producto.save
      flash[:success] = "Almacenamiento correcto"
      redirect_to new_product_path
    else
      render :new
    end
  end

  def edit
    if current_user.id_rol != 1
      flash[:warning] = "No posee los roles para esta acción"
    else
      @producto = Product.find(params[:id])
      @Tipos = Type.all
    end
  end

  def show
    @Tipos = Type.all
    @producto = Product.find(params[:id])
  end

  def update
    if current_user.id_rol != 1
      flash[:warning] = "No posee los roles para esta acción"
    else
      @producto = Product.find(params[:id])

      if @producto.update(producto_params)
        flash[:success] = "Producto actualizado"
        redirect_to new_product_path
      else
        render products_index_path
      end
    end
  end



  private
  def producto_params
    params.require(:product).permit(:nombre_producto, :id_tipo, :precio, :stock)
  end


end
