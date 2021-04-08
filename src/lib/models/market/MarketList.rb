require_relative "./SecurityItem.rb"

class MarketList
    attr_reader :marketlist

    TICKERS = [:PEAR,:EDSN,:CHLL,:YMMY,:EXCL,:WATR,:LAMP,:TEEM,:SOLA,:CODE,
               :TEXT,:FODR,:MUSC,:BIKE,:SCNT,:MAKE,:DSGN,:ANML,:LOOP,:SLAM]

    def initialize
        @marketlist = {}
        TICKERS.each do |ticker|
            t = SecurityItem.new(ticker.to_s)       
            @marketlist[t.ticker] = t.prices
        end
    end
end