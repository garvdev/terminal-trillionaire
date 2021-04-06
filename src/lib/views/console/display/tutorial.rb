require "curses"
include Curses

module Views
    module Console
        module Display
            module Tutorial
                def self.show
                    Curses.init_screen
                    Curses.start_color
                    curs_set(0)
                    noecho
                    system 'clear'
                    win = Curses.stdscr
                    win.clear 
                    sleep 1 

                    tutorial = [["The year is 2050...\n",:all,3],
                                ["High speed automated trading bots have squeezed all the alpha from the market;\n",:all,3],
                                ["Poor housing market policy has left all the wealth concentrated in the top 0.1% of society;\n",:all,3],
                                ["Elon Tusk is still manipulating securities and cryptocurrency on Twitter.\n",:all,4],
                                ["But there is hope...\n",:all,3],
                                ["You are a precocious 6 year old who has stumbled upon an old terminal in the attic.\n",:all,3],
                                ["Intrigued, you pick it up and play with the controls, feeling a slight tingle in your fingertips.\n",:all,3],
                                ["'Must be the static', you think to yourself as you try to find Pacman.rb in the games section.\n",:all,3],
                                ["After a fruitless search, you give up and decide to settle with 'Terminal Trillionaire'.\n",:all,3],
                                ["'I guess this could kill an afternoon or two', you say out loud, speaking to nobody in particular.\n",:all,3],
                                ["Little do you know, the future of the world's economic health and prosperity rests on your shoulders...\n",:all,3]]

                    tutorial.each do |msg|
                        win.addstr("#{msg[0]}")
                        win.refresh
                        sleep msg[2]
                    end

                    win.addstr("\nPress any key to continue to the console.")
                    win.refresh
                    
                    win.getch
                    Curses.close_screen
                end
            end
        end
    end
end