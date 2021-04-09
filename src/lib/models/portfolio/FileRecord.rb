require 'yaml'
require 'symmetric-encryption'

module Portfolio
    module YamlEncryption
        SymmetricEncryption.cipher = SymmetricEncryption::Cipher.new(
            key:         "please dont peek",
            iv:          "please dont peek",
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
        rescue SystemCallError
            #{username: "user", holdings: {ticker1: [QTY, TOTAL_COST]}, trades: [ticker1, QTY, COST_BASIS]}
            @file = {username: nil, holdings: {}, trades: []} 
        end
        
        def save
            decrypt('portfolio.yml')
        rescue SystemCallError
            File.open('portfolio.yml','w') {|file| file.write(@file.to_yaml)}
            encrypt('portfolio.yml')
        end

        def new_start(name)
            @file[:username] = name
            @file[:holdings][:CASH] = [100000, 100000]
            @file[:holdings][:PEAR] = [5000, 10000] #testing
            @file[:holdings][:CHLL] = [10000, 50000] #testing
            @file[:holdings][:YMMY] = [500, 1234200] #testing
            @file[:holdings][:EXCL] = [235, 1000230] #testing
            @file[:holdings][:WATR] = [87435, 34532] #testing
            @file[:holdings][:TEEM] = [4843, 23485] #testing
            @file[:holdings][:CODE] = [25236, 10] #testing
            @file[:holdings][:LAMP] = [6234, 456456] #testing
            @file[:holdings][:SOLA] = [62352, 4564555] #testing
            @file[:holdings][:TEXT] = [78567, 856745] #testing
            @file[:holdings][:EDSN] = [45345, 245321423] #testing
            @file[:trades][0] = [:CASH, 10, 10]
            @file[:trades][1] = [:PEAR, 5000, 2] #testing
            @file[:trades][2] = [:CHLL, 10000, 5] #testing
            @file[:trades][3] = [:EDSN, 50, 2000] #testing
            save
        end
        
    end
end