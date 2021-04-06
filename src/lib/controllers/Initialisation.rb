require_relative "../models/portfolio/PortfolioRecord.rb"
require_relative "../views/landing/title.rb"
include Views::Landing

module Controllers
    module Initialisation
        def initialise
            system 'clear'
            portfolio = Portfolio::Record.new
            portfolio.user.nil? ? (new_portfolio(portfolio); status = :new) : status = :old
            system 'clear'
            Title.show(portfolio.user, status)
        end

        def new_portfolio(portfolio) #cash initialisation should be in model
            portfolio.user = get_user
            portfolio.history << portfolio.user
            portfolio.history << [:CASH, 1_000_000_000, 1]
            portfolio.save            
        end
        
        def get_user # should be in new user view
            puts "Psst, it doesn't look like you've been here before.\nWould you kindly tell us your name?"
            begin
            user = gets.strip.downcase.capitalize
            end until user != ""
            user
        end
    end
end