require "tty-table"
require "curses"
require "io/console"
require_relative "../../SleepKeyPress.rb"

include Curses
include Views

module Views
    module Console
        module Display
            module Market
                def self.show
                    Curses.init_screen
                    curs_set(0)
                    noecho
                    system 'clear'
                    win = Curses.stdscr
                    win.clear
                    sleep 1
                    STDIN.iflush

                    t = Thread.new do
                        while true
                            sleep 1
                            x = 0
                            y = 0
                            win.setpos(y, x)

                            Curses.init_pair(2, Curses::COLOR_WHITE, Curses::COLOR_BLACK)
                            win.attrset(color_pair(2))

                            table = []
                            yield.each_pair do |k,v|
                                table << [k, "   #{'%.2f'%v[:current]}   ", "   #{'%.2f'%v[:day]}   ", "   #{'%.2f'%v[:month]}   ", "   #{'%.2f'%v[:year]}   ", "   #{'%.2f'%v[:decade]}   "]
                            end

                            tty_table = TTY::Table.new(header: ["Ticker", "Current", "1D", "1M", "1Y", "10Y"], rows: table)
                        
                            win.addstr("#{tty_table.render(:unicode, alignment: [:center])}") 
                            win.refresh 
                        end
                    end

                    SleepKeyPress(5,win)
                    win.addstr("\nPress any key to return to the console.")
                    win.refresh
                    
                    win.getch

                    t.kill 
                    Curses.close_screen 
                end
            end
        end
    end
end