class ProductsController < ApplicationController
  before_action :authenticate_user!

  def index
    @tipos = Type.all
    @listado_tipos = []
    @tipos.each do |tipo|
      nodo = Tipos.new(tipo.descrip_tipo, tipo.id)
      @listado_tipos.push(nodo)
    end
    if params[:commit] == "Resetear"
      @search = ProductSearch.new(params[:search], -1)
      @prod= @search.scope
    else
      @search = ProductSearch.new(params[:search], 0)
      @prod = @search.scope
    end
    @Productos = []
    @prod.each do |producto|
      nodo = Productos.new(producto.nombre_producto, producto.precio, producto.id, producto.stock)
      @Productos.push(nodo)
    end
  end

  def new
    @producto = Product.new
    @Tipos = Type.all
  end

  def create
    @producto = Product.new(producto_params)

    if @producto.save
      flash[:success] = "Almacenamiento correcto"
      redirect_to new_product_path
    else
      render :new
    end
  end

  def edit
    if current_user.id_rol != 1
      flash[:warning] = "No posee los roles para esta acción"
    else
      @producto = Product.select("nombre_producto, id_tipo, id").find(params[:id])
      @producto_show = Product.select("stock, precio").find(params[:id])
      @antiguo_stock = @producto_show.stock
      @antiguo_precio = @producto_show.precio
      @producto[:precio] =
      @producto[:stock] =
      @Tipos = Type.all
      @mensaje = "Añadir Stock"
    end
  end

  def show
    @Tipos = Type.all
    @producto = Product.find(params[:id])

    respond_to do |format|
      format.html
      format.pdf {render template: 'products/ficha', pdf: 'Ficha_producto '+@producto.nombre_producto, page_size: 'A5'}
    end
  end

  def edit_name
    @producto = Product.find(params[:id])
    @mensaje = "Editar Producto"
  end

  def update
    if current_user.id_rol != 1
      flash[:warning] = "No posee los roles para esta acción"
    else
      if params["product"]["nombre_producto"] == nil #Caso en que se esta actualizando el Stock
        producto = Product.find(params[:id])

        #Captura del ID
        id = params["id"]

        #Captura del stock y precios nuevos
        nuevo_stock = params["product"]["stock"]
        nuevo_stock = nuevo_stock.to_f
        nuevo_precio = params["product"]["precio"]
        nuevo_precio = nuevo_precio.to_f

        if nuevo_stock <= 0 || nuevo_stock >= 100 #Validacion de la cantidad de stock
          flash[:warning] = "Stock debe ser mayor a cero o menor a 100"
          redirect_to edit_product_path
        else
          if nuevo_precio <= 0 || nuevo_precio >= 50000 #Validacion del precio
            flash[:warning] = "Precio debe ser mayor a cero o menor a $50.000"
            redirect_to edit_product_path
          else
            antiguo_precio = producto[:precio]
            antiguo_precio = antiguo_precio.to_f
            antiguo_stock = producto[:stock]
            antiguo_stock = antiguo_stock.to_f

            #Ponderaciones de las cantidades
            pond_nueva = nuevo_stock/(nuevo_stock + antiguo_stock)
            pond_antigua = antiguo_stock/(nuevo_stock + antiguo_stock)

            #Precio nuevo ponderado
            precio_ponderado = (pond_nueva * nuevo_precio) + (pond_antigua * antiguo_precio)

            #Tipo de producto
            tipo = producto.id_tipo
            producto.update_attribute :id_tipo, tipo
            producto.update_attribute :stock, (nuevo_stock.to_i + antiguo_stock.to_i).to_s
            producto.update_attribute :precio, precio_ponderado.to_i
            redirect_to product_path
          end
        end

      else #Caso en que se esta cambiando el nombre o tipo
        producto = Product.find(params[:id])

        #Captura del ID
        id = params["id"]

        nombre_nuevo = params["product"]["nombre_producto"]
        nombre_nuevo = nombre_nuevo.upcase
        nuevo_tipo = params["product"]["id_tipo"]

        if nombre_nuevo.length == 0 #Caso en que no se ha ingresado un nombre
          flash[:warning] = "Ingrese un nombre"
          redirect_to edit_name_path
        else
          p = Product.where("nombre_producto = ?", nombre_nuevo)#verificacion de la existencia de un producto con ese nombre
          if p.length == 1 && nuevo_tipo.to_i == p[0][:id_tipo].to_i
            flash[:warning] = "No ha modificado nada del producto"
            redirect_to edit_name_path
          else
            nombre_antiguo = producto.nombre_producto
            producto.update_attribute :nombre_producto, nombre_nuevo
            producto.update_attribute :id_tipo, nuevo_tipo
            flash[:success] = "Producto actualizado"
            redirect_to edit_name_path
          end
        end
      end
    end
  end



  private
  def producto_params
    params.require(:product).permit(:nombre_producto, :id_tipo, :precio, :stock)
  end

  def filtro_params
    params.require(:filter).permit(:id_tipo)
  end


  class Productos
    attr_accessor :nombre
    attr_accessor :precio
    attr_accessor :id
    attr_accessor :stock

    def initialize(nombre, precio, id, stock)
      @nombre = nombre.titlecase
      @precio = precio
      @id = id
      @stock = stock
    end
  end

  class Tipos
    attr_accessor :descrip_tipo
    attr_accessor :id

    def initialize(tipo, id)
      @descrip_tipo = tipo.titlecase
      @id = id
    end
  end
end
