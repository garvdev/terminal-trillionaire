require_relative "../models/portfolio/PortfolioRecord.rb"
require_relative "../views/landing/title.rb"
include Views::Landing

module Controllers
    module Initialisation
        def initialise
            portfolio = Portfolio::Record.new
            portfolio.user.nil? ? (status = :new; portfolio.history[0] = portfolio.user = get_user) : status = :old
            Title.show(portfolio.user, status)
        end

        def get_user
            puts "It doesn't look like you've been here before.\nWould you kindly tell us your name?"
            begin
            user = gets.strip.downcase.capitalize
            end until user != ""
            user
        end
    end
end