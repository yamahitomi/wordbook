class RankingController < ApplicationController
  def index
    user = User.new
    @user = User.find(current_user.id)
    @users = User.where('highest_rate IS NOT NULL').order(highest_rate: "DESC")
    @user_correct_answer = user.correct_answer_count(@user)
    @user_ranking = user.get_rank(@user)
  end
end