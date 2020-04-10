class UsersController < ApplicationController
  skip_before_action :verify_authenticity_token

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "ユーザー作成が正常に完了しました"
      redirect_to wordbooks_path
    else
      render 'new'
    end
  end

  def api
    user = User.find(current_user.id)
    answer_count = params[:answer_count].to_i
    correct_answer_rate = (answer_count / 50.to_f) * 100
    if user.highest_rate.nil? || correct_answer_rate > user.highest_rate
      user.highest_rate = correct_answer_rate
      user.save :validate => false
    end
  end

  def user_params
    params.require(:user).permit(:name, :password, :password_confirmation)
  end
end
