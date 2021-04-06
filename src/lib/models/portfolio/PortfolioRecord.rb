require 'yaml'

module Portfolio
    class Record
        attr_accessor :portfolio

        def initialize
            @portfolio = YAML.load(File.read('trades.yml'))
            rescue SystemCallError
            @portfolio = nil
        end

        def save
            @portfolio << self
            File.open('trades.yml','w') {|file| file.write(TRADES.to_yaml)}
        end
    end
end