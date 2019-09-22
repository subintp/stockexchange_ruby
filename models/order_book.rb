class OrderBook
  attr_accessor :orders

  def initialize
    @orders = []
  end

  def add_order(order)
    orders << order
  end

  def delete_order(order)
    orders.delete(order)
  end

  def match_order(order)
    if order.sell?
      orders.select do |o| 
        o.type == 'buy' && 
        o.price >= order.price &&
        o.stock_name == order.stock_name &&
        o.status == 'active'
      end.sort_by { |o| o.timestamp }
    else
      orders.select do |o| 
        o.type == 'sell' && 
        o.price <= order.price && 
        o.stock_name == order.stock_name &&
        o.status == 'active' 
      end.sort_by { |o| o.timestamp }
    end
  end
end