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
end
