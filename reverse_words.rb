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
# Given the array "words", without using any Ruby magic (e.g. "#reverse"),
# invert its order.
# 

sentence = []

#
# Here, n serves as our counter
# 
n = words.count

while n != 0

  sentence << words[n - 1]
  n = n - 1
end

#
# Now, output the sentence correctly
# 
puts sentence.join(" ")
