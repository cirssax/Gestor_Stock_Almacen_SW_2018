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
      puts "Almacenamiento correcto"
      redirect_to products_index_path
    else
      #puts @producto.errors.full_messages.join(" ", " ")
      render :new
    end
  end

  def edit
    @producto = Product.find(params[:id])
    @Tipos = Type.all
  end

  def show
    @Tipos = Type.all
  end

  def update

    @producto = Product.find(params[:id])

    if @producto.update(producto_params)
      redirect_to products_index_path
    else
      render :edit
    end
  end



  private
  def producto_params
    params.require(:product).permit(:nombre_producto, :id_tipo, :precio, :stock)
  end


end
