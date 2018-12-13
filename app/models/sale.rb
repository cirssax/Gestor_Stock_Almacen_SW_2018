class Sale < ApplicationRecord
  belongs_to :product
  belongs_to :user

  validates :id_producto, presence: {message: "Debes seleccionar un producto"}
  validates :id_trabajador, presence: {message: "Debes seleccionar un vendedor"}
  validates :cantidad, presence: {message: "Debe asignar un stock"}
  validates :cantidad, numericality: true
  validates :cantidad, numericality: {only_integer: true}
  validates :cantidad, length: {in: 1..10, :message =>"Largo inadecuado"}
end
