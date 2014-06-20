class AnswersController < ApplicationController
  before_action :authenticate_user!, only: [:create, :edit]
  before_action :load_answer, only: [:edit, :update]
  before_action :answer_belongs_to_current_user, only: [:edit, :update]

  load_and_authorize_resource

  def create
    @question = Question.find(params[:question_id])
    @answer = @question.answers.build(answer_params)
    @answer.user = current_user
    @answer.attachments.each do |attachment|
      attachment.user = current_user
    end
    @answer.save
    # redirect_to question_path(@answer.question)
  end

  def edit
  end

  def update
    @answer.update(answer_params)
  end

  private

  def load_answer
    @answer = Answer.find(params[:id])
  end

  def answer_params
    params.require(:answer).permit(:body, attachments_attributes: [:id, :_destroy, :attachment])
  end

  def answer_belongs_to_current_user
    unless current_user == @answer.user
      flash[:notice] = 'This is not your answer.'
      redirect_to root_path
    end
  end
end
