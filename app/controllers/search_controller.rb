class SearchController < ApplicationController

  def index
    @query = params[:query]
    @results = PgSearch.multisearch(@query)

    respond_to do |format|
      format.html
      format.js
    end
  end
end
