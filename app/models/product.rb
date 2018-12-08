class Product < ApplicationRecord
  has_one :Type

  VALID_NAME_REGEX = /(?=^.{2,50}$)[a-zA-ZñÑáéíóúÁÉÍÓÚ]+(\s[a-zA-ZñÑáéíóúÁÉÍÓÚ]+)?/

  #Validaciones del tipo
  validates :id_tipo, numericality: true
  validates :id_tipo, numericality: {only_integer: true}
  #Validaciones del stock
  validates :precio, presence: {messege: "Debe asignar un precio"}
  validates :precio, numericality: true
  validates :precio, numericality:{only_integer: true}
  validates :precio, length: {in: 1..10, :message =>"Largo inadecuado"}
  #Validaciones del precio
  validates :stock, presence: {message: "Debe asignar un stock"}
  validates :stock, numericality: true
  validates :stock, numericality: {only_integer: true}
  validates :stock, length: {in: 1..10, :message =>"Largo inadecuado"}
  #Validaciones del nombre
  validates :nombre_producto, uniqueness: {message: "Ya existe ese producto"}
  validates :nombre_producto, length: { in: 2..50 , :message => "Largo inadecuado de producto"}
  validates :nombre_producto,  format: { with: VALID_NAME_REGEX , :message => "Formato invalido"}
  validates :nombre_producto,  presence: { message: "Debe llenar el campo" }

end
