require 'tty-prompt'

module Views
    module Console
        def user_input
            prompt = TTY::Prompt.new
            selections = [
                {name: "- View Live Market Feed", value: "market"},
                {name: "- Analyse Portfolio", value: "portfolio", disabled: "(out of order)"},
                {name: "- Execute Trades", value: "trading", disabled: "(out of order)"},
                {name: "- Calculate Scnearios", value: "calculator", disabled: "(out of order)"},
                {name: "- Exit", value: "exit"} 
            ]

            prompt.select("Hi! I'm Fjordan Belfort - reformed Norwegian Wall Street stockbroker.\nI'll be your friendly terminal assistant. What can I help you with today?\n", selections)
        end
    end
end