class Trainer < ApplicationRecord
  belongs_to :expertise
  has_many :appointments

  scope :filtered, -> (name_filter) do
    where("name LIKE ?", "%#{name_filter}%")
  end

  scope :buffer, -> (number, name_filter) do
      filtered(name_filter)
        .order('events_won DESC')
        .offset(number * 3).first(3)
  end

  def hashed_email
    Digest::MD5.hexdigest(self.email)
  end
end
