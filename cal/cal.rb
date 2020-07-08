require './LeapYear'
require './addEvent'
require 'date'
class Cal
    def initialize(y,m = 0)
        @y = y
        @m = m 
    end

    def setYear(y)
        @y = y
    end
    def setMonth(m)
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

    def createInfo(c,today ,info = nil)
        transFalg = false;
        cal = Marshal.load(Marshal.dump(c))
        title = Marshal.load(Marshal.dump(c))
        if(info == nil)
            updater = EventUpdater.new(@y)
            info = updater.update
        end
        events = []
        info.each do |a|
            if(a.month == @m)
                events.push(a)
            end
        end
        
        for i in 0..c.size - 1 do
            for j in 0..6 do
                cal[i][j] = case j
                            when 0 then "Sun"
                            when 1 then "Mon"
                            when 2 then "Tue"
                            when 3 then "Wed"
                            when 4 then "Thu"
                            when 5 then "Fri"
                            when 6 then "Sat"
                            end
                if(c[i][j] != " ")
                    title[i][j] = "なにもない日"
                end
                #現在日の判定
                if(today != 0)
                    if(c[i][j].to_i == today)
                        cal[i][j] += " today"
                        title[i][j] = "今日"
                    end
                end
                #イベント追加
                events.each do |a|
                    if(a.day == c[i][j].to_i)
                        if(cal[i][j][0,3] == "Sun" && a.category == "holiday")
                            transFalg = true;
                            cal[i][j] += " "+a.category
                        else
                            cal[i][j] += " "+a.category
                        end
                        title[i][j] = a.name
                    end
                end
                #振替判定
                if transFalg && title[i][j] == "なにもない日"
                    transFalg = false;
                    cal[i][j] += " transfer"
                    title[i][j] = "振替休日"
                end
            end
        end
        return cal,title
    end

    def createInfoYear(c,tomonth,today)
        title = []
        cal = []
        updater = EventUpdater.new(@y)
        info = updater.update
        for i in 0..11 do
            @m = i + 1
            if(i+1 == tomonth)
                i,t = createInfo(c[i],today,info)
            else
                i,t = createInfo(c[i],0,info)
            end
            title.push(t)
            cal.push(i)
        end
        return cal,title
    end
    
    def lastMonth
        if(@m == 1)
            return @y - 1,12
        else
            return @y,@m - 1
        end
    end

    def nextMonth
        if(@m == 12)
            return @y + 1,1
        else 
            return @y, @m + 1
        end
    end
    def nowMonth
        date = Date.today
        return date.year,date.month
    end

    def searchNumOfWeek(week, num)
        cnt = 0
        cal = createCal
        for i in 0..cal.size do
            if(cal[i][week] != " ")
                cnt += 1
                if(cnt == num)
                    return cal[i][week]
                end
            end
        end
        return -1
    end
end

