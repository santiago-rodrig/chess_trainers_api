class Trainer < ApplicationRecord
  belongs_to :expertise
  scope :buffer, -> (number) { order('events_won DESC').offset(number * 3).first(3) }
end
