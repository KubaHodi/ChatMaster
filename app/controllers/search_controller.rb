class SearchController < ApplicationController
  def index
    @query = User.ransack(params[:q])
    @users = @query.result(distinct: true)
  end
end
