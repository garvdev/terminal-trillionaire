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

    class Record
        attr_accessor :history, :user
        include YamlEncryption

        def initialize
            decrypt('portfolio.yml')
            @history = YAML.load(File.read('portfolio.yml'))
            encrypt('portfolio.yml')
            
            @user = @history[0]
            
        rescue SystemCallError
            @history = []
            @user = nil
        end
        
        def save
            decrypt('portfolio.yml')
        rescue SystemCallError
            File.open('portfolio.yml','w') {|file| file.write(@history.to_yaml)}
            encrypt('portfolio.yml')
        end
        
        def new_user(name)
            @user = name
            @history << @user
            @history << [:CASH, 1_000_000_000, 1]
            save
        end
        
    end
end