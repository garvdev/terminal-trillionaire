require_relative "../models/portfolio/FileRecord.rb"
require_relative "../views/landing/Title.rb"
require_relative "../views/landing/GetUser.rb"

include Views

module Controllers
    module Initialisation
        def load
            system 'clear'
            user = Portfolio::FileRecord.new
            user.file[:username].nil? ? (user.new_start(Landing.get_user); user_status = :new) : user_status = :old
            [user, user_status]
        end

        def initialise(quick=false)
            combined_user = load
            user = combined_user[0]
            user_status = combined_user[1]
            Landing.title(user.file[:username],user_status) unless quick == true
            combined_user
        end
    end
end