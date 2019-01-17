class ProductSearch
  attr_reader :tipo, :flag

  def initialize(params, flag)
    params ||= {}
    @tipo = parse(params[:tipo])
    @flag = parse(flag)
  end

  def scope
    if flag == -1 #Caso de un reseteo
      Product.all
    else #Caso de busqueda por tipo
      if @tipo == 0
        Product.all
      else
        Product.where("id_tipo = ?", @tipo)
      end

    end
  end

  private
  def parse(var)
    return var.to_i
  end

end