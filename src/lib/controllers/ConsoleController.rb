require_relative "../models/market/MarketList.rb"
require_relative "../views/console/display/market.rb"

module Controllers
    module Console
        def show_market
            Views::Console::Display::Market.show do
                current_prices = MarketList.new
                current_prices.marketlist
            end
        end
    end
end