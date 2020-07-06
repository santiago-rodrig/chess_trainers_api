require 'test_helper'

class ExpertiseTest < ActiveSupport::TestCase
  setup do
    @expertise = Expertise.new(name: 'amateur')
  end

  test 'nothing wrong with valid data' do
    assert @expertise.valid?
  end

  test 'name must be present' do
    @expertise.name = nil

    assert @expertise.invalid?
  end

  test 'name length must greater than 2' do
    @expertise.name = 'aa'

    assert @expertise.invalid?
  end

  test 'name lenght must be less than 21' do
    @expertise.name = 'a' * 21

    assert @expertise.invalid?
  end

  test 'name must be unique' do
    @expertise.name = expertises(:one).name

    assert @expertise.invalid?
  end
end
