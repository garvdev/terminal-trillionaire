require "./lib/controllers/Initialisation.rb"
require "./lib/controllers/Prompt.rb"
include Controllers::Initialisation
include Controllers::Prompt

begin
    prompt(initialise)
end