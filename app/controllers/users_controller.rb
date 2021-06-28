class UsersController < ApplicationController
  before_action :sign_in_required, only: [:show, :edit, :update, :profile]
  

  def index
    @users = User.all
    @q = Room.ransack(search_params)
    @rooms = @q.result(distinct: true)
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    if params[:image]
      @user.image = "#{@user.id}.jpg"
      image = params[:image]
      File.binwrite("/#{@user.image}", image.read)
    end
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "ユーザー情報を更新しました"
      redirect_to profile_user_path
    else
      flash[:alert] = "更新できませんでした"
      render "profile"
    end
  end

  def profile
    @user = User.find(params[:id])
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password, :introduction, :image)
    end
  
    def search_params
      params.permit(:address_cont, :room_name_or_room_introduction_or_address_cont)
    end
end
