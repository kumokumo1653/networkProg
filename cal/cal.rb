require './LeapYear'
class Cal
    def initialize(y,m = 0)
        @y = y
        @m = m 
    end


    def wantDay
        leap = Leap.new(@y) 
        # 日数指定
        if @m == 2
            if leap.check == true
                return  29
            else 
                return 28
            end
        else 
            case @m
            when 1,3,5,7,8,10,12 then
                return 31
            when 4,6,9,11 then
                return 30
            end
        end
        return 0
    end

    def createCalYear
        cal = []
        for i in 1..12 do
           @m = i
           cal.push(createCal)
        end
        return cal
    end
            
    def createCal
        @d = wantDay
        if @m <= 2
            h = (@y - 1) + ((@y - 1)/4).to_i - ((@y - 1)/100).to_i + ((@y - 1)/400).to_i + ((13 * (@m + 12) + 8)/5).to_i + 1
        else
            h = @y + (@y/4).to_i - (@y/100).to_i + (@y/400).to_i + ((13 * @m + 8)/5).to_i + 1
        end
        h = h % 7
        row = ((@d + h + 7 - 1) / 7).to_i
        cal = Array.new(row).map{Array.new(7," ")}

        cnt = h
            
        for a in 1..@d do
            cal[(cnt / 7).to_i][cnt % 7] = a.to_s
            cnt = cnt + 1
        end
        return cal
    end
end

