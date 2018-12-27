class Sale < ApplicationRecord
  has_one :product
  has_one :user

  validates :fecha_venta, presence: {messege: "Debe ingresar la fecha de venta"}
  validates :id_producto, presence: {message: "Debes seleccionar un producto"}
  validates :id_trabajador, presence: {message: "Debes seleccionar un vendedor"}
  validates :cantidad, presence: {message: "Debe asignar un stock"}
  validates :cantidad, numericality: true
  validates :cantidad, numericality: {only_integer: true}
  validates :cantidad, length: {in: 1..10, :message =>"Largo inadecuado"}
end
