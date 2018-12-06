class Role < ApplicationRecord
  has_many :workers

  validates :descrip_rol, uniqueness: {message: "Ya existe ese rol"}
end
