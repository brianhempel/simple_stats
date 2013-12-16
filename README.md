# SimpleStats [![Build Status](https://secure.travis-ci.org/brianhempel/simple_stats.png)](http://travis-ci.org/brianhempel/simple_stats)


Install without Bundler:

    gem install simple_stats --no-ri --no-rdoc

Install with Bundler:

```ruby
gem "simple_stats"
```

Then get some statistics on arrays or enumerables:

```ruby
require 'rubygems' # if not using Bundler
require 'simple_stats'

samples = [3, 1, 0, 8, 2, 2, 3, 9]

samples.sum    # 28 
samples.mean   # 3.5 
samples.median # 2.5 
samples.modes  # [2, 3] 
samples.frequencies
# {
#   0 => 1,
#   1 => 1,
#   2 => 2,
#   3 => 2,
#   8 => 1,
#   9 => 1
# }
samples.sorted_frequencies
# most common elements first
# [
#   [2, 2],
#   [3, 2],
#   [0, 1],
#   [1, 1],
#   [8, 1],
#   [9, 1]
# ]

# of course, you can take modes/frequencies on non-numeric data...
"banana nanny!".chars.modes
# ["n"]
"banana nanny!".chars.frequencies
# {
#   " " => 1,
#   "! "=> 1,
#   "a" => 4,
#   "b" => 1,
#   "n" => 5,
#   "y" => 1
# }
"banana nanny!".chars.sorted_frequencies
# [
#   ["n", 5],
#   ["a", 4],
#   [" ", 1],
#   ["!", 1],
#   ["b", 1],
#   ["y", 1]
# ]

# sum of nothing is 0
[].sum # 0

# mean and median of nothing is undefined
[].mean   # nil
[].median # nil

# modes and frequencies return empty containers
[].modes              # []
[].frequencies        # {}
[].sorted_frequencies # []

# if elements are present, mean and median always return floats
[1, 2, 3].mean      # 2.0
[1, 2, 3].median    # 2.0
[1, 2, 3, 4].mean   # 2.5
[1, 2, 3, 4].median # 2.5

# sum, mode, and frequencies preserve the object class
[1, 2, 3].sum       # 6
[1.0, 2.0, 3.0].sum # 6.0

# but no guarantees on class here:
[2.0, 2,   1].modes # [2]
[2,   2.0, 1].modes # [2.0]
```

## Mapping

If the thing you want stats on is buried in your objects, you can pass a block to any SimpleStats method.

```ruby
# these two lines do the same thing
cities.mean {|city| city.population}
cities.map  {|city| city.population}.mean

# other examples
cities.sum(&:public_school_count)
cities.mean(&:public_school_count)
cities.frequencies(&:professional_team_count)

# more complicated examples
cities.median {|city| city.municipal_income / city.schools.sum(&:students)}
cities.map(&:schools).flatten.modes(&:team_name) # most common school sports team name
cities.map(&:professional_teams).flatten.sorted_frequencies(&:kind) # number of different kinds of sports teams
```

If you have an array of arrays or an array of hashes (really, an array of anything that responds to the `:[]` method), pass an argument to any SimpleStats method to indicate which element of each array or hash you want stats on.

```ruby
items = [
	{"name" => "picture", "unit cost" => 6.00},
	{"name" => "bottle",  "unit cost" => 3.25},
	{"name" => "hammer",  "unit cost" => 4.50}
]

# these two lines do the same thing
items.mean("unit cost")
items.mean {|item| item["unit cost"]}

# say I have a comma-separated values file of sales...
require 'csv'
sales = CSV.read("sales.csv") # gives us an array of arrays

# if profit is in the fifth column (element 4 of every row)...
sales.median(4) # median profit per sale
sales.sum(4)    # total profit (though see note about ActiveSupport below)
```

## Interaction with other gems

If any of SimpleStats' methods are already defined on Enumerable, SimpleStats _will not_ replace them with its own definition. In particular, ActiveSupport [defines a `sum` method](https://github.com/rails/rails/blob/master/activesupport/lib/active_support/core_ext/enumerable.rb). If both ActiveSupport and SimpleStats are used, the `sum` method will come from ActiveSupport.

ActiveSupport's `sum` method can take a block, just like SimpleStats' `sum` method. However, an argument to ActiveSupport's `sum` indicates the sum of the empty set.

```ruby
# SimpleStats
[].sum                 # 0
items.sum("unit cost") # same as items.map {|i| i["unit cost]}.sum

# ActiveSupport
[].sum                 # 0
[].sum(nil)            # nil
items.sum("unit cost") # does not work
```

The other SimpleStats methods are unaffected by ActiveSupport.

## Help make it better!

Need something added? [Open an issue](https://github.com/brianhempel/simple_stats/issues). Or, even better, code it yourself and send a pull request:

    # fork it on github, then clone:
    git clone git@github.com:your_username/simple_stats.git
    bundle install
    rspec
    # hack away
    git push
    # then make a pull request

## License

Public domain. (I, Brian Hempel, the original author release this code to the public domain. February 10, 2012.)