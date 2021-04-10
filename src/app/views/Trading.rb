require "colorize"
require "tty-prompt"
require "tty-progressbar"
require "tty-cursor"
require "tty-table"
require "io/console"
require_relative "./Helpers.rb"
require_relative "../models/market/Catalogue.rb"
require_relative "../models/market/SecurityPricing.rb"

include Market

module Views
    module Trading
        def self.get_trade(user, quick)
            # quick_trade if ARGV[0] =~ /^-t(rade)*/

            while true
                system 'clear'
                STDIN.iflush
                
                cash = user.file[:holdings][:CASH][0]

                # holdings structure derived from model - {:Ticker => QTY, etc.}, excluding cash
                holdings = {}
                user.file[:holdings].each_pair {|k,v| (holdings[k] = v[0].to_i) unless k == :CASH}

                # initialise formatting tools
                tty_cursor = TTY::Cursor
                tty_bar = TTY::ProgressBar.new("Executing Trade [:bar]", total: 20, bar_format: :block)
                tty_prompt = TTY::Prompt.new
                tty_table = TTY::Table.new(header: [" Security ", " Quantity "], rows: holdings.to_a.map{|x| [x[0],number_comma(x[1])]})

                # greeting - show current portfolio if it exists
                puts "Welcome to the trading platform, #{user.file[:username]}!"
                (puts "Your portfolio holdings are as follows:"; puts tty_table.render(:unicode, alignment: [:center, :right])) unless holdings == {}

                # true => buy order, false => sell order, nil => return to console
                trade_type = tty_prompt.select("You currently have #{("$"+number_comma(cash)).light_green} to play with.\nWill you be intending to make a buy order or a sell order?\n", {Buy: :buy, Sell: :sell, Exit: :exit}, cycle: true, show_help: :always)
                
                # return to console
                break if trade_type == :exit

                # prompt for security selection and lock current price
                trade_ticker = tty_prompt.select("\n#{trade_type == :buy ? "Time to put your money where your mouth is!" : "Never hang on to a loser!"}\nWhich security would you like to transact with today?\n", Catalogue::TICKERS[1..Catalogue::TICKERS.length], cycle: true, show_help: :always)
                locked_price = SecurityPricing.prices(trade_ticker)[:current]
                puts "\nGreat choice! Our brokers have locked in a unit price of #{("$"+number_comma(locked_price)).light_green} for you."
                
                # display trade information based on selected criteria - return to top if insufficient cash/holdings
                case trade_type
                when :buy
                    (puts "\nHowever, it appears that you have insufficient cash to fund this purchase.\nConsider liquidating some of your existing holdings if you wish to make further purchases."; sleep_keypress(10,STDIN); next) if cash < locked_price
                    puts "With your current cash balance, you can purchase a maximum of #{(number_comma((cash/locked_price).floor.to_i)).light_cyan} shares of #{trade_ticker.to_s.light_blue}."
                when :sell
                    (puts "\nHowever, it appears that you do not have any existing holdings of the selected security.\nPlease try again with a different selection."; sleep_keypress(10,STDIN); next) unless holdings.flatten.include?(trade_ticker)
                    puts "With your existing #{trade_ticker.to_s.light_blue} holdings, you can sell a maximum of #{number_comma(holdings[trade_ticker]).light_cyan} units."
                end

                # Prompt for trade order quantity, execute trade if no issues, final prompt to return to top or back to console
                puts "How much #{trade_ticker.to_s.light_blue} would you like to #{trade_type == :buy ? "order" : "sell"} today?"
                trade_qty = fetch_quantity(trade_type, tty_cursor, holdings, trade_ticker, cash, locked_price)
                next unless trade_confirmation(trade_type, tty_prompt, tty_cursor, tty_bar, trade_qty, trade_ticker, locked_price) {|trade| yield trade}
                final_prompt(tty_prompt) ? next : break
            end
        end

        def quick_trade
            # quick route to trade section in control flow
        end

        # fetch desired trade quantity and return to main method
        def self.fetch_quantity(type, tty_cursor, holdings, trade_ticker, cash, locked_price)
            i = 0
            while true
                trade_qty = Input.get("int")
                (print tty_cursor.clear_lines(2); next) if trade_qty == 0
                type == :buy ? (break if trade_qty <= cash/locked_price) : (break if trade_qty <= holdings[trade_ticker])
                i == 0 ? (puts "#{type == :buy ? "You don't have enough cash for that! Please try a different number." : "You don't have that much #{trade_ticker.to_s.light_blue} to sell! Please try again with a different number."}") : (print tty_cursor.clear_lines(2))
                i += 1
            end
            trade_qty
        end

        # post-trade prompt for return to top or console
        def self.final_prompt(tty_prompt)
            STDIN.iflush
            puts; tty_prompt.yes?("Would you like to execute further trades?") {|q| q.suffix "y/n"} ? true : false
        end

        # trade confirmation prompt to ensure user is satisfied, yield successful trade to main method where it will be yielded back to the model to be executed
        def self.trade_confirmation(type, tty_prompt, tty_cursor, tty_bar, trade_qty, trade_ticker, locked_price)
            type == :buy ? x = 1 : x = -1
            puts; confirmed = tty_prompt.yes?("Confirming that you would like to #{x == 1 ? "purchase" : "sell"} #{number_comma(trade_qty).light_cyan} shares of #{trade_ticker.to_s.light_blue}, at a unit price of #{("$"+number_comma(locked_price)).light_green} for a total of #{("$"+number_comma(locked_price*trade_qty)).light_green}?") {|q| q.suffix "y/n"}
            puts; confirmed ? (tty_cursor.invisible{20.times {sleep 0.1;tty_bar.advance}}; puts "Trade executed successfully!"; yield [trade_ticker, trade_qty*x, locked_price] ; yield [:CASH, -(trade_qty*locked_price)*x, 1]) : (return false)
        end
    end
end