require "curses"
require "tty-table"
require "logger"

module Logwatch
  class Window

    attr_reader :main, :messages, :top_sections, :stats

    def initialize
      Curses.init_screen
      Curses.curs_set 0 # invisible cursor
      Curses.noecho # don't echo keys entered

      @lines = []
      @pos = 0

      half_height = Curses.lines / 2 - 2
      half_width = Curses.cols / 2 - 3

      @messages = Curses::Window.new(Curses.lines, half_width, 0, 0)
      @messages.keypad true # translate function keys to Curses::Key constants
      @messages.nodelay = true # don't block waiting for keyboard input with getch
      @messages.refresh

      @top_sections = Curses::Window.new(half_height, half_width, 0, half_width)
      @top_sections.refresh

      @stats = Curses::Window.new(half_height, half_width, half_height, half_width)
      @stats << "Stats:"
      @stats.refresh
    end

    def handle_keyboard_input
      case @messages.getch
      when Curses::Key::UP, 'k'
        @pos -= 1 unless @pos <= 0
        paint_messages!
      when Curses::Key::DOWN, 'j'
        @pos += 1 unless @pos >= @lines.count - 1
        paint_messages!
      when 'q'
        exit(0)
      end
    end

    def print_msg(msg)
      @lines += Verse::Wrapping.new(msg).wrap(@messages.maxx - 10).split("\n")
      paint_messages!
    end

    def paint_messages!
      @pos ||= 0
      @messages.clear
      @messages.setpos(0, 0)
      @lines.slice(@pos, Curses.lines - 1).each { |line| @messages << "#{line}\n" }
      @messages.refresh
    end

    def update_top_sections(sections)
      table = TTY::Table.new header: ['Top Section', 'Hits'], rows: sections.to_a
      @top_sections.clear
      @top_sections.setpos(0, 0)
      @top_sections.addstr(table.render(:ascii, width: @top_sections.maxx - 2, resize: true))
      @top_sections.addstr("\nLast refresh: #{Time.now.strftime('%b %d %H:%M:%S')}")
      @top_sections.refresh
    end

    def update_stats(stats)
      table = TTY::Table.new header: ['Stats', ''], rows: stats.to_a
      @stats.clear
      @stats.setpos(0, 0)
      @stats.addstr(table.render(:ascii, width: @stats.maxx - 2, resize: true))
      @stats.addstr("\nLast refresh: #{Time.now.strftime('%b %d %H:%M:%S')}")
      @stats.refresh      
    end

    def teardown
      Curses.close_screen
    end

  end
end