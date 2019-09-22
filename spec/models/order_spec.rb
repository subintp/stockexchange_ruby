require_relative '../spec_helper.rb'

describe Order do

  it "should initialize the order" do
    order_attributes = {
      id: 'o_id',
      stock_name: 'BAC',
      type: 'sell',
      quantity: 200,
      timestamp: "9:45",
      price: '100',
      status: 'active'
    }


    order = Order.new(order_attributes)

    expect(order.id).to eql(order_attributes[:id])
    expect(order.stock_name).to eql(order_attributes[:stock_name])
    expect(order.type).to eql(order_attributes[:type])
    expect(order.quantity).to eql(order_attributes[:quantity])
    expect(order.timestamp).to eql(DateTime.strptime(order_attributes[:timestamp], '%H:%M')) 
    expect(order.price).to eql(order_attributes[:price])
    expect(order.status).to eql(order_attributes[:status])
  end
end