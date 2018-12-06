class Type < ApplicationRecord
  has_many :products

  validates :descrip_tipo, uniqueness: {message: "Ya existe ese tipo"}
end
