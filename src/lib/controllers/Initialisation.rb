require_relative "../models/portfolio/PortfolioRecord.rb"
require_relative "../views/landing/title.rb"
include Views::Landing

module Controllers
    module Initialisation
        def title
            Title.show
        end
        def load_portfolio
            portfolio = Portfolio::Record.new
            portfolio.portfolio.nil?
        end
        def create_portfolio
            
        end
        def welcome_back

        end
    end
end