class Trainer < ApplicationRecord
  belongs_to :expertise
  has_many :appointments

  scope :filtered, -> (
    name_filter,
    expertFilter,
    intermediateFilter
  ) do
    data = where("name LIKE ?", "%#{name_filter}%")

    case expertFilter
    when '1'
      case intermediateFilter
      when '1'
        data = data.where(
          expertise: Expertise.find_by(name: 'expert')
        ).or(data.where(
          expertise: Expertise.find_by(name: 'intermediate')
        ))
      when '0'
        data = data.where(
          expertise: Expertise.find_by(name: 'expert')
        ).or(data.where.not(
          expertise: Expertise.find_by(name: 'intermediate')
        ))
      end
    when '0'
      case intermediateFilter
      when '1'
        data = data.where.not(
          expertise: Expertise.find_by(name: 'expert')
        ).or(data.where(
          expertise: Expertise.find_by(name: 'intermediate')
        ))
      when '0'
        data = data.where.not(
          expertise: Expertise.find_by(name: 'expert')
        ).or(data.where.not(
          expertise: Expertise.find_by(name: 'intermediate')
        ))
      end
    end

    data.order('events_won DESC')
  end

  scope :buffer, -> (
    number,
    name_filter,
    expertFilter,
    intermediateFilter
  ) do
      filtered(
        name_filter,
        expertFilter,
        intermediateFilter
      ).offset(number * 3).first(3)
  end

  def hashed_email
    Digest::MD5.hexdigest(self.email)
  end
end
