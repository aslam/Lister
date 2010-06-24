require 'rubygems'
require 'fastercsv'

if ARGV.size != 1
  puts "Need <inputfile> as argument."
  exit(1)
end
inputfile = ARGV[0]

FasterCSV.foreach(inputfile) do |r|
  puts "Creating #{r[0]}"
  state_name  = r[0]

	state       = State.create({ :name => state_name })

	puts "Created #{r[0]}"
end

