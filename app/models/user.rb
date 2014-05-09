class User < ActiveRecord::Base
  has_many :questions

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates_presence_of :name

  validates_length_of :name, in: 2..20,
                      too_short: 'Name must be more than 2 characters',
                      too_long: 'Name cannot be more than 20 characters'
end
