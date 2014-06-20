class CommentsController < ApplicationController
  before_action :authenticate_user!, only: [:create, :new]
  before_action :commentable_object, only: [:create, :new]

  load_and_authorize_resource

  def new
    @comment = Comment.new
  end

  def create
    @comment = Comment.new(comment_params)
    @comment.user = current_user
    @comment.commentable = @comment_object
    @comment.save
  end

  private

  def commentable_object
    @comment_object = Question.find(params[:question_id]) if params[:question_id]
    @comment_object = Answer.find(params[:answer_id]) if params[:answer_id]
  end

  def comment_params
    params.require(:comment).permit(:body)
  end
end
