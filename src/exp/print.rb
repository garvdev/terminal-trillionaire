require 'curses'

include Curses

Curses.init_screen
curs_set(0)
noecho
begin
    system 'clear'
    win = Curses.stdscr
    t = Thread.new do # new thread
        n = 0
        while true
            sleep 1 # sleep before adding string so program has time to set cursor
            x = win.maxx / 2 # middle of screen
            y = win.maxy / 2 # middle of screen
            win.setpos(y, x - 7)
            win.addstr("This is test #{n}.") # add string to buffer
            win.refresh # bring buffer to screen
            win.clear # clear buffer
            n += 1
        end
    end
    win.getch # get character
    t.kill # kill thread
    Curses.close_screen # close window
end