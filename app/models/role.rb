class Role < ApplicationRecord
  has_many :user

  validates :descrip_rol, uniqueness: {message: "Ya existe ese rol"}
end
