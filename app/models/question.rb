class Question < ActiveRecord::Base

  validates_presence_of :title, :body

  validates_uniqueness_of :title, message: 'This question is already exists.'

  validates_length_of :title, in: 10..40,
                      too_short: 'Title must be more than 10 characters',
                      too_long: 'Title cannot be more than 40 characters'

  validates_length_of :body, in: 50..5000,
                      too_short: 'Question must be more than 50 characters',
                      too_long: 'Question cannot be more than 5000 characters'

end
