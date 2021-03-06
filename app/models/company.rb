class Company < ApplicationRecord
  has_many :orders, through: :users
  has_many :users

  TIMESLOT = ['12h-12h30', '12h15-12h45', '12h30-13h', '12h45-13h15', '13h-13h30', '13h15-13h45', '13h30-14h']

  validates :delivery_time, presence: true, inclusion: { in: TIMESLOT,
    message: "%{value} is not a valid timeslot" }
  validates :name, presence: true, uniqueness: { case_sensitive: false }

  def full_address
    self.name + ', ' + self.street + ' ' + self.city
  end

  def address
    self.street + ', ' + self.city
  end
end
