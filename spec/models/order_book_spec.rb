require_relative '../spec_helper.rb'

describe OrderBook do

  before :each do 
    @book = OrderBook.new
  end

  it "should initialize the order book" do
    expect(@book).to be_a OrderBook
  end

  it "should add order to order book" do 
    order = OrderBuilder.new('#1 09:45 ABC sell 240.12 100').build
    expect(@book.orders.count).to eql 0
    @book.add_order(order)
    expect(@book.orders.count).to eql 1
  end

  it "should delete order from order book" do 
    order_1 = OrderBuilder.new('#1 09:45 ABC sell 240.12 100').build
    order_2 = OrderBuilder.new('#1 09:45 ABC sell 240.12 200').build

    @book.add_order(order_1)
    @book.add_order(order_2)
    expect(@book.orders.count).to eql 2

    @book.delete_order(order_1)
    expect(@book.orders.count).to eql 1
  end

  describe "Order Matching" do

    before :each do
      @order_1 = OrderBuilder.new('#1 09:45 BAC sell 230.12 100').build
      @order_2 = OrderBuilder.new('#2 09:46 ABC sell 237.45  90').build
      @order_3 = OrderBuilder.new('#3 09:47 ABC buy  238.10 110 ').build

      @book.add_order(@order_1)
      @book.add_order(@order_2)
      @book.add_order(@order_3)
    end

    context "Match buy Order" do

      before :each do 
        @matching_orders = @book.match_order(@order_3)
      end

       it 'should contain only sell orders' do 
        expect(@matching_orders.map(&:type).uniq.first).to eql 'sell'
       end

       it 'should contain only with same stock name' do 
        expect(@matching_orders.map(&:type).include?('BAC')).to eql false
       end

       it 'should contain price less than or equal to order price' do
        prices = @matching_orders.map(&:price)
        expect(prices.any? { |price| price > @order_3.price}).to eql false
       end

       it 'should contain only active orders' do
        expect(@matching_orders.map(&:status).uniq.first).to eql 'active'
       end
    end 

    context "Sell Order" do

      before :each do 
        @matching_orders = @book.match_order(@order_2)
      end

       it 'should contain only sell orders' do 
        expect(@matching_orders.map(&:type).uniq.first).to eql 'buy'
       end

       it 'should contain only with same stock name' do 
        expect(@matching_orders.map(&:type).include?('BAC')).to eql false
       end

       it 'should contain price less than or equal to order price' do
        prices = @matching_orders.map(&:price)
        expect(prices.any? { |price| price < @order_3.price}).to eql false
       end
       
       it 'should contain only active orders' do
        expect(@matching_orders.map(&:status).uniq.first).to eql 'active'
       end
    end
  end
end