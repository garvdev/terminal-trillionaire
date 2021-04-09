require "tty-table"
require "curses"
require "io/console"
require_relative "../Helpers.rb"

include Curses

module Views
    module Display
        module Portfolio
            def self.show(user)
                Curses.init_screen
                Curses.start_color
                curs_set(0)
                noecho
                system 'clear'
                
                win = Curses.stdscr
                win.clear 
                sleep 1
                STDIN.iflush

                Curses.init_pair(2, Curses::COLOR_WHITE, Curses::COLOR_BLACK)
                win.attrset(color_pair(2))
                
                
                t = Thread.new do
                    while true
                        sleep 1
                        win.setpos(0,0)

                        current_prices = {}
                        table = []
                        
                        user.file[:holdings].each_pair do |k,v|
                            table << [k,v[0],v[1],v[1]/v[0]]
                        end

                        yield.each_pair do |k,v|
                            current_prices[k] = "#{v[:current]}"
                        end
                        
                        table.each do |x| 
                            x << current_prices.fetch(x[0]).to_f
                            
                            # x << (x.last * x[1])
                            # x << (x.last - x[2])
                            # x.map! {|x| x.is_a?(Symbol) ? x : number_comma(x)}
                        end

                        win.addstr("#{table}#{current_prices}") #testing
                        win.refresh #testing
                        
                        # tty_table = TTY::Table.new(header: [" Security ", "Quantity ", "Total Cost Basis", "Avg Cost Basis", "Current Price", "Total Value", "P&L"], rows: table)
                        # win.addstr("#{tty_table.render(:unicode, alignments: [:center,:right,:right,:right,:right,:right,:right,:right])}") 
                        # win.refresh
                    end
                end

                sleep_keypress(5,win)
                win.addstr("\nPress any key to return to the console.")
                win.refresh
                
                win.getch

                t.kill 
                Curses.close_screen
            end
        end
    end
end