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
      @producto = Product.select("nombre_producto, id_tipo, id").find(params[:id])
      @producto_show = Product.select("stock, precio").find(params[:id])
      @antiguo_stock = @producto_show.stock
      @antiguo_precio = @producto_show.precio
      @producto[:precio] =
      @producto[:stock] =
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
      producto = Product.find(params[:id])

      #Captura del ID
      id = params["id"]

      #Captura del stock y precios nuevos
      nuevo_stock = params["product"]["stock"]
      nuevo_stock = nuevo_stock.to_f
      nuevo_precio = params["product"]["precio"]
      nuevo_precio = nuevo_precio.to_f

      if nuevo_stock <= 0 || nuevo_stock >= 100 #Validacion de la cantidad de stock
        flash[:warning] = "Stock debe ser mayor a cero o menor a 100"
        redirect_to edit_product_path
      else
        if nuevo_precio <= 0 || nuevo_precio >= 50000 #Validacion del precio
          flash[:warning] = "Precio debe ser mayor a cero o menor a $50.000"
          redirect_to edit_product_path
        else
          #Captura del stock y precios anteriores
          antiguo_precio = producto[:precio]
          antiguo_precio = antiguo_precio.to_f
          antiguo_stock = producto[:stock]
          antiguo_stock = antiguo_stock.to_f

          #Ponderaciones de las cantidades
          pond_nueva = nuevo_stock/(nuevo_stock + antiguo_stock)
          pond_antigua = antiguo_stock/(nuevo_stock + antiguo_stock)

          #Precio nuevo ponderado
          precio_ponderado = (pond_nueva * nuevo_precio) + (pond_antigua * antiguo_precio)

          #Tipo de producto
          tipo = params["product"]["id_tipo"]
          producto.update_attribute :id_tipo, tipo
          producto.update_attribute :stock, (nuevo_stock.to_i + antiguo_stock.to_i).to_s
          producto.update_attribute :precio, precio_ponderado.to_i
          redirect_to product_path
        end
      end
    end
  end



  private
  def producto_params
    params.require(:product).permit(:nombre_producto, :id_tipo, :precio, :stock)
  end


end
