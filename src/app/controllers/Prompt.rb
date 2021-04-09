require_relative "./Controller.rb"
require_relative "../views/Console.rb"

include Views::Console
include Controllers::Controller

module Controllers
    module Prompt
        def prompt(combined_user, quick=false)
            user = combined_user[0]
            user_status = combined_user[1]
            first_console = true
            while true
                case user_input(user_status, first_console, quick)
                    when "brief"
                        briefing
                    when "market"
                        show_market
                    when "portfolio"
                        show_portfolio(user)
                    when "trading"
                        trading
                    when "calculator"
                        p "calculator"
                    when "help"
                        p "help"
                    when "exit"
                        system 'clear'
                        exit
                    else
                end
                first_console = false
                user_status = :old
                quick = false
            end
        end
    end
end