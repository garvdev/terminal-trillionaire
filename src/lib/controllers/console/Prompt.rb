require_relative "./Controller.rb"
require_relative "../../views/console/Console.rb"

include Views::Console
include Controllers::Console::Controller

module Controllers
    module Console
        module Prompt
            def prompt(user_status)
                first_console = true
                while true
                    system 'clear'
                    case user_input(user_status, first_console)
                        when "brief"
                            tutorial
                            user_status = :old
                        when "market"
                            show_market
                        when "portfolio"
                            p "placeholder"
                        when "trading"
                            p "placeholder"
                        when "calculator"
                            p "placeholder"
                        when "help"
                            p "placeholder"
                        when "exit"
                            system 'clear'
                            exit
                    end
                    first_console = false
                end
            end
        end
    end
end