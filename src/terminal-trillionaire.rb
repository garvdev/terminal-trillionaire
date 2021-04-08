require "./lib/controllers/Initialisation.rb"
require "./lib/controllers/Prompt.rb"
include Controllers::Initialisation
include Controllers::Prompt

begin
    ARGV[0] ? prompt(initialise(true),true) : prompt(initialise)
end