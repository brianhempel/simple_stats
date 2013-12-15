require 'spec_helper'

mean_expectations = {
  []                      => nil,
  [1]                     => 1.0,
  [1.0]                   => 1.0,
  [1, -1]                 => 0.0,
  [1, 2, 3]               => 2.0,
  [1, 2, 3.0]             => 2.0,
  [2, 2, 3.0]             => 7.0 / 3.0,
  (0...0)                 => nil,
  (1..1)                  => 1.0,
  (0..3)                  => 1.5,
  [BigDecimal("0.0")]     => BigDecimal("0.0"),
  [-2, BigDecimal("1.0")] => BigDecimal("-0.5")
}

describe Enumerable do
  describe "#mean" do
    mean_expectations.each do |data, expected|
      it "is #{expected.inspect} for #{data.inspect}" do
        mean = data.mean
        mean.should       == expected
        mean.class.should == expected.class
      end
    end
  end
end