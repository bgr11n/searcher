class LanguageDataController < ApplicationController
  def index; end

  def search
    result = LanguageData::SearchOrganizer.call(search_params)
    render json: result.response
  end

  private

  def search_params
    params.permit(:text_query)
  end
end
