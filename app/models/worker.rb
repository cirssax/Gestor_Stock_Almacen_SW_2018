class Worker < ApplicationRecord
  has_many :roles

  validates :rut, numericality: {message: "Por favor ingrese solamente numeros en este campo"} #, on: :create
  validates :rut, uniqueness: {message: "Ya existe dicho rut"}
  validates :fono, numericality: {message: "Por favor ingrese solamente numeros en este campo"} #, on: :create

  validates :nombre_trabajador, presence: {message: "Debe escribir un nombre"}
  validates :apellidos_trabajador, presence: {message: "Debes escribir un apellido"}
  validates :id_estado, presence: {message: "Debe seleccionar un estado"}
  validates :id_rol, presence: {message: "Debe seleccionar un rol"}

end
