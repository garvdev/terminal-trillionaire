require 'benchmark'
require_relative "../SecurityPricing.rb"
include Market::SecurityPricing

describe "SecurityPricing" do
    # count test
    it "should return 5 key value pairs for each timestamp (current, 1 day ago, 1 month ago, 1 year ago, 1 decade ago)" do
        # count key value pairs in returned prices hash
        count_array = Market::SecurityPricing.prices("TEST").count

        # pass test if there are 5 key value pairs
        expect(count_array).to eq(5)
    end

    #f ormat test
    it "should return floats for each timestamp (current, 1 day ago, 1 month ago, 1 year ago, 1 decade ago)" do
        # check each value in returned prices hash is a float, returning boolean for each, and collapsing array into unique values.
        float_array = Market::SecurityPricing.prices("TEST").map{|k,v| v.is_a?(Float)}.uniq
        
        # pass test if full array is true
        expect(!!float_array).to eq(true)
    end

    # benchmark test
    it "should return 10000 sets of security prices across all timestamps in less than 1 second" do
        # number of sets
        n = 10_000
        # measure time taken to perform n number of operations
        time = Benchmark.measure do
            n.times {Market::SecurityPricing.prices("TEST")}
        end
        # pass test of real time passed is less than 1 second
        expect(time.real).to be < 1
    end
    
    # growth test
    it "should return prices with a distinct growth curve over time" do
        # create array of price values
        price_array = Market::SecurityPricing.prices("TEST").values
        # iterate through array, changing values to true if smaller than following value
        price_array.map!.with_index {|x,i| price_array[i+1].nil? ? true : price_array[i+1] > x}
        # pass test if full array is true
        expect(!!price_array.uniq).to eq(true)
    end

    # volatility test
    it "should return prices fluctuating within bands of -2% and 2% each second" do
        # initialise test array to capture all booleans from subtests
        test_array = []

        # repeat test 10 times over 10 seconds
        10.times do
            # store prices in array
            old_prices = Market::SecurityPricing.prices("TEST").values
            # calculate expected range for next array of prices
            expected_price_ranges = old_prices.map {|price| [price*0.98, price*1.02]}

            # wait 1 second
            sleep 1

            # store new prices in array
            new_prices = Market::SecurityPricing.prices("TEST").values
            # test new prices aren't the same as old prices and they fall within expected range 98-102%.
            test_array << !!new_prices.map.with_index {|x,i| x.between?(expected_price_ranges[i][0],expected_price_ranges[i][1]) && x != old_prices[i]}.uniq
        end
        # pass test if full array is true
        expect(!!test_array.uniq).to eq(true)
    end

end