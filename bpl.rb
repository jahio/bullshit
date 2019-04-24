#!/usr/bin/env ruby

#
# Blocks, Procs, and Lambdas (Oh, my!)
#
# Demonstrates each of these features of Ruby and explains differences between
# them using comments and code.
#

#
# BLOCKS
#
# A "block" is a unit of code to be executed. It's going to be enclosed in
# do/end or { }.
#
# This is an example of a block:
#

["I'm", "a", "block"].each do |n| # start of block, in this case we name each object "n"
  puts n
end

#
# Blocks can be enclosed in { } as well:
#

["I'm", "a", "block"].each { |n| puts n } # between the { }, that's the block

#
# PROCS
#
# "Proc" is short for "procedure". It's like a kind of block but you can pass
# it as an argument to a method, and in that method, if you call "yield", the
# method will, at that point in time, execute the block as if it were code
# written right there.
#

#
# This method has one argument expected: a proc. And in this case, we give it
# a name, too: "named_proc". To tell a method you want to accept a proc as an
# argument, put a & in front of the name you want to give to that proc.
#
def takes_a_proc(&my_proc)
  puts "I'm in the method, about to execute takes_a_proc..."
  yield
  puts "Ok, I'm done executing takes_a_proc."
end

#
# To use that method, we have to invoke it and pass it a proc, which is just
# another kind of block:
#
takes_a_proc { puts "I'm a proc!" }

#
# Another way to use a proc is to create it as an object, then pass it to a
# method later. You prefix that variable with an & symbol to tell it that you're
# giving it a proc.
#

named_proc = Proc.new { puts "I'm named_proc!" }
3.times(&named_proc)
