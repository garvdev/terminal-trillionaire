require_relative '../smallest'

describe 'smallest' do
    it 'should return the smallest number in the array' do
        expect(smallest([1,2,3,4,5])).to be(1)
        expect(smallest([353,31,543,23,5])).to be(5)
        expect(smallest([1,2,-2,4,5])).to be(-2)
        expect(smallest([1,2,3,0,5])).to be(0)
        expect(smallest([34123123,54353652,23423461,1100,512323])).to be(1100)
    end
    it 'should return the smallest string in the array' do
        expect(smallest(["a","ab"])).to eq("a")
        expect(smallest(["c","b","sdf"])).to eq("b")
    end
    it 'should return nil if array is empty' do
        expect(smallest([])).to be(nil)
    end
end