class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "ユーザー作成が正常に完了しました"
      log_in(@user)
      redirect_to wordbooks_path
    else
      render 'new'
    end
  end

  def api
    answer_count = params[:answer_count].to_i
    correct_answer_rate = (answer_count / 50.to_f) * 100
    if current_user.highest_rate.nil? || correct_answer_rate > current_user.highest_rate
      current_user.update(highest_rate: correct_answer_rate)
    end
  end

  def user_params
    params.require(:user).permit(:name, :password, :password_confirmation)
  end
end
