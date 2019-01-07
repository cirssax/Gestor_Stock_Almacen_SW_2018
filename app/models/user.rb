class User < ApplicationRecord
  extend Devise::Models
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  #validates_with MyValidator
  has_one :role
  has_one :state
  has_many :sales
  accepts_nested_attributes_for :sales

  before_save :normalizacion


  VALID_NAME_REGEX = /(?=^.{2,50}$)[a-zA-ZñÑáéíóúÁÉÍÓÚ]+(\s[a-zA-ZñÑáéíóúÁÉÍÓÚ]+)?/
  VALID_CORREO_REGEX = /\A\S+@.+\.\S+\z/
  #Validaciones para el rut
  validates :rut, rut:{message: "Rut invalido"}, uniqueness: {message:"Rut ya existente"}, presence: {message: "Ingrese rut"}
  #Valicaciones para el domicilio
  validates :domicilio, length: {in: 2..100, :message => "Largo inadecuado de domicilio"}
  #Validacines para el fono,uniqueness: {message:"Rut ya existente"}
  validates :fono, numericality: {message: "Por favor ingrese solamente numeros en este campo", only_integer: true} #, on: :create
  #Validaciones para el nombre
  validates :nombre_trabajador, length: { in: 2..50 , :message => "Largo inadecuado de nombre"},  format: { with: VALID_NAME_REGEX , :message => "Formato invalido"}
  #Validaciones para el apellido
  validates :apellidos_trabajador, length: { in: 2..50 , :message => "Largo inadecuado de nombre"}, format: { with: VALID_NAME_REGEX , :message => "Formato invalido"}, presence: { message: "Debe llenar el campo" }
  #Validaciones para el estado
  validates :id_estado, presence: {message: "Debe seleccionar un estado"}
  #Validaciones para el rol
  validates :id_rol, presence: {message: "Debe seleccionar un rol"}
  #Validacion del correo
  validates :email, format:  {with: VALID_CORREO_REGEX, :message => "Forma invalido de correo"}, uniqueness: {message: "Ya existe un usuario asignado a ese correo"}


  private
  def normalizacion
    self.nombre_trabajador = nombre_trabajador.upcase
    self.domicilio = domicilio.upcase
    self.apellidos_trabajador = apellidos_trabajador.upcase
    self.email = email.downcase
  end



end

