class Trainer < ApplicationRecord
  belongs_to :expertise
  has_many :appointments
  scope :buffer, -> (number) { order('events_won DESC').offset(number * 3).first(3) }

  def hashed_email
    Digest::MD5.hexdigest(self.email)
  end
end
