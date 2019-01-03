class SalesController < ApplicationController
  before_action :authenticate_user!

  def index
    if current_user.id_rol == 1
      @Ventas = Sale.select("sales.fecha_venta as fecha, sales.id_trabajador as trabajador").group("sales.fecha_venta, sales.id_trabajador")

    else
      @Ventas = Sale.select("sales.fecha_venta as fecha, sales.id_trabajador as trabajador").where("sales.id_trabajador = '"+current_user.id.to_s+"'").group("sales.fecha_venta, sales.id_trabajador")
    end
  end

  def show
    @FechaVenta = params[:id]
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

    @worker = Sale.select("id_trabajador").where(sentencia)

    @descripcionVenta = Sale.select("sales.id_producto, sales.cantidad").where(sentencia)

    @Productos = Product.select("id, precio, nombre_producto")
    @CostoTotal = 0
  end

  def new
    @venta = Sale.new
  end

  def create
    @venta = Sale.new(sale_params)
    if @venta.id_producto == nil
      flash[:warning] = "Seleccione un producto"
      render new_sale_path
    else
      if @venta.cantidad == nil
        flash[:warning] = "Seleccione una cantidad"
        render new_sale_path
      else
        @venta.id_trabajador= current_user.id
        @venta.fecha_venta = DateTime.now
        stock_producto = Product.select("stock, nombre_producto, id").where("id = '"+ @venta.id_producto.to_s+"'")
        if @venta.cantidad.to_i > stock_producto[0].stock.to_i
          flash[:warning] = "Cantidad mayor al stock disponible"
          flash[:notice] = "Stock disponible del producto: "+stock_producto[0].nombre_producto.to_s+": "+stock_producto[0].stock.to_s
          redirect_to new_sale_path
        else
          if @venta.save
            nuevo_stock = stock_producto[0].stock.to_i - @venta.cantidad.to_i
            product = Product.find(stock_producto[0].id.to_i)
            product.update_attribute :stock, nuevo_stock.to_s
            flash[:succes] = "Venta realizada con exito"
            redirect_to new_sale_path
          else
            render new_sale_path
          end
        end
      end
    end
  end

  private
  def sale_params
    params.require(:sale).permit(:id_producto, :cantidad, :fecha_venta, :id_trabajador)
  end
end
