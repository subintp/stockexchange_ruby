class OrderMatcher
  attr_accessor :order, :order_book, :trades

  def initialize(order, order_book)
    @order = order
    @order_book = order_book
    @trades = []
  end

  def perform
    order_book.match_order(order).each do |matching_order|

      if order.sell?
        sell_order, buy_order  = order, matching_order
      else
        sell_order, buy_order = matching_order, order
      end

      remaining_quantity = order.quantity - matching_order.quantity

      if perfect_allocation?(remaining_quantity)
        create_trade(sell_order, buy_order, buy_order.quantity)
        mark_order_as_allocated(sell_order)
        mark_order_as_allocated(buy_order)
        
      elsif partial_order_allocation?(remaining_quantity) 
        create_trade(sell_order, buy_order, matching_order.quantity)
        update_order_allocation(order, remaining_quantity)
        mark_order_as_allocated(matching_order)

      else
        create_trade(sell_order, buy_order, order.quantity)
        update_order_allocation(matching_order, remaining_quantity.abs)
        mark_order_as_allocated(order)
      end

      break if order.allocated?
    end
  end

  private

  def perfect_allocation?(remaining_quantity)
    remaining_quantity == 0
  end

  def partial_order_allocation?(remaining_quantity)
    remaining_quantity > 0
  end

  def create_trade(sell_order, buy_order, quantity)
    @trades << TradeBuilder.new(
      sell_order: sell_order,
      quantity: quantity,
      buy_order: buy_order
    ).build
  end

  def mark_order_as_allocated(order)
    order.status = 'allocated'
  end

  def update_order_allocation(order, quantity)
    order.quantity = quantity
  end
end