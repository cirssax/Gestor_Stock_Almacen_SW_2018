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
      @venta.fecha_venta = DateTime.now
      if @venta.save
        flash[:success] = "Se ha realizado la venta"
        redirect_to sales_index_path
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
