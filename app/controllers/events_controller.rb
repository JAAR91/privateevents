class EventsController < ApplicationController
  before_action :authenticate_user!

  def index
    if params[:user_id].nil?
      case params[:time_filter]
      when nil
        @events = Event.all
      when 'all'
        @events = Event.all
      when 'future'
        @events = show_upcoming
      when 'past'
        @events = show_past
      end
    else
      @user = User.find(params[:user_id])
      case params[:time_filter]
      when nil
        @events = @user.events
      when 'all'
        @events = @user.events
      when 'future'
        @events = show_upcoming(@user)
      when 'past'
        @events = show_past(@user)
      end
    end
  end

  def show_upcoming(user = nil)
    if user.nil?
      @upcoming_events = Event.upcoming_events
    else
      @upcoming_events = user.events.upcoming_events
    end
    @upcoming_events
  end

  def show_past(user = nil)
    if user.nil?
      @past_events = Event.past_events
    else
      @past_events = user.events.past_events
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
      redirect_to root_path
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
