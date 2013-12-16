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
  [BigDecimal("0.0")]     => 0.0,
  [-2, BigDecimal("1.0")] => -0.5
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

    it "calls map first if a block is given" do
      f = Struct.new(:x)
      data = [f.new(4), f.new(1), f.new(6)]
      data.mean(&:x).should == 11 / 3.0
    end

    it "calls map with the :[] method if an argument is given" do
      data = [
        {"element" => 4},
        {"element" => 1},
        {"element" => 6}
      ]
      data.mean("element").should == 11 / 3.0
    end
  end
end