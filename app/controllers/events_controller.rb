class EventsController < ApplicationController
  def show
    @event = Event.find(params[:id])
    #@attendees = @event.attendees.paginate(page: params[:page])
  end

  def index
    @events = Event.paginate(page: params[:page])
  end

  def new
    @event = Event.new
  end

  def create
    @event = current_user.events.build(params[:event])
    if @event.save
      flash[:success] = "Created Event"
      redirect_to root_url
    else
      flash[:error] = "Unable to create event"
      redirect_to root_url
    end
  end

  def destroy
    @event = current_user.events.find(params[:id])
    @event.destroy
    flash[:notice] = "Removed Event"
    redirect_to current_user
  end


end

