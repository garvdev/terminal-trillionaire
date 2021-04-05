require_relative "./SecurityPricing"

class SecurityItem
    attr_reader :ticker, :prices

    def initialize(ticker)
        @ticker = ticker
        @prices = Market::SecurityPricing.prices(ticker)
    end
end