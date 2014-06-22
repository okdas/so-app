class QuestionsController < InheritedResources::Base
  before_action :authenticate_user!, only: [:new, :create, :edit, :update]
  before_action :build_answer, only: :show
  before_action :build_attachments, only: :new
  before_action :question_belongs_to_current_user, only: [:edit, :update]
  impressionist actions: [:show], unique: [:session_hash]

  layout 'application', only: [ :index, :edit, :new ]

  def tagged
    if params[:tag].present?
      @questions = Question.tagged_with(params[:tag])
    else
      redirect_to tags_path
    end
  end

  protected

  def create_resource(object)
    object.user = current_user
    object.attachments.each do |attachment|
      attachment.user = current_user
    end
    super
  end

 # TODO: switch to cancan.
  def question_belongs_to_current_user
    unless current_user == resource.user
      flash[:notice] = 'This is not your question.'
      redirect_to root_path
    end
  end

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
