class UsersController < ApplicationController
  before_action :allow_without_password, only: [:update]
  def index
    if current_user.id_rol != 1
      flash[:warning] = "No posee los roles para esta acción"
    else
      @users = User.all
      @rol = Role.all
    end
  end

  def new
    if current_user.id_rol != 1
      flash[:warning] = "No posee los roles para esta acción"
    else
      @user = User.new
    end

  end

  def edit
    if current_user.id_rol != 1
      flash[:warning] = "No posee los roles para esta acción"
    else
      @user = User.find(params[:id])
    end

  end

  def create
    #render plain: params[:user].inspect
    if current_user.id_rol != 1
      flash[:warning] = "No posee los roles para esta acción"
    else
      @user = User.new(user_params)
      @usuarios = User.select("nombre_trabajador, apellidos_trabajador")
      @usuarios.each do |usr|
        if usr.nombre_trabajador == @user.nombre_trabajador.upcase && usr.apellidos_trabajador == @user.apellidos_trabajador.upcase
          flash[:danger] ="Ya existe un trabajador con esos nombres y apellidos"
        end
      end
      if @user.save
        redirect_to new_user_path
      else
        render new_user_path
      end
    end

  end

  def update
    if current_user.id_rol != 1
      flash[:warning] = "No posee los roles para esta acción"
    else
      @user = User.find(params[:id])
      if @user.update(user_params)
        flash[:success] = "Usuario actualizado correctamente"
        redirect_to new_user_path
      else
        render :edit
      end
    end
  end

  def show
    @Lista = []
    @Ventas_mensuales = []
    #Datos del usuario seleccionado
    @user = User.find(params[:id])
    #Obtencion de la cantidad ventas realizadas por el usuario
    @ventas = Sale.select("id").where("id_usuario = ?", @user.id)
    cantidad_vendido = 0

    @ventas.each do |venta|
      @Producto_Cantidad = Cart.select("id_producto, cantidad").where("sale_id = ?",venta.id)
      #Calculo del costo asociado a cada producto vendido
      @Producto_Cantidad.each do |producto_cantidad|
        #Obtencion del costo individual del producto
        @costo = Product.select("precio").where("id = ?", producto_cantidad.id_producto)
        cantidad_vendido = cantidad_vendido + (producto_cantidad.cantidad.to_i * @costo[0].precio.to_i)
      end
    end
    nombre = @user.nombre_trabajador+ " " + @user.apellidos_trabajador
    elemento = Campo.new(nombre, @user.id_rol, @user.id_estado, @user.email, @user[:rut], @user.fono, @user.domicilio, @user.created_at, @user.updated_at, @ventas.length, cantidad_vendido)
    @Lista.push(elemento)

    #Obtencion de las ventas mensuales
    var = 1
    while var <= 12
      #Obtencion de la venta por mes
      if var == 1
        @sale = Sale.select("id").where("id_usuario = ? AND to_char(fecha_venta, 'MM') = ?", @user.id, '01')
      elsif var ==2
        @sale = Sale.select("id").where("id_usuario = ? AND to_char(fecha_venta, 'MM') = ?", @user.id, '02')
      elsif  var == 3
        @sale = Sale.select("id").where("id_usuario = ? AND to_char(fecha_venta, 'MM') = ?", @user.id, '03')
      elsif  var == 4
        @sale = Sale.select("id").where("id_usuario = ? AND to_char(fecha_venta, 'MM') = ?", @user.id, '04')
      elsif var == 5
        @sale = Sale.select("id").where("id_usuario = ? AND to_char(fecha_venta, 'MM') = ?", @user.id, '05')
      elsif var == 6
        @sale = Sale.select("id").where("id_usuario = ? AND to_char(fecha_venta, 'MM') = ?", @user.id, '06')
      elsif  var == 7
        @sale = Sale.select("id").where("id_usuario = ? AND to_char(fecha_venta, 'MM') = ?", @user.id, '07')
      elsif  var == 8
        @sale = Sale.select("id").where("id_usuario = ? AND to_char(fecha_venta, 'MM') = ?", @user.id, '08')
      elsif  var == 9
        @sale = Sale.select("id").where("id_usuario = ? AND to_char(fecha_venta, 'MM') = ?", @user.id, '09')
      elsif  var == 10
        @sale = Sale.select("id").where("id_usuario = ? AND to_char(fecha_venta, 'MM') = ?", @user.id, '10')
      elsif  var == 11
        @sale = Sale.select("id").where("id_usuario = ? AND to_char(fecha_venta, 'MM') = ?", @user.id, '11')
      else
        @sale = Sale.select("id").where("id_usuario = ? AND to_char(fecha_venta, 'MM') = ?", @user.id, '12')
      end

      if @sale.length == 0 #Caso en que no hay ventas
        nodo = VentasMensuales.new(GetMes(var), 0, 0)
      else
        cantidad_vendido = 0
        @ventas.each do |venta|
          @Producto_Cantidad = Cart.select("id_producto, cantidad").where("sale_id = ?",venta.id)
          #Calculo del costo asociado a cada producto vendido
          @Producto_Cantidad.each do |producto_cantidad|
            #Obtencion del costo individual del producto
            @costo = Product.select("precio").where("id = ?", producto_cantidad.id_producto)
            cantidad_vendido = cantidad_vendido + (producto_cantidad.cantidad.to_i * @costo[0].precio.to_i)
          end
        end
        nodo = VentasMensuales.new(GetMes(var), cantidad_vendido, @sale.length)
      end
      @Ventas_mensuales.push(nodo)


      var = var +1
    end

    respond_to do |format|
      format.html
      format.pdf {render template: 'users/ficha', pdf: 'Ficha_Usuario '+@user[:rut], page_size: 'Letter'}
    end

  end

  private
  def user_params
    params.require(:user).permit(:password_confirmation,:email,:password ,:nombre_trabajador, :apellidos_trabajador, :rut,:fono, :domicilio, :id_rol, :id_estado)
  end
  def allow_without_password
    if params[:user][:password].blank? && params[:user][:password_confirmation].blank?
      params[:user].delete(:password)
      params[:user].delete(:password_confirmation)
    end
  end

  class Campo
    attr_accessor :nombre
    attr_accessor :rol
    attr_accessor :estado
    attr_accessor :email
    attr_accessor :rut
    attr_accessor :fono
    attr_accessor :domicilio
    attr_accessor :fecha_creacion
    attr_accessor :fecha_modificacion
    attr_accessor :ventas
    attr_accessor :cantidad_vendido

    def initialize(nombre, rol, estado, email, rut, fono, domicilio, fecha_creacion, fecha_modificacion, ventas, cantidad_vendido)
      @nombre = nombre
      @rol = rol
      @estado = estado
      @email = email
      @rut = rut
      @fono = fono
      @domicilio = domicilio
      @fecha_creacion = fecha_creacion
      @fecha_modificacion = fecha_modificacion
      @ventas = ventas
      @cantidad_vendido = cantidad_vendido
    end
  end

  class VentasMensuales
    attr_accessor :mes
    attr_accessor :cantidad
    attr_accessor :monto

    def initialize(mes, monto, cantidad)
      @mes = mes
      @cantidad = cantidad
      @monto = monto
    end
  end

  def GetMes(i)
    if i==1
      return "Enero"
    elsif i==2
      return "Febrero"
    elsif i==3
      return "Marzo"
    elsif i==4
      return "Abril"
    elsif i==5
      return "Mayo"
    elsif i==6
      return "Junio"
    elsif i==7
      return "Julio"
    elsif i==8
      return "Agosto"
    elsif i==9
      return "Septiembre"
    elsif i==10
      return "Octubre"
    elsif i==11
      return "Noviembre"
    else
      return "Diciembre"
    end
  end
end
