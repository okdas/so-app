class SearchController < ApplicationController
  def index
    @search = ThinkingSphinx.search(params[:search])
  end

  private

  def search_params
    params.require(:search).permit(:search)
  end
end
