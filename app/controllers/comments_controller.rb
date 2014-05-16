class CommentsController < ApplicationController
  before_action :authenticate_user!, only: [ :create, :new ]

  def new
    @comment = Comment.new
    @answer_id = params[:answer_id]
    render 'comments/new'
  end

  def create
    @answer = Answer.find(params[:answer_id])
    @comment = @answer.comments.build(comment_params)
    @comment.user = current_user
    @comment.save
    @answer_id = @comment.answer.id
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end
end
