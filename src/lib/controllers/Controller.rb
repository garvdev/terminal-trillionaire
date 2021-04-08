require_relative "../models/market/MarketList.rb"
require_relative "../views/display/Market.rb"
require_relative "../views/display/Briefing.rb"


module Controllers
    module Controller
        include Views::Display
        
        def tutorial
            Tutorial.show
        end
        def show_market
            Market.show do
                current_prices = MarketList.new
                current_prices.marketlist
            end
        end
    end
end