require "./lib/controllers/Initialisation.rb"
require "./lib/controllers/console/Prompt.rb"
include Controllers::Initialisation
include Controllers::Console::Prompt

begin
    prompt(initialise)
end