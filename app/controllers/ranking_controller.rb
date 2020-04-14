class RankingController < ApplicationController
  before_action :logged_in_user
  
  def index
    @users = User.where('highest_rate IS NOT NULL').order(highest_rate: "DESC")
  end
end