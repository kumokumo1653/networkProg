require './LeapYear'
require './cal'

lep = Leap.new(2020)
puts lep.check
ca = Cal.new(2020)
cal = ca.createCalYear
cal.each do |i|
    i.each do |a|
        pp a
    end
end
