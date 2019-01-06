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
    #2.times {@venta.carts.build}
  end

  def create
    if params[:sale] == nil
      flash[:danger] = "Debe añadir productos con cantidades"
      @venta = Sale.new
      render new_sale_path
    else
      @venta = Sale.create(sale_params)
        @venta.id_usuario= current_user.id
        @venta.fecha_venta = DateTime.now
        if(@venta.save)
          redirect_to sales_index_path
        else
          render new_sale_path
        end
    end
  end

  private

  def sale_params
    #params.fetch(:sale, {}).permit(:fecha_venta, :id_usuario, carts_attributes: [:id ,:id_producto, :cantidad,:_destroy])
    params.require(:sale).permit(:fecha_venta, :id_usuario, carts_attributes: [:id ,:id_producto, :cantidad,:_destroy])
    #params.require(:sale).permit(:fecha_venta, :id_usuario, cart_attributes: Cart.attribute_names.map(&:to_sym).push(:_destroy))
  end
end
