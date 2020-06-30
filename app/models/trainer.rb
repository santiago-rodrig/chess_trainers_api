class Trainer < ApplicationRecord
  belongs_to :expertise
  has_many :appointments

  scope :filtered, -> (
    name_filter,
    expertFilter,
    intermediateFilter,
    amateurFilter
  ) do
    data = where("name LIKE ?", "%#{name_filter}%")
    expert = Expertise.find_by(name: 'expert')
    intermediate = Expertise.find_by(name: 'intermediate')
    amateur = Expertise.find_by(name: 'amateur')

    case expertFilter
    when '1'
      case intermediateFilter
      when '1'
        case amateurFilter
        when '1'
          # do nothing
        when '0'
          data = data.where.not(expertise: amateur)
        end
      when '0'
        case amateurFilter
        when '1'
          data = data.where.not(expertise: intermediate)
        when '0'
          data = data.where(expertise: expert)
        end
      end
    when '0'
      case intermediateFilter
      when '1'
        case amateurFilter
        when '1'
          data = data.where.not(expertise: expert)
        when '0'
          data = data.where(expertise: intermediate)
        end
      when '0'
        case amateurFilter
        when '1'
          data = data.where(expertise: amateur)
        when '0'
          data = data.where(id: nil)
        end
      end
    end

    data.order('events_won DESC')
  end

  scope :buffer, -> (
    number,
    name_filter,
    expertFilter,
    intermediateFilter,
    amateurFilter
  ) do
      filtered(
        name_filter,
        expertFilter,
        intermediateFilter,
        amateurFilter
      ).offset(number * 3).first(3)
  end

  def hashed_email
    Digest::MD5.hexdigest(self.email)
  end
end
