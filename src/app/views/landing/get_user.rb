require_relative '../helpers'

module Views
  module Landing
    def self.get_user
      puts "Psst, it looks like you haven't been here before.\nWould you kindly tell us your name?"
      user = Input.get.titleize
      system 'clear'
      user
    end
  end
end
