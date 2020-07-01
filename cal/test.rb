require './LeapYear'
require './cal'

lep = Leap.new(2020)
puts lep.check
ca = Cal.new(2020,7)
cal = ca.createCal
pp cal
info = ca.createInfo(cal,today = if (true)
                                     1
                                else 0
                                end)
pp info
