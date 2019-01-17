class SaleSearch
  attr_reader :date_from, :date_to, :id_usuario, :rol

  def initialize(params, id)
    params ||= {}
    @date_from = parsed_date(params[:date_from], 30.days.ago.to_date.to_s)
    @date_to = parsed_date(params[:date_to], Date.today.to_s)
    @id_usuario = params[:id_usuario]
    @rol = id
  end

  def scope
    if @date_to == @date_from
      if @id_usuario == "" || @id_usuario == nil
        if @rol == -1 #Caso en que es administrador
          Sale.where('CAST(fecha_venta AS DATE) = ?', @date_from)
        else #Caso en que es usuario trabajador
          Sale.where('CAST(fecha_venta AS DATE) = ? AND id_usuario = ?', @date_from, @rol)
        end
      else
        if @rol == -1
          Sale.where('CAST(fecha_venta AS DATE) = ? AND id_usuario = ?', @date_from, @id_usuario)
        else
          Sale.where('CAST(fecha_venta AS DATE) = ? AND id_usuario = ?', @date_from, @rol)
        end
      end
    elsif @date_to > @date_from
      if @id_usuario == "" || @id_usuario == nil
        if @rol == -1
          Sale.where('CAST(fecha_venta AS DATE) >= ? AND CAST(fecha_venta AS DATE) <= ?', @date_from, @date_to)
        else
          Sale.where('CAST(fecha_venta AS DATE) >= ? AND CAST(fecha_venta AS DATE) <= ? AND id_usuario = ?', @date_from, @date_to, @rol)
        end
      else
        if @rol == -1
          Sale.where('CAST(fecha_venta AS DATE) >= ? AND CAST(fecha_venta AS DATE) <= ? AND id_usuario = ?', @date_from, @date_to, @id_usuario)
        else
          Sale.where('CAST(fecha_venta AS DATE) >= ? AND CAST(fecha_venta AS DATE) <= ? AND id_usuario = ?', @date_from, @date_to, @rol)
        end

      end

    end
  end

  private

  def parsed_date(date_string, default)
    Date.parse(date_string)
  rescue ArgumentError, TypeError
    default
  end

end