class Event < ApplicationRecord
  belongs_to :user
  def new
    @event = Event.new(current_user.id,@email,@nav,@signin,@signout,@like,@comment)
    @event.save
  end
  def email
    @email
  end
  def nav
    @nav
  end
  def signin
    @signin
  end
  def signout
    @signout
  end
  def like
    @like
  end
  def comment
    @comment
  end
end
