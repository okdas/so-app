class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates_presence_of :name

  validates_length_of :name, in: 2..20,
                      too_short: 'Name must be more than 2 characters',
                      too_long: 'Name cannot be more than 20 characters'

  has_many :questions
end
