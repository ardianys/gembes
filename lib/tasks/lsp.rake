require 'net/http'
require 'uri'
require 'json'

namespace 'lsp' do
  task price: :environment do
    p ENV['RAPIDAPI_KEY']
    puts "Retrieve the price of Indices\n"
    indices = STDIN.gets.chomp
    response = Lsp::LatestStockPrice.price indices
    p response
  end

  task prices: :environment do
    puts "Retrieve the price of Indices\n"
    indices = STDIN.gets.chomp
    response = Lsp::LatestStockPrice.prices indices
    p response
  end

  task all_prices: :environment do
    puts "Retrieve all price"
    response = Lsp::LatestStockPrice.price_all
    p response
  end
end
