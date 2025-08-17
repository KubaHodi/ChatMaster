class SearchController < ApplicationController
  def index
    @query = User.ransack(params[:q])
    @user_from_search = @query.result(distinct: true).where.not(id: session[:user_id])
  end
end