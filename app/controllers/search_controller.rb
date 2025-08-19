class SearchController < ApplicationController
  def index
    @query = User.ransack params[:q]
    if params[:q].present? && params[:q].values.any?(&:present?)
      @user_from_search = @query.result(distinct: true).where.not(id: session[:user_id])
    else
      @user_from_search = User.none
    end
  end
end