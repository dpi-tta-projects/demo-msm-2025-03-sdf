class SearchController < ApplicationController

  def index
    @query = params[:query]
    @results = PgSearch.multisearch(@query)

    render "search/index"
  end
end
