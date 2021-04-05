require "./SecurityItem"

class MarketList
    tickers = ["PEAR","EDSN","CHLL","YMMY","EXCL","WATR","LAMP","TEEM","SOLO","CODE"]
    marketlist = {}
    
    tickers.each do |ticker|
        t = SecurityItem.new(ticker)       
        marketlist[t.ticker] = t.prices
    end

    p marketlist
end