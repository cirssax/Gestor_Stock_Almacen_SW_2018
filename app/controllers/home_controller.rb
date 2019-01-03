class HomeController < ApplicationController
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  before_action :permitted_parameters, if: :devise_controller?
  def index
    #Cantidad de productos
    @productos = Product.all
    @CantidadProductos = @productos.length
    #Cantidad de ventas (separada por tipo de usuario)
    if current_user.id_rol == 1
      @Ventas = Sale.select("sales.fecha_venta as fecha, sales.id_trabajador as trabajador").group("sales.fecha_venta, sales.id_trabajador")
    else
      @Ventas = Sale.select("sales.fecha_venta as fecha, sales.id_trabajador as trabajador").where("sales.id_trabajador = '"+current_user.id.to_s+"'").group("sales.fecha_venta, sales.id_trabajador")
    end
    @CantidadVentas = @Ventas.length
  end
end
