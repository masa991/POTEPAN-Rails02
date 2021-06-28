class ReservationsController < ApplicationController
  before_action :authenticate_user! #ログイン済ユーザーのみにアクセスを許可する
  before_action :reservation_params, only: [:confirm, :create]
  
  def index
    @reservations = Reservation.includes(:user).where(user_id: current_user.id)
    @rooms = Room.all
  end
  
  def confirm
    @room = Room.find(params[:room_id])
    @reservation = Reservation.new(reservation_params)
    if @reservation.valid?
      @reservation.total_fee = "#{@reservation.room.fee * @reservation.number_of_people * (@reservation.end_date - @reservation.start_date).to_i}" 
    else
      render 'rooms/show'
    end
  end

  def create
    @reservation = current_user.reservations.new(reservation_params)
    respond_to do |format|
      if params[:back]
        format.html { render room_path }
      elsif @reservation.save
        format.html { redirect_to @reservation, notice: "予約を確定しました。"}
        flash[:notice] = "予約を確定しました"
      else
        format.html { render :confirm }
      end
    end
  end

  def show
    @reservation = Reservation.find(params[:id])
    @room = Room.find_by(params[:room_id])
    @user = User.find_by(params[:user_id])
  end

  private
    def reservation_params
      params.require(:reservation).permit(:start_date, :end_date, :number_of_people, :total_fee, :user_id, :room_id)
    end
end
