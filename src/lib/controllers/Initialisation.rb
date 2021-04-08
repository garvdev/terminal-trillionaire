require_relative "../models/portfolio/PortfolioRecord.rb"
require_relative "../views/landing/Title.rb"
require_relative "../views/landing/GetUser.rb"
include Views::Landing

module Controllers
    module Initialisation
        def load
            system 'clear'
            portfolio = Portfolio::Record.new
            portfolio.user.nil? ? (portfolio.new_user(GetUser.name); user_status = :new) : user_status = :old
            [portfolio.user, user_status]
        end

        def initialise(quick=false)
            user = load
            title(user[0],user[1]) unless quick == true
            user[1]
        end
    end
end