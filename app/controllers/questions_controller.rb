class QuestionsController < InheritedResources::Base
  before_action :authenticate_user!, only: [:new, :create, :edit, :update]
  before_action :build_answer, only: :show
  before_action :build_attachments, only: :new
  impressionist actions: [:show], unique: [:session_hash]

  layout 'application', only: [ :index, :edit, :new ]

  def create
    @question = Question.new(question_params)
    @question.user = current_user
    @question.attachments.each do |attachment|
      attachment.user = current_user
    end
    create!
  end

  def tagged
    if params[:tag].present?
      @questions = Question.tagged_with(params[:tag])
    else
      redirect_to tags_path
    end
  end

  protected

  def build_attachments
    build_resource.attachments.build
  end

  def build_answer
    @answer = resource.answers.build if user_signed_in?
    @answer.attachments.build if user_signed_in?
  end

  def question_params
    params.require(:question).permit(:tag_list, :title, :body, attachments_attributes: [:id, :_destroy, :attachment])
  end
end
