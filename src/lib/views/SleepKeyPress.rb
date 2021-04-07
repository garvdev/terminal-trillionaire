module Views
    def SleepKeyPress(time, state)
        time = 0.1 if time == 0
        Timeout::timeout(time){state.getch}
        rescue Timeout::Error
    end
end