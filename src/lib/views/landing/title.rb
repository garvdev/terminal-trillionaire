require "curses"
include Curses

module Views
    module Landing
        module Title
            def self.show(user, status)
                Curses.init_screen
                Curses.start_color
                curs_set(0)
                noecho
                system 'clear'
                win = Curses.stdscr
                win.clear 
                sleep 1 

                intro = [["Hey there, #{user}!        ",:all,2],
                         ["It's good to see you again.",:old,2],
                         ["It's good to have you here.",:new,2],
                         ["Welcome to.                ",:new,1],
                         ["Welcome to..               ",:new,1],
                         ["Welcome to...              ",:new,1],
                         ["Welcome back to.           ",:old,1],
                         ["Welcome back to..          ",:old,1],
                         ["Welcome back to...         ",:old,1],
                         ["                           ",:all,0]]
                intro.each do |msg|
                    next if msg[1] != :all && msg[1] != status
                    win.setpos(1,2)
                    win.addstr("#{msg[0]}")
                    win.refresh
                    sleep msg[2]
                end

                t = Thread.new do 
                    Curses.init_pair(1, Curses::COLOR_GREEN, Curses::COLOR_BLACK)
                    Curses.init_pair(2, Curses::COLOR_WHITE, Curses::COLOR_BLACK)
                    flash = true
                    while true
                        flash ? (win.attrset(color_pair(1)); flash = false): (win.attrset(color_pair(2)); flash = true)
                        win.setpos(0,0)
                        win.addstr("
     /$$$$$$$$                                   /$$                     /$$       /$$$$$$$$           /$$ /$$ /$$ /$$                               /$$
    |__  $$__/                                  |__/                    | $$      |__  $$__/          |__/| $$| $$|__/                              |__/
       | $$     /$$$$$$   /$$$$$$  /$$$$$$/$$$$  /$$ /$$$$$$$   /$$$$$$ | $$         | $$     /$$$$$$  /$$| $$| $$ /$$  /$$$$$$  /$$$$$$$   /$$$$$$  /$$  /$$$$$$   /$$$$$$
       | $$    /$$__  $$ /$$__  $$| $$_  $$_  $$| $$| $$__  $$ |____  $$| $$         | $$    /$$__  $$| $$| $$| $$| $$ /$$__  $$| $$__  $$ |____  $$| $$ /$$__  $$ /$$__  $$
       | $$   | $$$$$$$$| $$  \\__/| $$ \\ $$ \\ $$| $$| $$  \\ $$  /$$$$$$$| $$         | $$   | $$  \\__/| $$| $$| $$| $$| $$  \\ $$| $$  \\ $$  /$$$$$$$| $$| $$  \\__/| $$$$$$$$
       | $$   | $$_____/| $$      | $$ | $$ | $$| $$| $$  | $$ /$$__  $$| $$         | $$   | $$      | $$| $$| $$| $$| $$  | $$| $$  | $$ /$$__  $$| $$| $$      | $$_____/
       | $$   |  $$$$$$$| $$      | $$ | $$ | $$| $$| $$  | $$|  $$$$$$$| $$         | $$   | $$      | $$| $$| $$| $$|  $$$$$$/| $$  | $$|  $$$$$$$| $$| $$      |  $$$$$$$
       |__/    \\_______/|__/      |__/ |__/ |__/|__/|__/  |__/ \\_______/|__/         |__/   |__/      |__/|__/|__/|__/ \\______/ |__/  |__/ \\_______/|__/|__/       \\_______/
                        ")
                        win.refresh
                        sleep 0.5
                    end
                end
                
                sleep 2
                win.addstr("\n  **Loud Airhorn Noises**")
                win.refresh
                sleep 2
                win.addstr("\n  Press any key to continue.")
                win.refresh
                
                win.getch
                t.kill 
                Curses.close_screen
            end
        end
    end
end