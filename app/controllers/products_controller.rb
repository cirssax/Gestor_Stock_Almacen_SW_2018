class ProductsController < ApplicationController
  before_action :authenticate_user!

  def index
    @Productos = Product.all

    @Tipos = Type.all
    for producto in @Productos

    end
  end



end
