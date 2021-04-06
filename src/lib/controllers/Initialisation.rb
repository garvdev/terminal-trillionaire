require_relative "../models/portfolio/PortfolioRecord.rb"
require_relative "../views/landing/Title.rb"
require_relative "../views/landing/GetUser.rb"
include Views::Landing

module Controllers
    module Initialisation
        def initialise
            system 'clear'
            portfolio = Portfolio::Record.new
            portfolio.user.nil? ? (portfolio.new_user(GetUser.name); status = :new) : status = :old
            system 'clear'
            Title.show(portfolio.user, status)
        end        
    end
end