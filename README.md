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