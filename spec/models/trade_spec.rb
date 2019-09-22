require_relative '../spec_helper.rb'

describe Trade do

  it "should initialize the trade" do
    trade_attributes = {
      sell_order_id: 's_o_id',
      sell_price: 100,
      quantity: 100,
      buy_order_id: 'b_o_id'
    }


    trade = Trade.new(trade_attributes)

    expect(trade.sell_order_id).to eql(trade_attributes[:sell_order_id])
    expect(trade.sell_price).to eql(trade_attributes[:sell_price])
    expect(trade.quantity).to eql(trade_attributes[:quantity])
    expect(trade.buy_order_id).to eql(trade_attributes[:buy_order_id])
  end
end