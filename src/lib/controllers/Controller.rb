require_relative "../models/market/Catalogue.rb"
require_relative "../views/display/Market.rb"
require_relative "../views/display/Briefing.rb"
require_relative "../views/display/Portfolio.rb"

module Controllers
    module Controller
        include Views::Display
        
        def briefing
            Briefing.show
        end
        
        def show_market
            Market.show do
                ::Market::Catalogue.price_list
            end
        end
        
        def show_portfolio(user)
            Portfolio.show(user) do
                ::Market::Catalogue.price_list
            end
        end
    end
end