class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :orders, dependent: :destroy
  has_many :line_items, through: :orders
  belongs_to :company
  has_attachment :photo

  validates :company_id, presence: true, allow_blank: false
  validates :email, presence: true, allow_blank: false
  validates :first_name, presence: true, allow_blank: false
  validates :last_name, presence: true, allow_blank: false
  # validates :street, presence: true, allow_blank: false
  # validates :post_code, presence: true, allow_blank: false
  # validates :city, presence: true, allow_blank: false

  def full_name
    first_name + ' ' + last_name
  end
end
