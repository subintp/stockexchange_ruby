require_relative './spec_helper.rb'

describe StockExchange do

  before :each do
    @exchange = StockExchange.new 
  end

  it 'should initialize stock exchange' do
    expect(@exchange).to be_a StockExchange
  end

  it 'should add order' do
    expect(@exchange).to receive(:allocate_order).once
 
    expect(@exchange.order_inputs.count).to eql 0
    expect(@exchange.send('order_book').orders.count).to eql 0

    @exchange.add_order('#1 09:45 ABC sell 240.12 100')

    expect(@exchange.order_inputs.count).to eql 1
    expect(@exchange.send('order_book').orders.count).to eql 1
  end
end