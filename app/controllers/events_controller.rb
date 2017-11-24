# this controller is responsible for the operation with events
class EventsController < ApplicationController
  def new
    @event = Event.new
  end

  def create
    @event = Event.new(event_params)
    @event.save
  end

  private

  def event_params
    params.require(:event).permit(
      :user,
      :signin,
      :signout,
      :like,
      :comment,
      :origurl,
      :dtnow
    )
  end
end
