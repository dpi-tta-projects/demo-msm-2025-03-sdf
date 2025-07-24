class SearchController < ApplicationController

  def index
    @query = params[:query]
    @results = PgSearch.multisearch(@query).limit(25)

    respond_to do |format|
      format.js
    end
  end
end
