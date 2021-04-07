module Views
    def SleepKeyPress(time, state)
        Timeout::timeout(time){state.getch}
        rescue Timeout::Error
    end
end