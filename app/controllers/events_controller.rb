class EventsController < ApplicationController
  before_action :authenticate_user!

  def index
    if params[:user_id].nil?
      case params[:time_filter]
      when nil
        @events = Event.all.order('date DESC')
      when 'all'
        @events = Event.all.order('date DESC')
      when 'future'
        @events = Event.select { |item| !item.date.nil? && item.date > Time.now }.sort
      when 'past'
        @events = Event.select { |item| !item.date.nil? && item.date < Time.now }.sort
      end
    else
      @user = User.find(params[:user_id])
      @events = @user.events
      case params[:time_filter]
      when nil
        @events = @user.events.order('date DESC')
      when 'all'
        @events = @user.events.order('date DESC')
      when 'future'
        @events = @user.events.select { |item| !item.date.nil? && item.date > Time.now }.sort
      when 'past'
        @events = @user.events.select { |item| !item.date.nil? && item.date < Time.now }.sort
      end
    end
    #@events.order('date DESC') if @events.count > 1
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
