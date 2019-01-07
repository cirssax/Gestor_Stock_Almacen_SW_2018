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

    if current_user.id_rol == 1
      #Tablas de últimas ventas
      @UltimasVentas = Sale.last(10)
      #Genero un arreglo de cada venta
      @ListaVenta = []
      @UltimasVentas.each do |venta|
        #Obtencion del producto y la cantidad
        @Productos = Cart.select("id_producto, cantidad").where("sale_id = ?", venta.id.to_s)
        monto = 0
        #Se calcula el monto total vendido
        @Productos.each do |costo|
          #Obtencion del costo unitario del producto
          @CostoUnitario = Product.select("precio").where("id = ?", costo.id_producto)
          monto = monto + (costo.cantidad.to_i * @CostoUnitario[0].precio.to_i)
        end
        l1 = Lista.new(monto, venta.id_usuario, venta.fecha_venta)
        @ListaVenta.push(l1)
      end
    else
      #Tablas de últimas ventas
      @UltimasVentas = Sale.where("id_usuario = ?", current_user.id).last(5)
      #Genero un arreglo de cada venta
      @ListaVenta = []
      @UltimasVentas.each do |venta|
        #Obtencion del producto y la cantidad
        @Productos = Cart.select("id_producto, cantidad").where("sale_id = ?", venta.id.to_s)
        monto = 0
        #Se calcula el monto total vendido
        @Productos.each do |costo|
          #Obtencion del costo unitario del producto
          @CostoUnitario = Product.select("precio").where("id = ?", costo.id_producto)
          monto = monto + (costo.cantidad.to_i * @CostoUnitario[0].precio.to_i)
        end
        l1 = Lista.new(monto, venta.id_usuario, venta.fecha_venta)
        @ListaVenta.push(l1)
      end
    end




  end

  def show
    @Producto = Product.select("products.nombre_producto, products.stock").where("products.stock < 5")
  end

  private
  class Lista
    attr_accessor :monto
    attr_accessor :usuario
    attr_accessor :fecha

    def initialize(monto, usuario, fecha)
      @monto = monto
      @usuario = usuario
      @fecha = fecha
    end
  end

end
