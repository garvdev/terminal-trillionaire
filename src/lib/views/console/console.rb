require_relative "../../controllers/Initialisation.rb"
require_relative "../SleepKeyPress.rb"
require 'tty-prompt'
require "io/console"

include Controllers::Initialisation
include Views

module Views
    module Console
        def user_input(user_status, first_console)            
            fjordan = [["Hi! I'm Fjordan Belfort, reformed Norwegian Wall Street stockbroker.\n",:all,2],
            ["I'll be your friendly terminal assistant.\n",:all,2],
            ["It looks like it's your first time here.\n",:new,2]]
            fjordan.each do |msg|
                next if msg[1] != :all && msg[1] != user_status
                puts msg[0]
                SleepKeyPress(msg[2],STDIN) if first_console == true 
            end
            
            STDIN.iflush

            tty_prompt = TTY::Prompt.new
            
            if user_status == :new
                tty_prompt.yes?("Would you like a briefing?") {|q| q.suffix "y/n"} ? (return "brief") : (puts "No worries! ")
            end
            
            selections = [
                {name: "- View Live Market Feed", value: "market"},
                {name: "- Analyse Portfolio", value: "portfolio", disabled: "(out of order)"},
                {name: "- Execute Trades", value: "trading", disabled: "(out of order)"},
                {name: "- Calculate Scenarios", value: "calculator", disabled: "(out of order)"},
                {name: "- Revisit Briefing", value: "brief"},
                {name: "- Help", value: "help", disabled: "(out of order)"},
                {name: "- Exit", value: "exit"} 
            ]
            tty_prompt.select("What can I help you with today?\n", selections, cycle: true, per_page: 10, show_help: :always)
        end
    end
end