class Sale < ApplicationRecord
  belongs_to :product
  belongs_to :user

  validates :id_producto, presence: {message: "Debes seleccionar un producto"}
  validates :id_trabajador, presence: {message: "Debes seleccionar un vendedor"}
end
