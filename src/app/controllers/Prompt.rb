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
                quick ? input = quick_route : input = user_input(user_status, first_console)
                case input
                    when "brief"
                        briefing
                    when "market"
                        show_market
                    when "portfolio"
                        show_portfolio(user)
                    when "trading"
                        trading_platform(user, quick)
                    when "log"
                        show_log(user)
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

        def quick_route
            case ARGV[0]
            when /^-m(arket)*/
                return "market"
            when /^-p(ortfolio)*/
                return "portfolio"
            when /^-b(uy)*/
                return "trading"
            when /^-s(ell)*/
                return "trading"
            when /^-l(og)*/
                return "log"
            when /^-h(elp)*/
                return "help"
            else
                puts "Your command line argument was not recognised.\nPlease refer to the help guide for more information."
                sleep_keypress(2,STDIN)
                puts "Now taking you to the console..."
                sleep_keypress(3,STDIN)
                system 'clear'
            end
        end
    end
end