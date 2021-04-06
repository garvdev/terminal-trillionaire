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

                    # tutorial = [["Hey there, #{user}!        ",:all,2],
                    #         ["It's good to see you again.",:old,2],
                    #         ["It's good to have you here.",:new,2],
                    #         ["Welcome to.                ",:new,1],
                    #         ["Welcome to..               ",:new,1],
                    #         ["Welcome to...              ",:new,1],
                    #         ["Welcome back to.           ",:old,1],
                    #         ["Welcome back to..          ",:old,1],
                    #         ["Welcome back to...         ",:old,1],
                    #         ["                           ",:all,0]]
                    # tutorial.each do |msg|
                    #     next if msg[1] != :all && msg[1] != status
                    #     win.setpos(1,2)
                    #     win.addstr("#{msg[0]}")
                    #     win.refresh
                    #     sleep msg[2]
                    # end

                    win.addstr("\n  Press any key to continue to the console.")
                    win.refresh
                    
                    win.getch
                    Curses.close_screen
                end
            end
        end
    end
end