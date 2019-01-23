class Type < ApplicationRecord
  has_many :products

  before_save :normalizacion

  VALID_NAME_REGEX = /(?=^.{2,50}$)[a-zA-ZñÑáéíóúÁÉÍÓÚ]+(\s[a-zA-ZñÑáéíóúÁÉÍÓÚ]+)?/
  validates :descrip_tipo, length: { in: 2..50 , :message => "Largo inadecuado de nombre"}
  validates :descrip_tipo,  format: { with: VALID_NAME_REGEX , :message => "Formato invalido"}
  validates :descrip_tipo, presence: { message: "Debe llenar el campo" }
  validates :descrip_tipo, uniqueness: {message: "Ya existe ese tipo de producto"}
  validate :Repeticion

  def Repeticion
    if descrip_tipo != nil
      @tipos = Type.select("descrip_tipo")
      @tipos.each do |tipo|
        if descrip_tipo.upcase == tipo.descrip_tipo
          errors.add(:descrip_tipo, "Ese tipo de producto ya existe")
        end
      end
    end
  end

  private
  def normalizacion
    self.descrip_tipo = descrip_tipo.upcase
  end
end
