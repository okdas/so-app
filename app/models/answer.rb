class Answer < ActiveRecord::Base
  belongs_to :question
  belongs_to :user
  has_many :comments, as: :commentable
  has_many :attachments, as: :attachmentable

  accepts_nested_attributes_for :attachments, allow_destroy: true

  validates :body, presence: true
end
