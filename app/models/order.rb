class Order < ApplicationRecord
  enum status: [ :ordered, :payed, :canceled ]
  after_initialize :set_status

  belongs_to :user
  belongs_to :company
  has_many :line_items, dependent: :destroy

  validates :user_id, presence: true
  validates :company_id, presence: true
  validates :status, inclusion: { in: statuses }

  def set_status
    self.status = 0 if self.status.nil?
  end
end
