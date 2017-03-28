module MenusHelper
  def day_of_week
    week = []
    date = Date.today.beginning_of_week
    Date::DAYNAMES.first(5).each do |d|
      week << date
      date += 1.day
    end
    return week
  end
end
