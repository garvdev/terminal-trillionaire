module Views
    module Landing
        def self.get_user
            puts "Psst, it looks like you haven't been here before.\nWould you kindly tell us your name?"
            begin
                user = gets.strip.downcase.capitalize
            end until user != ""
            user
        end
    end
end