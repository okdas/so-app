class Api::V1::QuestionsController < Api::V1::BaseController
  respond_to :json

  def index
    respond_with collection, each_serializer: QuestionsListSerializer, meta: {timestamp: collection.last.created_at}
  end
end