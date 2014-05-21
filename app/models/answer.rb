class Answer < ActiveRecord::Base
  belongs_to :question
  belongs_to :user
  has_many :comments, as: :commentable

  validates :body, presence: true
end
