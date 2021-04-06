require "colorize"
require "curses"
include Curses

module Views
    module Landing
        module Title
            def self.show
                Curses.init_screen
                Curses.start_color
                curs_set(0)
                noecho
                system 'clear'
                win = Curses.stdscr
                win.clear # clear buffer
                sleep 1 # sleep before adding string so program has time to set cursor

                intro = [["Hey there!                 ",2],
                         ["It's good to see you again.",2],
                         ["Welcome back to.           ",1],
                         ["Welcome back to..          ",1],
                         ["Welcome back to...         ",1],
                         ["                           ",0]]
                intro.each do |msg|
                    win.setpos(1,2)
                    win.addstr("#{msg[0]}")
                    win.refresh
                    sleep msg[1]
                end

                t = Thread.new do # new thread
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

                sleep 3
                win.addstr("\n  **Loud Airhorn Noises**")
                win.refresh
                
                win.getch

                t.kill # kill thread
                Curses.close_screen # close window
            end
        end
    end
end