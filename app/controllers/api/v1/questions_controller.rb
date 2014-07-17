class Api::V1::QuestionsController < Api::V1::BaseController
  respond_to :json

  def index
    respond_with Question.all.to_json()
  end
end