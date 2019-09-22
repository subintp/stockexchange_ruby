class Trade
  attr_accessor :sell_order_id, :sell_price, 
                :quantity, :buy_order_id

  def initialize(args)
    @sell_order_id = args[:sell_order_id]
    @sell_price = args[:sell_price]
    @quantity = args[:quantity]
    @buy_order_id = args[:buy_order_id]
  end
end