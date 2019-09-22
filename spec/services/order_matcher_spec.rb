require_relative '../spec_helper.rb'

describe OrderMatcher do

  it 'should initialize the order book' do
    order = Order.new(timestamp: "09:45")
    book = OrderBook.new

    matcher = OrderMatcher.new(order, book)
    expect(matcher).to be_a OrderMatcher
  end

  describe 'No allocation' do

    before :each do
      @book = OrderBook.new
      
      @sell_order = OrderBuilder.new('#1 09:45 BAC sell 230.12 100').build
      @buy_order = OrderBuilder.new('#1 09:45 BAC buy 200 100').build

      @book.add_order(@sell_order)
      @book.add_order(@buy_order)
    end

    context 'Buy' do
      it 'should not match with sell order' do
        matcher = OrderMatcher.new(@buy_order, @book)
        matcher.perform

        expect(matcher.trades.empty?).to eql true
      end
    end

    context 'Sell' do
      it 'should not match with buy order' do
        matcher = OrderMatcher.new(@sell_order, @book)
        matcher.perform

        expect(matcher.trades.empty?).to eql true
      end
    end
  end

  describe "Complete allocation" do 

    before :each do
      @book = OrderBook.new

      @sell_order = OrderBuilder.new('#1 09:45 BAC sell 230.12 100').build
      @buy_order = OrderBuilder.new('#1 09:45 BAC buy 240.1 100').build

      @book.add_order(@sell_order)
      @book.add_order(@buy_order)
    end

    context 'Buy' do
      it 'should match with sell order' do
        matcher = OrderMatcher.new(@buy_order, @book)
        matcher.perform

        expect(@sell_order.status).to eql 'allocated'
        expect(@buy_order.status).to eql 'allocated'
      end
    end

    context 'Sell' do
      it 'should match with buy order' do
        matcher = OrderMatcher.new(@sell_order, @book)
        matcher.perform

        expect(@sell_order.status).to eql 'allocated'
        expect(@buy_order.status).to eql 'allocated'
      end
    end
  end

  describe "Partial allocation" do

    before :each do
      @book = OrderBook.new

      @sell_order_1 = OrderBuilder.new('#1 09:45 ABC sell 240.12 100').build
      @sell_order_2 = OrderBuilder.new('#2 09:46 ABC sell 237.45  90').build
      @sell_order_3 = OrderBuilder.new('#6 09:50 ABC sell 236.00  50').build

      @buy_order_1 = OrderBuilder.new('#5 09:49 ABC buy  237.80  40').build
      @buy_order_2 = OrderBuilder.new('#4 09:48 ABC buy  237.80  10').build
      @buy_order_3 = OrderBuilder.new('#3 09:47 ABC buy  238.10 110 ').build

      @book.add_order(@sell_order_1)
      @book.add_order(@sell_order_2)
      @book.add_order(@sell_order_3)

      @book.add_order(@buy_order_1)
      @book.add_order(@buy_order_2)
      @book.add_order(@buy_order_3)
    end


    context 'Sell' do
      it 'should allocate orders partially' do
        matcher = OrderMatcher.new(@sell_order_2, @book)
        matcher.perform

        expect(@sell_order_2.status).to eql 'allocated'
        expect(matcher.trades.count).to eql 1
        expect(matcher.trades.first.buy_order_id).to eql '#3'
        expect(@buy_order_3.quantity).to eql 20
      end
    end

    context 'Buy' do
      it 'should allocate orders partially' do
        matcher = OrderMatcher.new(@buy_order_3, @book)
        matcher.perform

        expect(@buy_order_3.status).to eql 'allocated'
        expect(matcher.trades.count).to eql 2
        expect(@sell_order_2.status).to eql 'allocated'
        expect(@sell_order_3.quantity).to eql 30
      end
    end
  end
end