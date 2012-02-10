require 'spec_helper'

describe Enumerable do
  describe "#sorted_frequencies" do
    it "returns #frequencies sorted by [frequency, value]" do
      enumerable = (0...0)
      enumerable.stub(:frequencies) do
        {
          "White-breasted Nuthatch" => 1,
          "Red-breasted Nuthatch"   => 1,
          "Brown Creeper"           => 1,
          "Squirrel"                => 1,
          "Marmelade"               => 1000,
          :yeah                     => 3,
          :man                      => 3,
          11                        => 12
        }
      end

      enumerable.sorted_frequencies.should == [
        ["Marmelade", 1000],
        [11, 12],
        [:man, 3],
        [:yeah, 3],
        ["Brown Creeper", 1],
        ["Red-breasted Nuthatch", 1],
        ["Squirrel", 1],
        ["White-breasted Nuthatch", 1]
      ]
    end
  end
end