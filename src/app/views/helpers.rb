require 'tty-cursor'

module Views
  def sleep_keypress(time, state)
    time = 0.1 if time == 0
    Timeout.timeout(time) { state.getch }
  rescue Timeout::Error
  end

  def number_comma(number)
    number = '%.2f' % number if number.is_a?(Float)
    number.to_s.gsub(/(\d)(?=(\d{3})+(?!\d))/, '\1,')
    # Thanks to https://github.com/tararico/yukichi for the regex!
  end

  module Input
    class IntegerError < StandardError
      def initialize
        puts "Hang on, that doesn't look like a valid integer, please try again."
      end
    end

    class StringError < StandardError
      def initialize
        puts "Hold up, those don't look like proper words. Please try again without special characters."
      end
    end

    def self.get(type = 'string', max = 10)
      tries = 0
      begin
        cursor = TTY::Cursor
        case type
        when 'int'
          input = STDIN.gets.strip
          raise IntegerError unless /^\d+$/ === input

          input.to_i
        when 'string'
          input = STDIN.gets.strip
          raise StringError unless /^[a-zA-Z0-9\s]+$/ === input

          input
        end
      rescue StandardError
        print cursor.clear_lines(3) if tries > 0
        (puts 'Too many attempts. Exiting application...'; sleep 3; exit) if tries == max
        tries += 1
        retry
      end
    end
  end
end
