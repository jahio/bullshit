#!/usr/bin/env ruby
#
# Given a sentence:
#   dog lazy the over jumps fox brown quick The
#
# Reverse that sentence so it reads:
#   The quick brown fox jumps over the lazy dog
#

backwards = "dog lazy the over jumps fox brown quick The"

#
# Start by splitting the words into an array using whitespace as our
# separator.
#

words = backwards.split(/\W+/)

#
# This will eventually hold the contents of the (reversed) string,
# with each word as an array element.
# 

sentence = []

#
# Here, n serves as our counter
# 
n = words.count

#
# Given the array "words", without using any Ruby magic (e.g. "#reverse"),
# invert its order. This works by setting a variable equal to the total number
# of words in the array, and running a "while" loop that checks if that number
# is zero. Then, on every trip through the loop, we take the highest number index
# of the words array, subtract one (since arrays are zero-indexed), push that
# IN ORDER onto the end of the (empty) "sentence" array object, then reduce
# the count of n by one. Eventually, on the last trip through, N will be zero
# thus exiting the loop.
# 

while n != 0

  sentence << words[n - 1]
  n = n - 1
end

#
# Now, "sentence" is also an array but with objects that look like this:
#   ["The", "quick", "brown", "fox", "jumps", "over", "the", "lazy", "dog"]
# 
# We can easily use the #join method to put these together into a string
# by using a simple space character as the one argument to #join.
# 
puts sentence.join(" ")
