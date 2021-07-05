require 'colorize'
require 'tty-table'
require 'tty-cursor'
require 'io/console'
require_relative '../helpers'

module Views
  module Display
    module TradeLog
      def self.show(user)
        system 'clear'
        tty_cursor = TTY::Cursor
        tty_cursor.invisible do
          trades = []
          user.file[:trades].each.with_index { |x, i| trades << [i + 1, x].flatten }
          trades.map! do |x|
            [x[0], x[1], "#{number_comma(x[3].to_f)} ", "#{number_comma(x[2].to_f)} ",
             "#{number_comma((x[2] * x[3]).to_f)} "]
          end

          tty_table = TTY::Table.new ['  ID  ',
                                      ' Security ',
                                      '   Unit Cost ',
                                      '    Quantity ',
                                      ' Total Value '],
                                     trades
          separated_table = tty_table.render(:unicode,
                                             alignments: %i[center center right right right]) do |renderer|
            renderer.border.separator = ->(row) { row == 0 || (row + 1).even? }
            renderer.filter = lambda { |val, row_index, col_index|
              return val.bold if row_index == 0

              if row_index > 0 && col_index == 4
                val.to_i >= 0 ? val.to_s.light_green : val.to_s.light_red
              else
                val
              end
            }
          end

          puts separated_table
          puts 'The above is a list of all the executed trades associated with your portfolio (you may need to scroll to see earlier trades).'

          sleep_keypress(3, STDIN)
          puts "\nPress any key to return to the console."
          STDIN.getch
        end
      end
    end
  end
end
