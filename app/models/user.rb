class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one :role
  VALID_NAME_REGEX = /(?=^.{2,50}$)[a-zA-ZñÑáéíóúÁÉÍÓÚ]+(\s[a-zA-ZñÑáéíóúÁÉÍÓÚ]+)?/
  validates :rut, numericality: {message: "Por favor ingrese solamente numeros en este campo"} #, on: :create
  validates :rut, uniqueness: {message: "Ya existe dicho rut"}
  validates :fono, numericality: {message: "Por favor ingrese solamente numeros en este campo"} #, on: :create

  validates :domicilio, length: {in: 2..100, :message => "Largo inadecuado de domicilio"}
  validates :nombre_trabajador, length: { in: 2..50 , :message => "Largo inadecuado de nombre"}, format: { with: VALID_NAME_REGEX , :message => "Formato invalido"}, presence: { message: "Debe llenar el campo" }
  validates :apellidos_trabajador, length: { in: 2..50 , :message => "Largo inadecuado de nombre"}, format: { with: VALID_NAME_REGEX , :message => "Formato invalido"}, presence: { message: "Debe llenar el campo" }
  #validates :id_estado, presence: {message: "Debe seleccionar un estado"}
  #validates :id_rol, presence: {message: "Debe seleccionar un rol"}
end
