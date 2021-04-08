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

    class FileManagement
        include YamlEncryption
        attr_accessor :file

        def initialize
            decrypt('portfolio.yml')
            @file = YAML.load(File.read('portfolio.yml'))
            encrypt('portfolio.yml')
        rescue SystemCallError
            #{username: "user", holdings: {ticker1: [QTY, AVG_COST_BASIS]}, trades: [ticker1, QTY, COST_BASIS]}
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
            @file[:holdings][:CASH] = [1_000_000_000, 1]
            @file[:trades][0] = [:CASH, 1_000_000_000, 1]
            save
        end
        
    end
end