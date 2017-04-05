class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  GENDERS = ['male', 'female']
  enum role: [:client, :chef, :admin]
  has_many :orders, dependent: :destroy
  has_many :line_items, through: :orders
  belongs_to :company
  has_attachment :photo

  validates :company_id, presence: true, allow_blank: false
  validates :email, presence: true, allow_blank: false
  validates :first_name, presence: true, allow_blank: false
  validates :last_name, presence: true, allow_blank: false
  validates :gender, presence: true, inclusion: { in: GENDERS }
  validates :phone, presence: true

  after_commit :send_welcome_email, on: :create

  def full_name
    first_name + ' ' + last_name
  end

  private

  def send_welcome_email
    UserMailer.welcome(self).deliver_now
  end
end
