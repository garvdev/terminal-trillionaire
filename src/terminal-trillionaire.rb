require "./lib/controllers/Initialisation.rb"
require "./lib/controllers/ConsolePrompt.rb"
include Controllers::Initialisation
include Controllers::ConsolePrompt

begin
    initialise
    prompt
end