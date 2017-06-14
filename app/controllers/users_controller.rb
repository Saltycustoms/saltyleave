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

  def edit
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to @user
    else
      render 'new'
    end
  end

  def update
    @user = User.find(params[:id])

    if @user.update(user_params)
      @user.save
      redirect_to @user
    else
      render 'edit'
    end
  end

  private
    def user_params
      params.require(:user).permit(:name, :department, :region, :email, :password, roles: [])
    end
end
