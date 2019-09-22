require 'date'
DIRECTORIES_TO_INCLUDE = ['builders', 'models', 'services']

DIRECTORIES_TO_INCLUDE.each do |dir|
  Dir["./#{dir}/**/*.rb"].each do |file|
    require_relative "#{file}"
  end
end

require_relative './stock_exchange'
