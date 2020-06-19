require './LeapYear'
require './cal'

lep = Leap.new(2020)
puts lep.check
ca = Cal.new(2020,2)
pp ca.createCal
