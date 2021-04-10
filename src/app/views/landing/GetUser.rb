require_relative "../Helpers.rb"

module Views
    module Landing
        def self.get_user
            puts "Psst, it looks like you haven't been here before.\nWould you kindly tell us your name?"
            user = Input.get.capitalize
            system 'clear'
            user
        end
    end
end