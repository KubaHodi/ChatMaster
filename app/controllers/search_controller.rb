class SearchController < ApplicationController
  def index
    @query = User.ransack(params[:q])
    @users = @query.result(distinct: true).where.not(id: session[:user_id])
  end
end
