#!/usr/bin/env ruby
#
# numbers.rb
#   Given a string of numbers, "123456789", break it into an array
#   that looks like ["123", "456", "789"].
#

require 'pp'  # pretty print

str = "123456789"
arr = []

# 
# Since I know that groups of 3 digits are needed, using modulus of 3 helps
# delineate where to break the string into groups. Once that’s done, I also
# know that since I want groups of 3 digits exactly, I can subtract 2 from
# the index of that modulus digit, then use that as a marker of the first
# digit in the set, and then use Ruby’s range operator (..) to include the
# next two characters, resulting in 3 characters per set. All that’s left
# after that is to pop it onto the end of the array.
# 

str.each_char do |n|
  if n.to_i % 3 == 0
    # This is a number divisible by 3
    arr << str[(str.index(n)-2)..(str.index(n))]
  end
end

pp arr