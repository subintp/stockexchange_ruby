require_relative '../spec_helper.rb'

describe TradeBuilder do

  before :all do 
    @sell_order = Order.new(type: 'sell', id: 's_id', price: 200, quantity: 100, timestamp: "09:45")
    @buy_order = Order.new(type: 'buy', id: 'b_id', price: 200, quantity: 100, timestamp: "09:46")
    @trade_attributes = {sell_order: @sell_order, buy_order: @buy_order, quantity: 100}
    @builder = TradeBuilder.new(@trade_attributes)
  end

  describe 'Initialization' do
    it 'should create instance' do
      expect(@builder).to be_a TradeBuilder
    end

    it 'should set attributes' do
      expect(@builder.attributes).to eql @trade_attributes
    end
  end

  describe '#build' do
    before :all do
      @trade = @builder.build 
    end

    it 'should build Order' do
      expect(@trade).not_to be_nil 
    end 

    context "Attributes" do 
      it 'should set sell_order_id' do
        expect(@trade.sell_order_id).to eql @sell_order.id
      end

      it 'should set price' do 
        expect(@trade.sell_price).to eql @sell_order.price 
      end

      it 'should set quantity' do 
        expect(@trade.quantity).to eql @trade_attributes[:quantity]
      end

      it 'should set buy order' do
        expect(@trade.buy_order_id).to eql @buy_order.id
      end
    end
  end
end