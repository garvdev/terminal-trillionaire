require 'yaml'
require 'symmetric-encryption'

module Portfolio
    module YamlEncryption
        SymmetricEncryption.cipher = SymmetricEncryption::Cipher.new(
            key:    "please dont peek",
            iv:     "please dont peek",
            cipher_name: "aes-128-cbc"
        )

        def encrypt(file)
            encrypt = File.read(file)
            SymmetricEncryption::Writer.open(file) {|file| file.write(encrypt)}
        end
        
        def decrypt(file)
            decrypt = SymmetricEncryption::Reader.open(file) {|file| file.read}
            File.open(file,'w') {|file| file.write(decrypt)}
        end
    end

    class FileRecord
        include YamlEncryption
        attr_accessor :file

        def initialize
            decrypt('portfolio.yml')
            @file = YAML.load(File.read('portfolio.yml'))
            encrypt('portfolio.yml')
        rescue OpenSSL::Cipher::CipherError
            puts "Sorry, it appears your portfolio.yml file was corrupted. Please delete/backup your existing file before trying again."
            puts "Exiting program..."
            sleep 3
            exit
        rescue SystemCallError # no file found, initialize empty portfolio.
            # Portfolio storage structure - {username: "user", holdings: {Ticker: [QTY, TOTAL_COST]}, trades: [Ticker, QTY, COST_BASIS_PER_SHARE]}
            @file = {username: nil, holdings: {}, trades: []} 
        end
        
        def save
            File.open('portfolio.yml','w') {|file| file.write(@file.to_yaml)}
            encrypt('portfolio.yml')
        end

        def new_start(name)
            @file[:username] = name
            @file[:holdings][:CASH] = [1_000_000, 1_000_000]
            @file[:trades][0] = [:CASH, 1_000_000, 1]
            
            save
        end

        # Incoming trade structure - [Ticker, QTY, COST_BASIS_PER_SHARE]
        def execute_trade(trade)
            # store trade history
            @file[:trades] << trade

            # check if holdings exist
            if @file[:holdings].key?(trade[0])
                case
                when trade[1] >= 0
                    # buy trade - add to existing holdings
                    ((@file[:holdings][trade[0]][0] += trade[1]); (@file[:holdings][trade[0]][1] += (trade[1] * trade[2])))
                when trade[1] < 0
                    # sell trade - reduce existing holdings and preserve average cost basis
                    # reduce total cost basis by weighted value rather than sell price so it can never be less than 0
                    @file[:holdings][trade[0]][1] += ((trade[1].to_f / @file[:holdings][trade[0]][0].to_f) * @file[:holdings][trade[0]][1])
                    @file[:holdings][trade[0]][0] += trade[1]
                end
            else
                # assign initial values if holdings do not already exist
                @file[:holdings][trade[0]] = [trade[1],trade[1]*trade[2]]
            end

            # garbage collection - remove holdings with 0 or negative values (although trading view should never let holdings go below 0) - stops tables from showing nil holdings.
            @file[:holdings].delete_if {|k,v| v[0] <= 0 && k != :CASH}

            save
        end
    end
end