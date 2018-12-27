class SalesController < ApplicationController
  before_action :authenticate_user!

  def index
    @Ventas = Sale.select("sales.fecha_venta as fecha, sales.id_trabajador as trabajador").group("sales.fecha_venta, sales.id_trabajador")
  end

  def show
    @FechaVenta = params[:fecha_venta]
    anio = @FechaVenta[0]+@FechaVenta[1]+@FechaVenta[2]+@FechaVenta[3]
    month = @FechaVenta[5]+@FechaVenta[6]
    day = @FechaVenta[8]+@FechaVenta[9]
    hour = @FechaVenta[11]+@FechaVenta[12]
    minutes = @FechaVenta[14]+@FechaVenta[15]
    seconds = @FechaVenta[17]+@FechaVenta[18]
    sentencia = "date_part('year', fecha_venta) = '"+anio+"' AND
                date_part('month', fecha_venta) = '"+month+"' AND
                date_part('day', fecha_venta) = '"+day+"' AND
                date_part('hour', fecha_venta) = '"+hour+"' AND
                date_part('minutes', fecha_venta) = '"+minutes+"' AND
                trunc(date_part('seconds', fecha_venta)) = '"+seconds+"'"
    @descripcionVenta = Sale.select("sales.id_producto, sales.cantidad").where(sentencia)

    @Productos = Product.select("id, precio, nombre_producto")
    @CostoTotal = 0
  end

  def new
    @venta = Sale.new
  end

  def create
    @venta = Sale.new(sale_params)
      @venta.id_trabajador= current_user.id
      @venta.fecha_venta = DateTime.now
      if @venta.save
        redirect_to sales_index_path
      else
        render new_sales_path
      end
  end

  private
  def sale_params
    params.require(:sale).permit(:id_producto, :cantidad, :fecha_venta, :id_trabajador)
  end
end
