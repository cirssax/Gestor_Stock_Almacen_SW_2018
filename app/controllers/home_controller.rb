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
      @Ventas = Sale.select("sales.fecha_venta as fecha, sales.id_usuario as trabajador").group("sales.fecha_venta, sales.id_usuario")
    else
      @Ventas = Sale.select("sales.fecha_venta as fecha, sales.id_usuario as trabajador").where("sales.id_usuario = '"+current_user.id.to_s+"'").group("sales.fecha_venta, sales.id_usuario")
    end
    @CantidadVentas = @Ventas.length
    #Cantidad de usuarios activos del sistema
    @Usuarios = User.select("users.id").where("id_estado = 1")
    @CantidadUsuarios = @Usuarios.length
    #Alertas
    @Productos  = Product.select("products.id").where("products.stock < 5")
    @ProductosStockBajo = @Productos.length
  end

  def show
    @Producto = Product.select("products.nombre_producto, products.stock").where("products.stock < 5")
  end
end
