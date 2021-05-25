class EventsController < ApplicationController
  before_action :authenticate_user!

  def index
    @events = event_index_conditional
  end

  def event_index_conditional
    if params[:time_filter].nil? || params[:time_filter] == 'all'
      Event.all
    elsif params[:time_filter] == 'future'
      Event.upcoming_events
    elsif params[:time_filter] == 'past'
      Event.past_events
    end
  end

  def show_upcoming
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
      flash[:success] = 'Event Created!'
      redirect_to event_path(@event.id)
    else
      flash.now[:warning] = 'Error, all fields need to be filled'
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
      flash[:success] = 'Event Updated!'
      redirect_to event_path(@event.id)
    else
      flash.now[:warning] = 'Event Updated!'
      render :edit
    end
  end

  private

  def event_params
    params.require(:event).permit(:title, :description, :tpeople, :frequency, :eventtype, :eventcategory, :date,
                                  :location)
  end
end
