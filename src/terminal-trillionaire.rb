require "./lib/controllers/Initialisation.rb"
require "./lib/views/console/console.rb"
include Controllers::Initialisation

begin
    title
    load_portfolio ? create_portfolio : welcome_back
    # initialise console
end