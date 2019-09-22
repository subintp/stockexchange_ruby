class TradeBuilder
  attr_reader :attributes

  def initialize(attributes)
    @attributes = attributes
  end

  def build
    Trade.new(
      sell_order_id: @attributes[:sell_order].id,
      sell_price: @attributes[:sell_order].price,
      quantity: @attributes[:quantity],
      buy_order_id: @attributes[:buy_order].id
    )
  end
end