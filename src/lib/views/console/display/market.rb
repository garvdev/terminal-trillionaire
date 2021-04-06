require "tty-table"
require "curses"
include Curses

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
                    t = Thread.new do # new thread
                        while true
                            win.clear # clear buffer
                            sleep 1 # sleep before adding string so program has time to set cursor
                            x = 0
                            y = 0
                            win.setpos(y, x)

                            table = []
                            yield.each_pair do |k,v|
                                table << [k, "   #{'%.2f'%v[:current]}   ", "   #{'%.2f'%v[:day]}   ", "   #{'%.2f'%v[:month]}   ", "   #{'%.2f'%v[:year]}   ", "   #{'%.2f'%v[:decade]}   "]
                            end

                            tty_table = TTY::Table.new(header: ["Ticker", "Current", "1D", "1M", "1Y", "10Y"], rows: table)
                        
                            win.addstr("#{tty_table.render(:unicode, alignment: [:center])}") # add string to buffer
                            win.refresh # bring buffer to screen
                        end
                    end
                    
                    win.getch

                    t.kill # kill thread
                    Curses.close_screen # close window
                end
            end
        end
    end
end