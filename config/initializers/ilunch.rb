module Ilunch

  def self.next_active_days(number)
    week = []
    date = Date.today
    until week.count == number do
      week << date if ( date.wday != 6 && date.wday != 0 )
      date += 1.day
    end
    return week.first(number)
  end

  def self.open?
    # true
    DateTime.current <= Date.today.to_datetime + 12.hours
  end

  def self.closed?
    !open?
  end
end
