class User < ApplicationRecord
  extend Devise::Models
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one :role
  has_one :state

  VALID_NAME_REGEX = /(?=^.{2,50}$)[a-zA-ZñÑáéíóúÁÉÍÓÚ]+(\s[a-zA-ZñÑáéíóúÁÉÍÓÚ]+)?/
  #Validaciones para el rut
  validates :rut, numericality: {message: "Por favor ingrese solamente numeros en este campo"} #, on: :create
  validates :rut, uniqueness: {message: "Ya existe dicho rut"}
  validates :dv, presence: {message: "Ingrese digito verificador"}
  #Valicaciones para el domicilio
  validates :domicilio, length: {in: 2..100, :message => "Largo inadecuado de domicilio"}
  #Validacines para el fono
  validates :fono, numericality: {message: "Por favor ingrese solamente numeros en este campo"} #, on: :create
  validates :fono, numericality: {only_integer: true}
  #Validaciones para el nombre
  validates :nombre_trabajador, length: { in: 2..50 , :message => "Largo inadecuado de nombre"}
  validates :nombre_trabajador,  format: { with: VALID_NAME_REGEX , :message => "Formato invalido"}
  validates :nombre_trabajador, presence: { message: "Debe llenar el campo" }
  #Validaciones para el apellido
  validates :apellidos_trabajador, length: { in: 2..50 , :message => "Largo inadecuado de nombre"}
  validates :apellidos_trabajador, format: { with: VALID_NAME_REGEX , :message => "Formato invalido"}
  validates :apellidos_trabajador, presence: { message: "Debe llenar el campo" }
  #Validaciones para el estado
  validates :id_estado, presence: {message: "Debe seleccionar un estado"}
  #Validaciones para el rol
  validates :id_rol, presence: {message: "Debe seleccionar un rol"}
end
