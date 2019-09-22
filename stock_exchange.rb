class StockExchange
  attr_accessor :order_inputs, :trades

  def initialize
    @order_inputs = []
    @trades = []
  end

  def add_order(order_input)
    order_inputs << order_input

    order = add_order_to_book(order_input)
    allocate_order(order)
  end

  def show_trades
    @trades.each do |t|
      puts "#{t.buy_order_id} #{t.sell_price} #{t.quantity} #{t.sell_order_id}"
    end
  end

  def show_orders
    order_inputs.each do |o|
      puts o
    end
  end

  private

  def order_book
    @book ||= OrderBook.new
  end

  def allocate_order(order)
    matcher = OrderMatcher.new(order, order_book)
    matcher.perform
    @trades = @trades + matcher.trades
  end

  def add_order_to_book(order_input)
    order = OrderBuilder.new(order_input).build
    order_book.add_order(order)
    order
  end
end