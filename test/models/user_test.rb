require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test 'it creates a user' do
    assert_difference 'User.count', 1 do
      User.create(name: 'stuart')
    end
  end

  test 'it does not create users with the same name' do
    User.create(name: 'stuart')
    assert_no_difference 'User.count' do
      User.create(name: 'stuart')
    end
  end
end
