require_relative '../models/market/catalogue'
require_relative '../views/display/market'
require_relative '../views/display/briefing'
require_relative '../views/display/portfolio'
require_relative '../views/display/trade_log'
require_relative '../views/display/help'
require_relative '../views/trading'

module Controllers
  module Controller
    include Views

    # show briefing
    def briefing
      Display::Briefing.show
    end

    # show live market feed - market view yields to model through block to fetch new prices
    def show_market
      Display::Market.show { ::Market::Catalogue.price_list }
    end

    # show portfolio - portfolio view yields to model through block to fetch new prices
    def show_portfolio(user)
      Display::Portfolio.show(user) { ::Market::Catalogue.price_list }
    end

    # trading platform - trades yielded to block to be saved in portfolio file
    def trading_platform(user, quick)
      Trading.get_trade(user, quick) { |trade| user.execute_trade(trade) }
    end

    # show trade log - all trades ever executed in the portfolio
    def show_log(user)
      Display::TradeLog.show(user)
    end

    # show application help
    def show_help
      Display::Help.show
    end
  end
end
