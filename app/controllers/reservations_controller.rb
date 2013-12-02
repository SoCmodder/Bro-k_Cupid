class ReservationsController < ApplicationController
  def index
    @reservations = Reservation.all
  end

  def show
    @reservation = Reservation.find(params[:id])
  end

  def new
    @reservation = Reservation.new
  end

  def create
    @event = Event.find(params[:event_id])
    @reservation = @event.reservations.build(:attendee_id => params[:attendee_id])
    if @reservation.save
      redirect_to @event, :success => "Dope event, bro!"
    end
  end

  def edit
    @reservation = Reservation.find(params[:id])
  end

  def update
    @reservation = Reservation.find(params[:id])
    if @reservation.update_attributes(params[:reservation])
      redirect_to @reservation, :notice => "Dat Update, yo!"
    else
      render :action => 'edit'
    end
  end

  def destroy
    @reservation = Reservation.find(params[:id])
    @reservation.destroy
    redirect_to reservations_url, :notice => "Yeah, that event was wack."
  end
end
