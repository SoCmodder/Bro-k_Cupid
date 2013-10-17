class EventsController < ApplicationController
    def show
    end

    def index
        @events = Event.paginate(page: params[:page])
    end
    
    def new
        @event = Event.new
    end

    def create
        @event = current_user.events.build()
        if @event.save
            flash[:notice] = "Created Event"
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

