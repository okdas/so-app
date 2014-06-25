class AnswersController < InheritedResources::Base
  before_action :authenticate_user!, only: [:create, :edit]

  respond_to :js
  actions :create, :update, :edit

  belongs_to :question

  load_and_authorize_resource

  protected

  def create_resource(object)
    object.user = current_user
    object.attachments.each do |attachment|
      attachment.user = current_user
    end
    super
  end

  def answer_params
    params.require(:answer).permit(:body, attachments_attributes: [:id, :_destroy, :attachment])
  end
end
