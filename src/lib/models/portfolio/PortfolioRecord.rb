require 'yaml'

module Portfolio
    class Record
        attr_accessor :history, :user

        def initialize
            @history = YAML.load(File.read('history.yml'))
            @user = @history[0]
            rescue SystemCallError
            @history = []
            @user = nil
        end

        def save
            @history << self
            File.open('history.yml','w') {|file| file.write(TRADES.to_yaml)}
        end
    end
end