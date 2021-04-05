require_relative "../models/market/MarketList.rb"
require_relative "../views/console/display/market.rb"

module ConsoleController
    def self.current_prices
        Views::Console::Display::Market.show do
            current_prices = MarketList.new
            current_prices.marketlist
        end
    end
end

ConsoleController.current_prices