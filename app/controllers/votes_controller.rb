class VotesController < ApplicationController
  before_action :authenticate_user!
  before_action :votable_object

  def up
    @vote_object.vote_by voter: current_user, vote: true
    vote_response
  end

  def down
    @vote_object.vote_by voter: current_user, vote: false
    vote_response
  end

  private

  def vote_response
    render json: { vote_size: @vote_object.get_upvotes.size - @vote_object.get_downvotes.size }
  end

  def votable_object
    @vote_object = Question.find(params[:question_id]) if params[:question_id]
    @vote_object = Answer.find(params[:answer_id]) if params[:answer_id]
  end
end
