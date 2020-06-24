class User < ApplicationRecord
  before_save -> () { self.token = Digest::SHA2.hexdigest(self.name) }
  validates :name, uniqueness: true

  def as_json(options={})
    opts = {
      :only => [:name, :token]
    }
    super(options.merge(opts))
  end
end
