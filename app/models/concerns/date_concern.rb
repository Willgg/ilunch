module DateConcern
  extend ActiveSupport::Concern

  class_methods do

    def next_active_days(number)
      week = []
      date = Date.today
      until week.count == number do
        week << date if ( date.wday != 6 && date.wday != 0 )
        date += 1.day
      end
      return week.first(number)
    end

  end
end
