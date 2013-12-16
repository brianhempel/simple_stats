require 'spec_helper'

modes_expectations = {
  []                                          => [],
  [1]                                         => [1],
  [1.0]                                       => [1.0],
  [1, -1]                                     => [-1, 1],
  [3, 1, 3]                                   => [3],
  [3, 1, 3.0]                                 => [3],
  [3.0, 1, 3]                                 => [3.0],
  (0...0)                                     => [],
  (1..1)                                      => [1],
  (0..3)                                      => [0, 1, 2, 3],
  [BigDecimal("0.0")]                         => [BigDecimal("0.0")],
  [BigDecimal("1.0"), -2, BigDecimal("1.0")]  => [BigDecimal("1.0")],
  [:b, :c, :b, :c, :c, :a]                    => [:c]
}

describe Enumerable do
  describe "#modes" do
    modes_expectations.each do |data, expected|
      it "is #{expected.inspect} for #{data.inspect}" do
        modes = data.modes
        modes.should       == expected
        modes.class.should == expected.class
      end
    end

    it "calls map first if a block is given" do
      f = Struct.new(:x)
      data = [f.new(:a), f.new(:b), f.new(:b)]
      data.modes(&:x).should == [:b]
    end
  end
end