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
            Display::Market.show do
                ::Market::Catalogue.price_list
            end
        end
        
        def show_portfolio(user)
            Display::Portfolio.show(user) do
                ::Market::Catalogue.price_list
            end
        end

        def trading(user)
            user.execute_trade(Trading.get_trade(user))
            user.save
        end
    end
end