class EventsController < ApplicationController
  before_action :set_event, only: [:show, :update, :destroy, :edit]

  def index
    @events = Event.order(created_at: :desc).paginate(page: params[:page],
                                                  per_page: 5)
  end

  def show
  end

  def new
    @event = Event.new
  end

  def create
    @event = current_user.events.new(event_params)
    if @event.save
      flash[:success] = "Event was successfuly saved"
      redirect_to events_path
    else
      flash[:error] = "Something was wrong"
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
      flash[:error] = "Something was wrong"
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
