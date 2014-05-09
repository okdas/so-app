class Question < ActiveRecord::Base
  belongs_to :user
  has_many :answers

  validates :title, presence: true, uniqueness: true, length: {
      within: 10..40,
      too_short: 'Title must be more than 10 characters',
      too_long: 'Title cannot be more than 40 characters'
  }

  validates :body, presence: true, length: {
      within: 50..5000,
      too_short: 'Question must be more than 50 characters',
      too_long: 'Question cannot be more than 5000 characters'
  }
end
