class EventsController < ApplicationController
  before_action :authenticate_user!

  def index
    if params[:user_id].nil?
      @events = event_index_conditional(nil)
    else
      @user = User.find(params[:user_id])
      @events = event_index_conditional(@user)
    end
  end

  def event_index_conditional(user)
    if params[:time_filter].nil? || params[:time_filter] == 'all'
      return Event.all if user.nil?

      @user.events
    elsif params[:time_filter] == 'future'
      show_upcoming(user)
    elsif params[:time_filter] == 'past'
      show_past(user)
    end
  end

  def show_upcoming(user = nil)
    @upcoming_events = if user.nil?
                         Event.upcoming_events
                       else
                         user.events.upcoming_events
                       end
    @upcoming_events
  end

  def show_past(user = nil)
    @past_events = if user.nil?
                     Event.past_events
                   else
                     user.events.past_events
                   end
    @past_events
  end

  def new
    @user = User.find(session[:user_id])
    @event = @user.events.new
  end

  def create
    @user = User.find(session[:user_id])
    @event = @user.events.new(event_params)
    if @event.save
      flash.alert = 'Event created succesfuly!'
      redirect_to event_path(@event.id)
    else
      flash.alert = 'Error unable to create the event'
      render :new
    end
  end

  def show
    @event = Event.find(params[:id])
  end

  def destroy
    @user = User.find(session[:user_id])
    @event = @user.events.find(params[:id])
    @event.destroy

    redirect_to root_path
  end

  def edit
    @user = User.find(session[:user_id])
    @event = @user.events.find(params[:id])
  end

  def update
    @user = User.find(session[:user_id])
    @event = @user.events.find(params[:id])
    if @event.update(event_params)
      redirect_to event_path(@event.id)
    else
      render :edit
    end
  end

  private

  def event_params
    params.require(:event).permit(:title, :description, :tpeople, :frequency, :eventtype, :eventcategory, :date,
                                  :location)
  end
end
