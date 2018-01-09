class EventsController < ApplicationController
  before_action :set_event, only: [:show, :update, :destroy, :edit]

  def index
    @events = Event.all.order(created_at: :desc)
  end

  def show
  end

  def new
    @event = Event.new
  end

  def create
    @event = current_user.events.create(event_params)
    if @event
      flash[:success] = "Event was successfuly saved"
      redirect_to events_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @event.update(event_params)
      flash[:success] = "Event was successfuly updated"
      redirect_to @event
    else
      render :edit
    end
  end

  def destroy
    @event.destroy
    flash[:success] = "Event was successfuly deleted"
    redirect_to events_path
  end

  private
    def set_event
      @event = Event.find(params[:id])
    end

    def event_params
      params.require(:event).permit(:description, :title, :user_id, :start_time,
                                   :end_time)
    end
end
