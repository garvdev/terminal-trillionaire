require_relative "./security_item.rb"

module Market
    module Catalogue
        TICKERS = [:CASH,:PEAR,:EDSN,:CHLL,:GRVY,:EXCL,:WATR,:DSGN,:SCNT,:SOLA,:CODE,:MUSC]
        # Pie chart characters maxed at 12 -> tickers must be maxed at 12.

        def self.price_list
            price_list = {}
            TICKERS.each do |ticker|
                (price_list[:CASH] = {current: 1, day: 1, month: 1, year: 1, decade: 1}; next) if ticker == :CASH
                t = SecurityItem.new(ticker)       
                price_list[t.ticker.to_sym] = t.prices
            end
            price_list
        end
    end
end