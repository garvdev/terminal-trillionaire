require_relative "./Controller.rb"
require_relative "../views/Console.rb"

include Views::Console
include Controllers::Controller

module Controllers
    module Prompt
        def prompt(user_status)
            first_console = true
            while true
                system 'clear'
                case user_input(user_status, first_console)
                    when "brief"
                        tutorial
                    when "market"
                        show_market
                    when "portfolio"
                        
                    when "trading"
                        
                    when "calculator"
                        
                    when "help"
                        
                    when "exit"
                        system 'clear'
                        exit
                end
                first_console = false
                user_status = :old
            end
        end
    end
end