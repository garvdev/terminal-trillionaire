require 'tty-cursor'
require 'colorize'
require 'io/console'

module Views
  module Display
    module Help
      def self.show
        system 'clear'
        tty_cursor = TTY::Cursor
        tty_cursor.invisible do
          puts "Fjordan here again! It looks like you're after some help. I hope the following information can be of some assistance."
          sleep_keypress(3, STDIN)

          puts "\nLive Market Feed".bold
          puts "This is a real-time view of the various securities which form the NASDAK Composite Index.\nThe prices are updated every second and you'll find the current figures in the second column under 'Current'.\nThe following columns are historical information - listing prices exactly 1 day ago, 1 month ago, 1 year ago, and 1 decade ago."

          puts "\nPortfolio Analysis".bold
          puts "This view is separated into three sections - your portfolio holdings, a visualised breakdown of your portfolio by percentage, and a summary of your potential portfolio value if you were to liquidate all your holdings.\nEach view is generated based on real-time current market prices to give you up-to-date portfolio statistics every second.\nAny changes you make to your portfolio will be reflected here."

          puts "\nTrading Platform".bold
          puts "The trading platform allows you to execute trades by placing buy or sell orders as desired.\nYou will be shown a brief summary of your existing holdings as well as your cash balance so you can see what you're working with.\nThe prompts have been written to be informative in order to help guide you through the process.\nStandard trade logic and common sense applies - you can't buy what you can't afford and you can't sell what you don't have.\nOtherwise, anything goes - so Happy Trading!"

          puts "\nTrade Log".bold
          puts "Another straightforward feature of this application, the trade log simply lists all the trades performed under the current portfolio.\nEach trade is grouped into its double entries - your credit and debit transactions e.g. You buy 100 shares of 'BOOK' - your 'BOOK' holdings will be debited by 100 units and your cash balance will be credited by the corresponding purchase price.\nYou may need to scroll up using your mouse to view older trades if you have an extensive trade history."

          puts "\nAdvanced Users - Quick Routing via Command Line Arguments".bold
          puts "This one's for the pros - the application allows you to 'quick-route' your way through the title page and console by initiating the application with 'Command Line Arguments'.\nFor example, if you wish to skip straight ahead to your portfolio view, you would execute the application in the terminal and add '-p' as an argument.\nThe application will interpret your argument and take you straight through to your portfolio analysis, bypassing the title page and Fjordan's wonderful hospitality.\n\nA full list of arguments is as follows:\n-m(arket) => Market Feed\n-p(ortfolio) => Portfolio Analysis\n-b(uy) [____] => Attempt buy order for security [____]\n-s(ell) [____] => Attempt sell order for security [____]\n-l(og) => Trade History\n-h(elp) => This page!"

          sleep_keypress(3, STDIN)
          puts "\nPress any key to return to the console."
          STDIN.getch
        end
      end
    end
  end
end
