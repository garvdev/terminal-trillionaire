module Views
    module Landing
        module GetUser
            def self.name
                puts "Psst, it looks like you haven't been here before.\nWould you kindly tell us your name?"
                begin
                    user = gets.strip.downcase.capitalize
                end until user != ""
                user
            end
        end
    end
end