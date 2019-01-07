class Cart < ApplicationRecord
  belongs_to :sale

  validates :id_producto, presence: {message: "Debes seleccionar un producto"}
  validates :cantidad, presence: {message: "Debe asignar un stock"}, numericality: {only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 50}
  validate :Cantidad_Stock #Validar que la cantidad a comprar sea menor al stock disponible





  def Cantidad_Stock
    if id_producto != nil
      producto = Product.select("stock, nombre_producto, id").where("id = ?", id_producto)
      if cantidad.to_i > producto[0].stock.to_i
        errors.add(:cantidad, "Cantidad supera el stock disponible. Stock disponible de: "+producto[0].nombre_producto.to_s+": "+producto[0].stock.to_s)
      end
    end
  end

end
