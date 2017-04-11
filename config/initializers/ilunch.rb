module Ilunch

  TVA = 0.1

  def self.next_active_days(number, start_date=nil)
    week = []
    date = start_date ? start_date : Date.today
    until week.count == number do
      week << date if ( date.wday != 6 && date.wday != 0 )
      date += 1.day
    end
    return week.first(number)
  end

  def self.open?(date=nil)
    # return true if ENV['RAILS_ENV'] != 'production'
    # return true if ENV['HOST'] == 'http://ilunch-staging.herokuapp.com'

    # DateTime.current <= DateTime.current.beginning_of_day + 12.hours &&
    # ( date == Date.current if date.nil? )
    true
  end

  def self.closed?(date=nil)
    !open?(date)
  end
end
