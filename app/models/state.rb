class State < ApplicationRecord
  has_many :users
  validates :descrip_estado, uniqueness: {message: "Ya existe ese estado"}
end
