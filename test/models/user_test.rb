require 'test_helper'

class UserTest < ActiveSupport::TestCase
  setup do
  	@user = users(:one)
  end

  test 'name must be preset' do
  	@user.name = nil

  	assert @user.invalid?
  end

  test 'name lenght must be greater than 2' do
  	@user.name = 'aa'

  	assert @user.invalid?
  end

  test 'name length must be less than 51' do
  	@user.name = 'a' * 51

  	assert @user.invalid?
  end

  test 'email must have a valid format' do
  	@user.email = 'paralelepipedo'

  	assert @user.invalid?
  end

  test 'email must be present' do
  	@user.email = nil

  	assert @user.invalid?
  end

  test 'email must be unique' do
  	other_user = users(:two)
  	@user.email = other_user.email

  	assert @user.invalid?
  end

  test 'token is present and is not a SHA256 hash' do
  	@user.token = 'secret'

  	assert @user.invalid?
  end

  test 'token is present and is a SHA256 hash' do
  	@user.token = Digest::SHA2.hexdigest('randomness')

  	assert @user.valid?
  end
end
