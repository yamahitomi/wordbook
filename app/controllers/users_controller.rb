class UsersController < ApplicationController
  
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

  def show
  end

  def user_params
    params.require(:user).permit(:name, :password, :password_confirmation)
  end
end
