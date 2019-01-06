class Sale < ApplicationRecord
  has_one :user
  has_many :carts
  accepts_nested_attributes_for :carts

  validates :fecha_venta, presence: {messege: "Debe ingresar la fecha de venta"}
  validates :id_usuario, presence: {message: "Debes seleccionar un vendedor"}
end