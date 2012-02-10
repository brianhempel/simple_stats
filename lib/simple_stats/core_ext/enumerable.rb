module Enumerable
  def sum
    inject(0) { |sum, x| sum + x }
  end

  def mean
    count = self.count # count has to iterate if there's no size method
    return nil if count == 0
    sum / count.to_f
  end

  def median
    sorted = sort
    count  = sorted.size
    i      = count / 2

    return nil if count == 0
    if count % 2 == 1
      sorted[i].to_f
    else
      ( sorted[i-1] + sorted[i] ) / 2.0
    end
  end

  def modes
    sorted_frequencies = self.sorted_frequencies
    sorted_frequencies.select do |item, frequency|
      frequency == sorted_frequencies.first[1]
    end.map do |item, frequency|
      item
    end
  end

  def frequencies
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

  def sorted_frequencies
    frequencies.sort_by do |item, frequency|
      if item.respond_to?(:"<=>")
        [-frequency, item]
      else
        [-frequency, item.to_s]
      end
    end
  end
end