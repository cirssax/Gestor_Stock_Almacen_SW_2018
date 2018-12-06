class State < ApplicationRecord
  validates :descrip_estado, uniqueness: {message: "Ya existe ese estado"}
end
