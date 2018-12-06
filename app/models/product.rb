class Product < ApplicationRecord
  has_many :types

  validates :nombre_producto, uniqueness: {message: "Ya existe ese producto"}

  validates :id_tipo, presence: {message: "Debes asignarle una categoria o tipo"}
  validates :precio, presence: {message: "Debes asignarle un precio"}
  validates :stock, presence: {message: "Debes asignarle un stock"}
  validates :nombre_producto, presence: {message: "Debes asignarle un nombre"}

end
