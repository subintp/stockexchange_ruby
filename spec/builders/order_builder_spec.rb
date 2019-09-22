require_relative '../spec_helper.rb'

describe OrderBuilder do

  before :all do 
    @order_input = '#1 09:45 ABC sell 240.12 100'
    @builder = OrderBuilder.new(@order_input)
  end

  describe 'Initialization' do
    it 'should create instance' do
      expect(@builder).to be_a OrderBuilder
    end

    it 'should set attributes' do
      expect(@builder.attributes).to eql @order_input.split
    end
  end

  describe '#build' do
    before :all do
      @order = @builder.build 
    end

    it 'should build Order' do
      expect(@order).not_to be_nil 
    end 

    context "Attributes" do 
      it 'should set id' do
        expect(@order.id).to eql @order_input.split[0] 
      end

      it 'should set stock_name' do 
        expect(@order.stock_name).to eql @order_input.split[2] 
      end

      it 'should set type' do 
        expect(@order.type).to eql @order_input.split[3]
      end

      it 'should set price' do
        expect(@order.price).to eql @order_input.split[4].to_f
      end

       it 'should set quantity' do 
        expect(@order.quantity).to eql @order_input.split[5].to_i
       end

       it 'should set timestamp' do 
        expect(@order.timestamp).to eql DateTime.strptime(@order_input.split[1], '%H:%M')
       end

       it 'should set default status as active' do
        expect(@order.status).to eql 'active'
       end
    end
  end
end