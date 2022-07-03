class UsersController < ApplicationController
  
  # def create
  # @user = User.new(user_params)
  # @user.save
  # redirect_to user_path(@user), notice: 'Welcome! You have signed up successfully.'
  # end
  
  def index
    @book = Book.new
    @users = User.all
  end
  
  def show
    @book = Book.new
    @user = User.find(params[:id])
    @books = @user.books  #.page(params[:page])
  end
  
  def edit
    @user = User.find(params[:id])
    if @user.id == current_user.id
      render :edit                          #edit_user_path(@user)
    else
      # @book = Book.new
      @user = User.find(params[:id])
      @books = @user.books #page(params[:page])
      redirect_to user_path(current_user)
    end
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "You have updated user successfully."
      redirect_to user_path(@user)
    else
      render :edit
    end
  end
  
  private
  
  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end
  
end
