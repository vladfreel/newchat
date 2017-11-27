# event
class Event < ApplicationRecord
  belongs_to :user
  def to_s
    self.id
  end
end
