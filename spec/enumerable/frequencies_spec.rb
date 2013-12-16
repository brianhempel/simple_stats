require 'spec_helper'

frequencies_expectations = {
  []                       => {},
  [1]                      => { 1 => 1 },
  [1.0]                    => { 1.0 => 1 },
  [1, -1]                  => { -1 => 1, 1 => 1 },
  [3, 1, 3]                => { 3 => 2, 1 => 1 },
  [3, 1, 3.0]              => { 3 => 2, 1 => 1 },
  [3.0, 1, 3]              => { 3.0 => 2, 1 => 1 },
  (0...0)                  => {},
  (1..1)                   => { 1 => 1 },
  (0..3)                   => { 0 => 1, 1 => 1, 2 => 1, 3 => 1 },
  [BigDecimal("0.0")]      => { BigDecimal("0.0") => 1 },
  [-2, BigDecimal("1.0")]  => { -2 => 1, BigDecimal("1.0") => 1 },
  [:b, :c, :b, :c, :c, :a] => { :c => 3, :b => 2, :a => 1 }
}

describe Enumerable do
  describe "#frequencies" do
    frequencies_expectations.each do |data, expected|
      it "is #{expected.inspect} for #{data.inspect}" do
        frequencies = data.frequencies
        frequencies.should       == expected
        frequencies.class.should == expected.class
      end
    end

    it "calls map first if a block is given" do
      f = Struct.new(:x)
      data = [f.new(:a), f.new(:b), f.new(:b)]
      frequencies = data.frequencies(&:x)
      frequencies.should == {
        :a => 1,
        :b => 2
      }
    end

    it "calls map with the :[] method if an argument is given" do
      data = [
        {"element" => :a},
        {"element" => :b},
        {"element" => :b}
      ]
      frequencies = data.frequencies("element")
      frequencies.should == {
        :a => 1,
        :b => 2
      }
    end
  end
end
