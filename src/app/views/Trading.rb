require 'colorize'
require_relative "./Helpers.rb"
require_relative "../models/market/Catalogue.rb"
require_relative "../models/market/SecurityPricing.rb"

include Market

module Views
    module Trading
        def self.get_trade(user)
            system 'clear'
            STDIN.iflush

            tty_prompt = TTY::Prompt.new
            
            # true = buy, false = sell
            trade_type = tty_prompt.select("Welcome to the trading platform, #{user.file[:username]}!\nYou currently have #{("$"+number_comma(user.file[:holdings][:CASH])).colorize(:light_blue)} to play with.\nWill you be intending to make a buy order or a sell order?\n", {Buy: true, Sell: false}, show_help: :always)
            trade_ticker = tty_prompt.select("#{trade_type ? "Time to put your money where your mouth is!" : "Never hang on to a loser!"}\nWhich security would you like to transact with today?\n", Catalogue::TICKERS[1..Catalogue::TICKERS.length], cycle: true, show_help: :always)
            locked_price = SecurityPricing.prices(trade_ticker)[:current]
            p locked_price
            # trade_qty = STDIN.gets.strip
            
            
            # p trade_type; p trade_ticker
            [:CASH,1000000,1] # test trade
            # insufficient cash/stock logic
            # LAST IN FIRST OUT - sell behaviour - traverse trade history
        end

        def quick_trade
            # quick route to trade section in control flow
        end
    end
end