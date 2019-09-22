class OrderBuilder
  attr_reader :attributes

  def initialize(order)
    @attributes = order.split
  end

  def build
    Order.new(
      id: @attributes[0],
      timestamp: @attributes[1],
      stock_name: @attributes[2],
      type: @attributes[3],
      price: @attributes[4].to_f,
      quantity: @attributes[5]
    ) 
  end
end