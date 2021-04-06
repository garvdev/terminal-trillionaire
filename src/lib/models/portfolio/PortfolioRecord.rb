require 'yaml'
require 'symmetric-encryption'

module Portfolio
    class Record
        attr_accessor :history, :user
        SymmetricEncryption.cipher = SymmetricEncryption::Cipher.new(
            key:         "please dont peek",
            iv:          "please dont peek",
            cipher_name: "aes-128-cbc"
        )

        def initialize
            decrypt = SymmetricEncryption::Reader.open('portfolio.yml') {|file| file.read}
            File.open('portfolio.yml','w') {|file| file.write(decrypt)}
            @history = YAML.load(File.read('portfolio.yml'))
            encrypt = File.read('portfolio.yml')
            SymmetricEncryption::Writer.open('portfolio.yml') {|file| file.write(encrypt)}
            
            @user = @history[0]

        rescue SystemCallError
            @history = []
            @user = nil
        end
        
        def save
            File.open('portfolio.yml','w') {|file| file.write(@history.to_yaml)}
            encrypt = File.read('portfolio.yml')
            SymmetricEncryption::Writer.open('portfolio.yml') {|file| file.write(encrypt)}
        end
    end
end