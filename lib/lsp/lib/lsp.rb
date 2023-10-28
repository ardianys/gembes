# frozen_string_literal: true

require_relative "lsp/version"
require 'httparty'

module Lsp
  class LatestStockPrice
    include HTTParty
    base_uri 'https://latest-stock-price.p.rapidapi.com'

    headers 'X-RapidAPI-Host' => 'latest-stock-price.p.rapidapi.com',
            'X-RapidAPI-Key' => ENV['RAPIDAPI_KEY']

    def self.price(symbol)
      get('/price', query: { Indices: symbol })
    end

    def self.prices(symbols)
      get('/price', query: { Indices: symbols })
    end

    def self.price_all
      get('/any')
    end
  end
end
