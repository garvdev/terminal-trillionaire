require_relative "../models/portfolio/PortfolioRecord.rb"
require_relative "../views/landing/Title.rb"
require_relative "../views/landing/GetUser.rb"
include Views::Landing

module Controllers
    module Initialisation
        def initialise
            system 'clear'
            portfolio = Portfolio::Record.new
            portfolio.user.nil? ? (portfolio.new_user(GetUser.name); user_status = :new) : user_status = :old
            system 'clear'
            title(portfolio.user, user_status)
            user_status
        end
    end
end