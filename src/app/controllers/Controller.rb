require_relative "../models/market/Catalogue.rb"
require_relative "../views/display/Market.rb"
require_relative "../views/display/Briefing.rb"
require_relative "../views/display/Portfolio.rb"
require_relative "../views/Trading.rb"

module Controllers
    module Controller
        include Views
        
        def briefing
            Display::Briefing.show
        end
        
        def show_market
            Display::Market.show { ::Market::Catalogue.price_list }
            
        end
        
        def show_portfolio(user)
            Display::Portfolio.show(user) { ::Market::Catalogue.price_list }
        end

        def trading_platform(user)
            Trading.get_trade(user) do |trade|
                user.execute_trade(trade)
            end
        end
    end
end