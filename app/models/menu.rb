class Menu < ApplicationRecord
  has_many :line_items
  has_attachment :photo

  monetize :price_cents

  validates :title, presence: true
end
