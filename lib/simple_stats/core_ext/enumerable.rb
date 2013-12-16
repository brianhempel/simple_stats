module Enumerable
  unless method_defined? :sum
    def sum(&block)
      return map(&block).sum if block_given?
      inject(0) { |sum, x| sum + x }
    end
  end

  unless method_defined? :mean
    def mean(&block)
      return map(&block).mean if block_given?

      count = self.count # count has to iterate if there's no size method
      return nil if count == 0
      (sum / count.to_f).to_f
    end
  end

  unless method_defined? :median
    def median(&block)
      return map(&block).median if block_given?

      sorted = sort
      count  = sorted.size
      i      = count / 2

      return nil if count == 0
      if count % 2 == 1
        sorted[i]
      else
        ( sorted[i-1] + sorted[i] ) / 2.0
      end.to_f
    end
  end

  unless method_defined? :modes
    def modes(&block)
      return map(&block).modes if block_given?

      sorted_frequencies = self.sorted_frequencies
      sorted_frequencies.select do |item, frequency|
        frequency == sorted_frequencies.first[1]
      end.map do |item, frequency|
        item
      end
    end
  end

  unless method_defined? :frequencies
    # This function is oddly written in order to group 1 (integer) and 1.0 (float) together.
    # If we loaded a hash or used group_by, 1 and 1.0 would be counted as separate things.
    # Instead, we use the == operator for grouping.
    def frequencies(&block)
      return map(&block).frequencies if block_given?

      begin
        sorted = sort
      rescue NoMethodError # i.e. undefined method `<=>' for :my_symbol:Symbol
        sorted = sort_by do |item|
          item.respond_to?(:"<=>") ? item : item.to_s
        end
      end
      current_item = nil;

      Hash[
        sorted.reduce([]) do |frequencies, item|
          if frequencies.size == 0 || item != current_item
            current_item = item
            frequencies << [item, 1]
          else
            frequencies.last[1] += 1
            frequencies
          end
        end
      ]
    end
  end

  unless method_defined? :sorted_frequencies
    def sorted_frequencies(&block)
      return map(&block).sorted_frequencies if block_given?

      frequencies.sort_by do |item, frequency|
        if item.respond_to?(:"<=>")
          [-frequency, item]
        else
          [-frequency, item.to_s]
        end
      end
    end
  end
end