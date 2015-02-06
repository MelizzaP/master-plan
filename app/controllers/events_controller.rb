class EventsController < ApplicationController
  # remove this when Devise is set up.
  skip_before_filter  :verify_authenticity_token
  # remove this when Devise is set up.
  def index
    #returns all events from eventbrite API, need to change to pull from her endpoint
    @eventList = Event.retrieve_all_events params
    render json: @eventList, status: 200
  end
  def create
    #takes new event from API input
    @newEvent = Event.new event_params
    @newEvent.save
    respond_to do |format|
      format.json { render :json => {:event => @newEvent} }
    end
    #pushes to EventItinerary
    @newItin = EventItinerary.new itin_params
    @newItin.save
    respond_to do |format|
      format.json { render :json =>{:event_itineraries => @newItin}}
    end
  end
  private
  def itin_params
    params.require(:event_itineraries).permit(:itinerary_id)
  end
  def event_params    
    params.require(:event).permit(:name, :event_type, :location, :utc_start, :utc_end, :description, :lat, :long, :event_url,:attendees,:cost,:source,:date_start,:date_end,:time_start,:time_end,:venue)
  end
end
