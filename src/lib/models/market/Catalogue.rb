require_relative "./SecurityItem.rb"


module Market
    module Catalogue
        TICKERS = [:PEAR,:EDSN,:CHLL,:YMMY,:EXCL,:WATR,:LAMP,:TEEM,:SOLA,:CODE,
        :TEXT,:FODR,:MUSC,:BIKE,:SCNT,:MAKE,:DSGN,:ANML,:LOOP,:SLAM]

        def self.price_list
            price_list = {}
            TICKERS.each do |ticker|
                t = SecurityItem.new(ticker.to_s)       
                price_list[t.ticker] = t.prices
            end
            price_list
        end
    end
end