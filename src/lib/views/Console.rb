require_relative "../controllers/Initialisation.rb"
require_relative "./SleepKeyPress.rb"
require 'tty-prompt'
require "io/console"

include Controllers::Initialisation
include Views

module Views
    module Console
        def user_input(user_status, first_console, quick)
            
            return quick_route if quick == true

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
                {name: "- Analyse Portfolio", value: "portfolio"},
                {name: "- Execute Trades", value: "trading", disabled: "(out of order)"},
                {name: "- Calculate Scenarios", value: "calculator", disabled: "(out of order)"},
                {name: "- Revisit Briefing", value: "brief"},
                {name: "- Help", value: "help", disabled: "(out of order)"},
                {name: "- Exit", value: "exit"} 
            ]
            tty_prompt.select("What can I help you with today?\n", selections, cycle: true, per_page: 10, show_help: :always)
        end

        def quick_route
            case ARGV[0]
            when /^-m(arket)*/
                return "market"
            when /^-p(ortfolio)*/
                return "portfolio"
            when /^-b(uy)*/
                return "trading" #placeholders
            when /^-s(ell)*/
                return "trading" #placeholders
            when /^-h(elp)*/
                return "help"
            else
                puts "Your command line argument was not recognised.\nPlease refer to the help guide for more information."
                SleepKeyPress(2,STDIN)
                puts "Now taking you to the console..."
                SleepKeyPress(3,STDIN)
                system 'clear'
            end
        end
    end
end