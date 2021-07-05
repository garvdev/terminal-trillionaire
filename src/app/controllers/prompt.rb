require_relative './controller'
require_relative '../views/console'

include Views::Console
include Controllers::Controller

module Controllers
  module Prompt
    def prompt(combined_user, quick = false)
      user = combined_user[0]
      user_status = combined_user[1]
      first_console = true
      while true
        input = quick ? quick_route : user_input(user_status, first_console)
        case input
        when 'brief'
          briefing
        when 'market'
          show_market
        when 'portfolio'
          show_portfolio(user)
        when 'trading'
          trading_platform(user, quick)
        when 'log'
          show_log(user)
        when 'help'
          show_help
        when 'exit'
          system 'clear'
          exit
        end
        first_console = false
        user_status = :old
        quick = false
      end
    end

    def quick_route
      case ARGV[0]
      when /^-m(arket)*/
        'market'
      when /^-p(ortfolio)*/
        'portfolio'
      when /^-b(uy)*/
        'trading'
      when /^-s(ell)*/
        'trading'
      when /^-l(og)*/
        'log'
      when /^-h(elp)*/
        'help'
      else
        puts "Your command line argument was not recognised.\nPlease refer to the help guide for more information."
        sleep_keypress(2, STDIN)
        puts 'Now taking you to the console...'
        sleep_keypress(3, STDIN)
        system 'clear'
      end
    end
  end
end
