require_relative "../app/views/Helpers.rb"
include Views

describe "Helpers" do
    # Suppress standard output so method's print instruction doesn't clear previous lines and remove rspec messages
    before(:all) do
        @original_stdout = $stdout
        @original_stderr = $stderr
        $stdout = File.open(File::NULL, 'w')
        $stderr = File.open(File::NULL, 'w')
    end

    # Test cases for valid integer input    
    it "should return validated inputs when receiving integers with no special characters" do
        allow($stdin).to receive(:gets).and_return("87123")
        expect{Input.get("int")}.not_to raise_error
        allow($stdin).to receive(:gets).and_return("1234123")
        expect{Input.get("int")}.not_to raise_error
        allow($stdin).to receive(:gets).and_return("0")
        expect{Input.get("int")}.not_to raise_error

        allow($stdin).to receive(:gets).and_return("123.24")
        expect{Input.get("int")}.to raise_error(SystemExit)
        allow($stdin).to receive(:gets).and_return("-123458")
        expect{Input.get("int")}.to raise_error(SystemExit)
        allow($stdin).to receive(:gets).and_return("0.1234")
        expect{Input.get("int")}.to raise_error(SystemExit)
        allow($stdin).to receive(:gets).and_return("0][][23")
        expect{Input.get("int")}.to raise_error(SystemExit)
        allow($stdin).to receive(:gets).and_return("fail")
        expect{Input.get("int")}.to raise_error(SystemExit)
    end
    
    # Test cases for valid string input    
    it "should return validated inputs when receiving strings with no special characters" do
        allow($stdin).to receive(:gets).and_return("garvey")
        expect{Input.get}.not_to raise_error
        allow($stdin).to receive(:gets).and_return("Garvey Chan")
        expect{Input.get}.not_to raise_error
        allow($stdin).to receive(:gets).and_return("Coder Academy T1A3")
        expect{Input.get}.not_to raise_error

        allow($stdin).to receive(:gets).and_return("][][][")
        expect{Input.get}.to raise_error(SystemExit)
        allow($stdin).to receive(:gets).and_return("garvey.chan")
        expect{Input.get}.to raise_error(SystemExit)
        allow($stdin).to receive(:gets).and_return(123123)
        expect{Input.get}.to raise_error(SystemExit)
        allow($stdin).to receive(:gets).and_return("123123.0")
        expect{Input.get}.to raise_error(SystemExit)
    end
end