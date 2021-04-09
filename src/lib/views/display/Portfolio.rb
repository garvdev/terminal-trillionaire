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
                        summary = [[]]
                        
                        user.file[:holdings].each_pair do |k,v|
                            table << [k,v[0],v[1],v[1]/v[0]]
                        end

                        yield.each_pair do |k,v|
                            current_prices[k] = "#{v[:current]}"
                        end
                        
                        table.each do |x| 
                            x << current_prices.fetch(x[0]).to_f
                            x << (x.last * x[1])
                            x << (x.last - x[2])
                        end
                        
                        summary[0][0] = number_comma(table.map{|x| x[5]}.sum)
                        summary[0][1] = number_comma(table.map{|x| x[6]}.sum)
                        
                        table.each do |x|
                            x.map! {|y| y.is_a?(Symbol) ? y : number_comma(y)}
                        end

                        # win.addstr("#{totals}#{table}#{current_prices}") #testing
                        # win.refresh #testing
                        
                        table_main = TTY::Table.new(header: [" Security ", " Quantity ", " Total Cost Basis ", " Avg Cost Basis ", " Current Price ", " Total Value ", " Profit/Loss "], rows: table)
                        table_summary = TTY::Table.new(header: [" Portfolio Value "," Portfolio P&L "], rows: summary)

                        win.addstr("#{table_main.render(:unicode, alignments: [:center,:right,:right,:right,:right,:right,:right,:right])}") 
                        win.addstr("\n#{table_summary.render(:unicode, alignments: [:right,:right])}") 

                        win.refresh
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