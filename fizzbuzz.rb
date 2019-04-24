#!/usr/bin/env ruby

#
# FizzBuzz
#
# If you have a set of numbers (1 to, say, 50):
#   If it's divisible by 3, output "Fizz"
#   If it's divisible by 5, output "Buzz"
#   If it's divisible by BOTH, output "FizzBuzz"
#
# Otherwise, output the number itself.
#
# This program can be invoked with an argument on the command line, like so:
#   $ ruby fizzbuzz.rb 999
#
# If done this way, the program will go from 1 all the way to the argument given
# (999 in this example). By default it only goes up to 100.
#

#
# Test if we have an argument present, and that it's a valid number. If not,
# hard-code it to 100.
#

if ARGV[0] && ARGV[0].to_i > 1
  upto = ARGV[0].to_i
else
  upto = 100
end

(1..upto).each do |n|

  #
  # Here we declare an empty string called "output" so we can just tack stuff
  # on to it as-needed, output it at the end of the loop, and then reset it
  # when the loop starts again.
  #
  output = ''

  #
  # Using the modulo operator (%) is how we test for a remainder in division.
  # If there IS a remainder, it's not divisible by the given number. If there's
  # not a remainder (if it's zero), we have a number divisible by N.
  #

  if n % 3 == 0
    output << 'Fizz'
  end

  if n % 5 == 0
    output << 'Buzz'
  end

  #
  # By this point, output will either be blank, "Fizz", "Buzz", or "FizzBuzz".
  # This checks to see if it's blank and if so, defaults the output to N.
  #
  if output.length == 0
    output = n
  end

  puts output

end