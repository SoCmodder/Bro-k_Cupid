class Reservation < ActiveRecord::Base
  belongs_to :event
  belongs_to :attendee, :class_name => "User"

  attr_accessible :event_id, :attendee_id
end
