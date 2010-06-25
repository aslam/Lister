require 'rubygems'
require 'fastercsv'

if ARGV.size != 2
    puts "Need both STATENAME and CITIES file as argument."
    exit(1)
end

state_name  = ARGV[0]
inputfile   = ARGV[1]

puts "Finding state.."
state = State.find_by_name(state_name)

unless state.nil?
    FasterCSV.foreach(inputfile) do |r|
        city_name = r[0]
        unless city_name.blank?
            puts "creating city #{r[0]}"
            City.create({ :name => r[0], :state => state })
        end
    end
else
    puts "Couldn't find State #{state_name}"
    exit(1)
end

