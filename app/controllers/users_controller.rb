class UsersController < ApplicationController
  def index
    @q = User.ransack(params[:q])

    if current_user.is_director?
      @users = @q.result
    else
      @users = @q.result.where(department: current_user.department)
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to @user
    else
      render 'new'
    end
  end

  private
    def user_params
      params.require(:user).permit(:name, :email, :department, :password)
    end
end
