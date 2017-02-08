class Order < ApplicationRecord
  belongs_to :user
  belongs_to :company
  has_many :line_items, dependent: :destroy
end
