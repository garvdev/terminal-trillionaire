module Views
    def sleep_keypress(time, state)
        time = 0.1 if time == 0
        Timeout::timeout(time){state.getch}
        rescue Timeout::Error
    end

    def number_comma(number)
       number.to_s.gsub(/(\d)(?=(\d{3})+(?!\d))/, '\1,')
    end
end