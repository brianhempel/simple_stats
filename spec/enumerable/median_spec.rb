require 'spec_helper'

median_expectations = {
  []                      => nil,
  [1]                     => 1.0,
  [1.0]                   => 1.0,
  [1, -1]                 => 0.0,
  [1, 2, 3000]            => 2.0,
  [1, 2, 3000.0]          => 2.0,
  [2, 2, 3000.0]          => 2.0,
  (0...0)                 => nil,
  (1..1)                  => 1.0,
  (0..3)                  => 1.5,
  [BigDecimal("0.0")]     => 0.0,
  [-2, BigDecimal("1.0")] => BigDecimal("-0.5")
}

describe Enumerable do
  describe "#median" do
    median_expectations.each do |data, expected|
      it "is #{expected.inspect} for #{data.inspect}" do
        median = data.median
        median.should       == expected
        median.class.should == expected.class
      end
    end
  end
end