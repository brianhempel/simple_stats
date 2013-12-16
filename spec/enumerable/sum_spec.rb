require 'spec_helper'

sum_expectations = {
  []                     => 0, # see http://en.wikipedia.org/wiki/Empty_sum
  [1]                    => 1,
  [1.0]                  => 1.0,
  [1, -1]                => 0,
  [1, 2, 3]              => 6,
  [1, 2, 3.0]            => 6.0,
  (0...0)                => 0, # see http://en.wikipedia.org/wiki/Empty_sum
  (1..1)                 => 1,
  (0..3)                 => 6,
  [BigDecimal("0.0")]    => BigDecimal("0.0"),
  [3, BigDecimal("1.0")] => BigDecimal("4.0")
}

describe Enumerable do
  describe "#sum" do
    sum_expectations.each do |data, expected|
      it "is #{expected.inspect} for #{data.inspect}" do
        sum = data.sum
        sum.should       == expected
        sum.class.should == expected.class
      end
    end

    it "calls map first if a block is given" do
      f = Struct.new(:x)
      data = [f.new(4), f.new(1), f.new(6)]
      data.sum(&:x).should == 11
    end
  end
end