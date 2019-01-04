class Sale < ApplicationRecord
  has_one :user

  validates :fecha_venta, presence: {messege: "Debe ingresar la fecha de venta"}
  validates :id_producto, presence: {message: "Debes seleccionar un producto"}
  validates :id_trabajador, presence: {message: "Debes seleccionar un vendedor"}
  validates :cantidad, presence: {message: "Debe asignar un stock"}, numericality: {only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 50}, length: {in: 1..10, :message =>"Largo inadecuado"}
end
