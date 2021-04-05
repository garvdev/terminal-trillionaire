module Market
    module SecurityPricing
        def self.prices(ticker)
            #Reference
            #1 second = 1 second
            #1 minute = 60 seconds
            #1 hour = 3_600 seconds
            #1 day = 86_400 seconds
            #1 month = 2_678_400 seconds
            #1 year = 31_557_600 seconds

            time_stamps = {current: 0, day: -86_400, month: -2_678_400, year: -31_557_600, decade: -310_557_600}
            time_prices = {}
            time_stamps.each do |key,value|
                #Prepare variables
                time = Time.now.to_f + value
                scaled_time = time**3/1e27
                ticker_val = ticker.sum
                
                #Calculate unique ticker factor
                factor = (Math.sin(ticker_val**10) + 1) * ticker_val
                
                #Calculate unique ticker volatility
                volatility = Math.sin(time * factor)/100 + 1
                
                #Generate and return price
                price = scaled_time * factor * volatility
                
                time_prices[key] = price
            end
            time_prices
        end
    end
end