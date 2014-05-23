class QuestionsController < ApplicationController
  before_action :authenticate_user!, only: [ :new, :create, :edit, :update ]
  before_action :load_question, only: [:show, :edit, :update, :destroy]
  before_action :question_belongs_to_current_user, only: [ :edit, :update ]

  layout 'questions'

  def index
    @questions = Question.all
  end

  def new
    @question = Question.new
    @question.attachments.build
  end

  def show
    @answer = @question.answers.build

  end

  def create
    @question = Question.new(question_params)
    @question.user = current_user
    @question.attachments.each do |attachment|
      attachment.user = current_user
    end
    if @question.save
      flash[:notice] = 'Your question successfully created.'
      redirect_to @question
    else
      render :new
    end
  end

  def update
    if @question.update(question_params)
      flash[:notice] = 'Your question successfully edited.'
      redirect_to @question
    else
      render :edit
    end
  end

  def destroy
    @question.destroy
    redirect_to question_path
  end

  private

  def question_belongs_to_current_user
    unless current_user == @question.user
      flash[:notice] = 'This is not your question.'
      redirect_to root_path
    end
  end

  def load_question
    @question = Question.find(params[:id])
  end

  def question_params
    params.require(:question).permit(:title, :body, attachments_attributes: [:id, :_destroy, :attachment])
  end
end
