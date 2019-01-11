class Product < ApplicationRecord
  has_one :type

  before_save :normalizacion

  VALID_NAME_REGEX = /(?=^.{2,50}$)[a-zA-ZñÑáéíóúÁÉÍÓÚ]+(\s[a-zA-ZñÑáéíóúÁÉÍÓÚ]+)?/

  #Validaciones del tipo
  validates :id_tipo, presence: {messege: "Debe seleccionar un tipo de Producto"}
  #Validaciones del stock
  validates :precio, presence: {messege: "Debe asignar un precio"}, numericality:{only_integer: true, greater_than_or_equal_to: 1}, length: {in: 1..10, :message =>"Largo inadecuado"}
  #Validaciones del precio
  validates :stock, presence: {message: "Debe asignar un stock"}, numericality: {only_integer: true, greater_than_or_equal_to: 1}, length: {in: 1..10, :message =>"Largo inadecuado"}
  #Validaciones del nombre
  validates :nombre_producto, length: { in: 2..50 , :message => "Largo inadecuado de producto"},  format: { with: VALID_NAME_REGEX , :message => "Formato invalido"},  presence: { message: "Debe llenar el campo" }
  validate :Repeticion

  def Repeticion
    if nombre_producto != nil
      @productos = Product.select("nombre_producto")
      @productos.each do |producto|
        if nombre_producto.upcase == producto.nombre_producto
          errors.add(:nombre_producto, "Ese producto ya existe")
        end
      end
    end
  end

  private
  def normalizacion
    self.nombre_producto = nombre_producto.upcase
  end


end
