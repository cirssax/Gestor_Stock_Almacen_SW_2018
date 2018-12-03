class Sale < ApplicationRecord
  belongs_to :product
  belongs_to :worker
end
