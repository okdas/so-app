class QuestionsListSerializer < ActiveModel::Serializer
  attributes :id, :title, :body, :updated_at, :created_at, :user_id, :answers_count, :votes

  def answers_count
    object.answers.count
  end

  def votes
    object.get_upvotes.size - object.get_downvotes.size
  end
end