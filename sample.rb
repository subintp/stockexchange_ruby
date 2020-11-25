require_relative './auto_loader.rb'

orders = [
"#1 09:45 TRUECALLER sell 240.12 100",
"#2 09:46 TRUECALLER sell 237.45  90",
"#3 09:47 TRUECALLER buy  238.10 110",
"#4 09:48 TRUECALLER buy  237.80  10",
"#5 09:49 TRUECALLER buy  237.80  40",
"#6 09:50 TRUECALLER sell 236.00  50"
]

# Initialize stock exchange
s = StockExchange.new


# Add orders to exchange
orders.each do |i|
  s.add_order(i)
end

# Show orders
puts "**** Orders *****"
puts "<order-id> <time> <stock> <buy/sell> <price> <qty>"
s.show_orders


# Show trades
puts "***** Trades *****"
puts "<buy-order-id> <sell-price> <qty> <sell-order-id>"
s.show_trades