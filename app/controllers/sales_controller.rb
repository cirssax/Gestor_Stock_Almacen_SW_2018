class SalesController < ApplicationController
  before_action :authenticate_user!

  def index
    if current_user.id_rol == 1
      @users = []
      @usuarios = User.all
      @usuarios.each do |usr|
        nodo = Usuarios.new(usr.nombre_trabajador, usr.apellidos_trabajador, usr.id, usr.rut)
        @users.push(nodo)
      end
      if params[:commit] == "Resetear"
        @search = SaleSearch.new(params[:search], -1)
        @Venta = Sale.all
      else
        @search = SaleSearch.new(params[:search], -1)
        @Venta = @search.scope
      end
    else
      if params[:commit] == "Resetear"
        @search = SaleSearch.new(params[:search], current_user.id)
        @Venta = @search.scope
      else
        @search = SaleSearch.new(params[:search], current_user.id)
        @Venta = @search.scope
      end
    end

  end

  def show
    @id_venta = params[:id]
    @worker = Sale.select("id_usuario, fecha_venta").where("id = ?",@id_venta)
    @FechaVenta = @worker[0].fecha_venta
    @descripcionVenta = Cart.select("id_producto, cantidad, precio_actual").where("sale_id = ?", @id_venta)
    @Productos = Product.select("id, nombre_producto")
    @CostoTotal = 0
    respond_to do |format|
      format.html
      format.pdf {render template: 'sales/boleta', pdf: 'Boleta_de_Venta '+ @FechaVenta.strftime('%d-%m-%Y__%H-%M-%S'), page_size: 'A5', orientation: 'Landscape'}
    end
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
      @productos_comprados = Cart.select("id_producto, cantidad, precio_actual, id").where("sale_id = ?", @venta_recien_hecha[0].id)
      #Actualizacion de stock para cada producto seleccionado
      @productos_comprados.each do |producto|
        #Captura del stock actual del producto
        @datos_productos = Product.select("stock, nombre_producto, precio").where("id = ?", producto.id_producto)
        #Captura de la cantidad comprada
        nuevo_stock = @datos_productos[0].stock.to_i - producto.cantidad
        product = Product.find(producto.id_producto.to_i)
        product.update_attribute :stock, nuevo_stock.to_s

        if nuevo_stock < 5
          flash[:danger] = "Producto: "+@datos_productos[0].nombre_producto.to_s+" tiene stock bajo: "+nuevo_stock.to_s
        end
      end
      flash[:success] = "Se ha realizado la venta"
      redirect_to descrip_sale_path(@venta_recien_hecha[0].id)
    else
      flash[:danger] = "Ha ocurrido un error"
      render new_sale_path
    end
  end

  private

  class Filter
    attr_accessor :fecha_inicio
    attr_accessor :fecha_termino

    def initialize(fecha_inicio, fecha_termino)
      @fecha_inicio = fecha_inicio
      @fecha_termino = fecha_termino
    end
  end

  class Usuarios
    attr_accessor :nombre_completo
    attr_accessor :id

    def initialize(nombre, apellido, id, rut)
      @nombre_completo = nombre.titlecase + " " + apellido.titlecase + " --- " + rut
      @id = id
    end

  end

  def sale_params
    params.require(:sale).permit(:fecha_venta, :id_usuario, carts_attributes: [:id ,:id_producto, :cantidad, :precio_actual])
  end

  def filtro_params
    params.require(:filter).permit(:fecha_inicio, :fecha_termino, :id_usuario)
  end

end
