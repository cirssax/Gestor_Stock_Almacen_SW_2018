class Product < ApplicationRecord
  has_one :Type

  VALID_NAME_REGEX = /(?=^.{2,50}$)[a-zA-ZñÑáéíóúÁÉÍÓÚ]+(\s[a-zA-ZñÑáéíóúÁÉÍÓÚ]+)?/

  validates :nombre_producto, uniqueness: {message: "Ya existe ese producto"}

  validates :id_tipo, presence: {message: "Debes asignarle una categoria o tipo"}
  validates :precio, presence: {message: "Debes asignarle un precio"}
  validates :stock, presence: {message: "Debes asignarle un stock"}
  validates :nombre_producto, length: { in: 2..50 , :message => "Largo inadecuado de producto"}, format: { with: VALID_NAME_REGEX , :message => "Formato invalido"}, presence: { message: "Debe llenar el campo" }

end
