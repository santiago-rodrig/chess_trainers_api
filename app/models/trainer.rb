class Trainer < ApplicationRecord
  belongs_to :expertise
  has_many :appointments

  validates :name, presence: true, length: { minimum: 3, maximum: 50 }
  validates :events_won, numericality: { greater_than_or_equal_to: 0 }
  validates :calendar_url, :location_url, format: { with: URI::DEFAULT_PARSER.make_regexp }, uniqueness: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }, uniqueness: true

  scope :filtered, lambda { |name_filter, expert_filter, intermediate_filter, amateur_filter|
    data = where('name LIKE ?', "%#{name_filter}%")
    expert = Expertise.find_by(name: 'expert')
    intermediate = Expertise.find_by(name: 'intermediate')
    amateur = Expertise.find_by(name: 'amateur')
    test_case = expert_filter + intermediate_filter + amateur_filter
    test_case = test_case.to_i(2)

    case test_case
    when 6
      data = data.where.not(expertise: amateur)
    when 5
      data = data.where.not(expertise: intermediate)
    when 4
      data = data.where(expertise: expert)
    when 3
      data = data.where.not(expertise: expert)
    when 2
      data = data.where(expertise: intermediate)
    when 1
      data = data.where(expertise: amateur)
    when 0
      data = data.where(id: nil)
    end

    data.order('events_won DESC')
  }

  scope :buffer, lambda { |number, name_filter, expert_filter, intermediate_filter, amateur_filter|
    filtered(
      name_filter,
      expert_filter,
      intermediate_filter,
      amateur_filter
    ).offset(number * 3).first(3)
  }

  def hashed_email
    Digest::MD5.hexdigest(email)
  end
end
