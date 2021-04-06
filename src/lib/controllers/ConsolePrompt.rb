require_relative "./ConsoleController.rb"
require_relative "../views/console/Console.rb"

include Views::Console
include Controllers::Console

module Controllers
    module ConsolePrompt
        def prompt
            while true
                system 'clear'
                case user_input
                    when "market"
                        show_market
                    when "portfolio"
                        p "placeholder"
                    when "trading"
                        p "placeholder"
                    when "calculator"
                        p "placeholder"
                    when "exit"
                        system 'clear'
                        exit
                end
            end
        end
    end
end