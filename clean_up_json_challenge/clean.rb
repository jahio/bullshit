#!/usr/bin/env ruby
#
# clean.rb - takes JSON files in $PWD/data and loads them, scans for the part
# that says "INVOICE <something> <NUMBER>" and extracts the number from the
# word "INVOICE" (case insensitive) then appends another JSON object into that
# array with the number separated out from the word "invoice".
#
# The (now "clean") version of the JSON data is then output with the same
# filename under the directory $PWD/clean.
#

#
# Declare location of source files and destination files
#
src_dir = File.expand_path("../data", __FILE__)
out_dir = File.expand_path("../clean", __FILE__)

#
# Iterate through files in src_files
#
Dir[src_dir + '/*.json'].each do |fname|
  hsh = JSON.parse(File.read(fname))

  i = hsh.count - 1
  while i != 0
    if hsh[i]["chars"]
      match_on = hsh[i]["chars"]
    else
      match_on = hsh[i][:chars]
    end
      if match_on.match(/invoice(\D+)(\d*)/i)

      #
      # Strip the word "invoice" out
      #
      hsh[i]["chars"].gsub(/invoice(\D+)/i, '')

      #
      # Define the new data structure to insert
      #
      new_hash = {
        "left": hsh[i]["left"],
        "top": hsh[i]["top"],
        "width": hsh[i]["width"],
        "height": hsh[i]["height"],
        "chars": hsh[i]["chars"].gsub(/\D*/, '')
      }

      #
      # Insert the new hash into the array
      #
      hsh.insert(i - 1, new_hash)
    end
    i = i - 1
  end

  #
  # Declare a "payload" tha will be written out to the final file.
  payload = hsh.to_json # will be changed

  #
  # Write out the cleaned data
  #
  File.write(out_dir + fname.gsub(src_dir, ''), payload)
end