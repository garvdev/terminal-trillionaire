require_relative "./SecurityItem.rb"

class MarketList
    attr_reader :marketlist

    TICKERS = ["PEAR","EDSN","CHLL","YMMY","EXCL","WATR","LAMP","TEEM","SOLA","CODE"]

    def initialize
        @marketlist = {}
        TICKERS.each do |ticker|
            t = SecurityItem.new(ticker)       
            @marketlist[t.ticker] = t.prices
        end
    end
end