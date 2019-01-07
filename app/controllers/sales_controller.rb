class SalesController < ApplicationController
  before_action :authenticate_user!

  def index
    if current_user.id_rol == 1
      @Venta = Sale.select("id, id_usuario, fecha_venta")
    else
      @Venta = Sale.select("id, id_usuario, fecha_venta").where("id_usuario = ?", current_user.id)
    end
  end

  def show
    id_venta = params[:id]
    @worker = Sale.select("id_usuario, fecha_venta").where("id = ?",id_venta)
    @FechaVenta = @worker[0].fecha_venta
    @descripcionVenta = Cart.select("id_producto, cantidad").where("sale_id = ?", id_venta)
    @Productos = Product.select("id, precio, nombre_producto")
    @CostoTotal = 0
  end

  def new
    @venta = Sale.new
  end

  def create
    @venta = Sale.new(sale_params)

    @venta.id_usuario= current_user.id
    fecha_actual = DateTime.now
    @venta.fecha_venta = fecha_actual
    if @venta.save
      #Venta correctamente hecha
      # Captura del id de la venta recien hecha
      @venta_recien_hecha = Sale.select("id").where("fecha_venta = ?", fecha_actual)
      #Captura de los productos asociados a la venta recien hecha
      @productos_comprados = Cart.select("id_producto, cantidad").where("sale_id = ?", @venta_recien_hecha[0].id)
      #Actualizacion de stock para cada producto seleccionado
      @productos_comprados.each do |producto|
        #Captura del stock actual del producto
        @datos_productos = Product.select("stock, nombre_producto").where("id = ?", producto.id_producto)
        nuevo_stock = @datos_productos[0].stock.to_i - producto.cantidad
        product = Product.find(producto.id_producto.to_i)
        product.update_attribute :stock, nuevo_stock.to_s
        if nuevo_stock < 5
          flash[:danger] = "Producto: "+@datos_productos[0].nombre_producto.to_s+" tiene stock bajo: "+nuevo_stock.to_s
        end
      end
      flash[:success] = "Se ha realizado la venta"
      redirect_to new_sale_path
    else
      flash[:danger] = "Ha ocurrido un error"
      render new_sale_path
    end
  end

  private
  def sale_params
    params.require(:sale).permit(:fecha_venta, :id_usuario, carts_attributes: [:id ,:id_producto, :cantidad])
  end

end
