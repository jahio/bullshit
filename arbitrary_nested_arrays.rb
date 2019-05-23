#!/usr/bin/env ruby
require 'pp'
#
# Experienced Backend Engineer Array "test"
#   Company Name Redacted
#
# Write some code, that will flatten an array of arbitrarily nested arrays of integers
# into a flat array of integers. e.g. [[1,2,[3]],4] -> [1,2,3,4].
#
# Your solution should be a link to a gist on gist.github.com with your implementation.
#
# When writing this code, you can use any language you're comfortable with.
# The code must be well tested and documented if necessary, and in general please treat the quality of
# the code as if it was ready to ship to production.
#
# Try to avoid using language defined methods like Ruby's Array#flatten.*
#

arr = [[1,2,[3]],4, [5, 6, [7, 8, [9, [10]]]]]
@holding_array = []

#
# This method is to ascertain whether the value given is an integer and if not, continue down the array
# "stack" until you find the integer, then append that value to the end of @holding_array.
#
def find_int(obj)
  if obj.respond_to?(:each)
    # This is an array, not the object type sought.
    obj.each do |x|
      find_int(x)
    end
  else
    # This is an integer or other object, return it.
    @holding_array << obj
  end
end

find_int(arr)

puts "Input:"
pp arr
puts "Output:"
pp @holding_array