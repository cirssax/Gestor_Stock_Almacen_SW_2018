class SalesController < ApplicationController
  before_action :authenticate_user!

  def index
    @Ventas = Sale.select("sales.fecha_venta as fecha, sales.id_trabajador as trabajador").group("sales.fecha_venta, sales.id_trabajador")
  end
end
