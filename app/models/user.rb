class User < ActiveRecord::Base
  has_many :questions
  has_many :answers
  has_many :comments

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :name, presence: true, length: {
      within: 2..20,
      too_short: 'Name must be more than 2 characters',
      too_long: 'Name cannot be more than 20 characters'
  }
end
