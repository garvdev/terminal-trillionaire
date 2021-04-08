require "./lib/controllers/Initialisation.rb"
require "./lib/controllers/Prompt.rb"
include Controllers::Initialisation
include Controllers::Prompt

begin
    ["-m","-p","-b","-s","-h"].include? ARGV[0] ? prompt(initialise(true),true) : prompt(initialise)
end