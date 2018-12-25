class SalesController < ApplicationController
  before_action :authenticate_user!

  def index
    @Ventas = Sale.select("sales.fecha_venta as fecha, sales.id_trabajador as trabajador").group("sales.fecha_venta, sales.id_trabajador")
  end

  def show
    @FechaVenta = params[:fecha_venta]
    @descripcionVenta = Sale.select("sales.id_producto, sales.cantidad").where(fecha_venta: @FechaVenta)
    @Productos = Product.select("id, precio, nombre_producto")
    @CostoTotal = 0
  end

  def new
    @venta = Sale.new
    @productos = Product.select("products.nombre_producto, products.stock, products.id").where("stock > ?", 0)
    @prod_select = 0
  end

  def create
    @venta.id_trabajador = current_user.id
    @venta = Sale.new(sale_params)
    if @venta.save
      redirect_to sales_index_path
    else
      render new_sales_path
    end
  end

  private
  def sale_params
    params.require(:sale).permit(:id_trabajador, :id_producto, :cantidad, :fecha_venta)
  end
end
