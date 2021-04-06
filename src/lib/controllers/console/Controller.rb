require_relative "../../models/market/MarketList.rb"
require_relative "../../views/console/display/market.rb"
require_relative "../../views/console/display/tutorial.rb"

module Controllers
    module Console
        module Controller
            def tutorial
                Views::Console::Display::Tutorial.show
            end
            def show_market
                Views::Console::Display::Market.show do
                    current_prices = MarketList.new
                    current_prices.marketlist
                end
            end
        end
    end
end