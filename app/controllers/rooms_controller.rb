class RoomsController < ApplicationController
  def index
    @rooms = Room.includes(:user).where(user_id: current_user.id)
    @users = User.all
  end

  def new
    @room = Room.new
    @user = User.new
  end

  def create
    @room = Room.new(room_params)
    if @room.save
      flash[:notice] = "部屋情報を新規登録しました"
      redirect_to("/rooms/#{@room.id}")
    else
      flash[:alert] = "部屋情報を登録できませんでした"
      render "new"
    end
  end

  def show
    @room = Room.find(params[:id])
    @reservation = Reservation.new
    @user = User.find_by(params[:id])
  end

  def destroy
    @room = Room.find(params[:id])
    @room.destroy
    flash[:notice] = "部屋情報を削除しました"
    redirect_to :rooms
  end

  def search
    @room = Room.find_by(params[:id])
    @q = Room.ransack(search_params)
    @rooms = @q.result(distinct: true)
    @count_display = "検索結果 : #{@rooms.count}件"
  end

  private

    def room_params
      params.require(:room).permit(:room_name, :room_introduction, :fee, :address, :room_image).merge(user_id: current_user.id)
    end

    def search_params
      params.require(:q).permit(:address_cont, :room_name_or_room_introduction_or_address_cont)
    end
end
