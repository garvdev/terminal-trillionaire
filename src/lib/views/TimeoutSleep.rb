module Views
    def TimeoutSleep(time, state)
        Timeout::timeout(time){state.getch}
        rescue Timeout::Error
    end
end