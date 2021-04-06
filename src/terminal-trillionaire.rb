require "./lib/controllers/Initialisation.rb"
require "./lib/views/console/console.rb"
include Controllers::Initialisation

begin
    initialise
    # console

end