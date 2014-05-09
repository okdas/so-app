class AnswersController < ApplicationController
  # before_action :load_answer
  before_action :authenticate_user!, only: [ :create ]

  def create
    @question = Question.find(params[:question_id])
    @answer = @question.answers.build(answer_params)
    @answer.user = current_user
    # @answer = @question.answers.build(answer_params)
    @answer.save
    redirect_to question_path(@answer.question)
  end

  private

  def load_answer
    @answer = Answer.find(params[:id])
  end

  def answer_params
    params.require(:answer).permit(:body)
  end
end
