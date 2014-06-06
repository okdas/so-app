class Answer < ActiveRecord::Base
  belongs_to :question
  belongs_to :user
  has_many :comments, as: :commentable
  has_many :attachments, as: :attachmentable

  acts_as_votable

  accepts_nested_attributes_for :attachments, allow_destroy: true, reject_if: :all_blank

  validates :body, presence: true
end
