class SaleSearch
  attr_reader :date_from, :date_to, :id, :rol

  def initialize(params)
    params ||= {}
    @date_from = parsed_date(params[:date_from], 7.days.ago.to_date.to_s)
    @date_to = parsed_date(params[:date_to], Date.today.to_s)
  end

  def scope
    if @date_to == @date_from
        Sale.where('CAST(fecha_venta AS DATE) = ?', @date_from)
    elsif @date_to > @date_from
        Sale.where('CAST(fecha_venta AS DATE) >= ? AND CAST(fecha_venta AS DATE) <= ?', @date_from, @date_to)
    end
  end

  private

  def parsed_date(date_string, default)
    Date.parse(date_string)
  rescue ArgumentError, TypeError
    default
  end

end