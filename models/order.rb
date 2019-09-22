class Order
  attr_accessor :id, :stock_name, :type, 
                :price, :quantity, :timestamp, 
                :status

  TYPES = %w(sell buy)
  STATUS = %w(active allocated)

  def initialize(args = {})
    @id = args[:id]
    @stock_name = args[:stock_name]
    @type =  args[:type]
    @quantity = args[:quantity].to_i
    @timestamp = DateTime.strptime(args[:timestamp], '%H:%M')
    @price = args[:price]
    @status = 'active'
  end


  TYPES.each do |t|
    define_method "#{t}?".to_sym do
      type == t
    end
  end

  STATUS.each do |s|
    define_method "#{s}?".to_sym do
      status == s
    end
  end
end