require_relative "./ConsoleController.rb"

module Controllers
    module ConsoleRoutes
        def self.dispatch(input)
            case input
                when "market"
                    ConsoleController.show_market
            end
        end
    end
end