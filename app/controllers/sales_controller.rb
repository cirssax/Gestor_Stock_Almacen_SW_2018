class SalesController < ApplicationController
  before_action :authenticate_user!

  def index

    if current_user.id_rol == 1
      @Venta = Sale.select("id, id_usuario, fecha_venta").order('fecha_venta DESC')
    else
      @Venta = Sale.select("id, id_usuario, fecha_venta").where("id_usuario = ?", current_user.id).order('fecha_venta DESC')
    end
  end

  def show
    @id_venta = params[:id]
    @worker = Sale.select("id_usuario, fecha_venta").where("id = ?",@id_venta)
    @FechaVenta = @worker[0].fecha_venta
    @descripcionVenta = Cart.select("id_producto, cantidad").where("sale_id = ?", @id_venta)
    @Productos = Product.select("id, precio, nombre_producto")
    @CostoTotal = 0
    respond_to do |format|
      format.html
      format.pdf {render template: 'sales/boleta', pdf: 'Boleta_de_Venta'}
    end
  end

  def filter

    if current_user.id_rol == 1
      @Venta = Sale.select("id, id_usuario, fecha_venta").where('fecha_venta < ? AND fecha_venta > ?', @Filtro.fecha_termino, @Filtro.fecha_inicio).order('fecha_venta DESC')
      render sales_index_path
    else

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
      @productos_comprados = Cart.select("id_producto, cantidad").where("sale_id = ?", @venta_recien_hecha[0].id)
      #Actualizacion de stock para cada producto seleccionado
      @productos_comprados.each do |producto|
        #Captura del stock actual del producto
        @datos_productos = Product.select("stock, nombre_producto").where("id = ?", producto.id_producto)
        nuevo_stock = @datos_productos[0].stock.to_i - producto.cantidad
        product = Product.find(producto.id_producto.to_i)
        product.update_attribute :stock, nuevo_stock.to_s
        if nuevo_stock < 5
          flash[:danger] = "Producto: "+@datos_productos[0].nombre_producto.to_s+" tiene stock bajo: "+nuevo_stock.to_s
        end
      end
      flash[:success] = "Se ha realizado la venta"
      redirect_to new_sale_path
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

  def sale_params
    params.require(:sale).permit(:fecha_venta, :id_usuario, carts_attributes: [:id ,:id_producto, :cantidad])
  end

  def filtro_params
    params.require(:filter).permit(:fecha_inicio, :fecha_termino)
  end

end
