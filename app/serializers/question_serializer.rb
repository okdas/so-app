class QuestionSerializer < ActiveModel::Serializer
  attributes :id, :title, :body, :updated_at, :created_at, :user_id
  has_many :answers
  has_many :attachments
end