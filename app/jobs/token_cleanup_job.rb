class TokenCleanupJob < ApplicationJob
  queue_as :default

  def perform(*args)
    user = args[0]
    user.update_attribute(:token, nil)
  end
end
