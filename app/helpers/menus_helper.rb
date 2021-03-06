module MenusHelper
  def next_days(number)
    week = []
    date = Date.current
    until week.count == number do
      week << date if ( date.wday != 6 && date.wday != 0 )
      date += 1.day
    end
    return week.first(number)
  end
end
