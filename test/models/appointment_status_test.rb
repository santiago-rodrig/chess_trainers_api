require 'test_helper'

class AppointmentStatusTest < ActiveSupport::TestCase
  setup do
    @appointment_status = appointment_statuses(:pending)
  end

  test 'name must be present' do
    @appointment_status.name = nil

    assert @appointment_status.invalid?
  end

  test 'name length must be greater than 2' do
    @appointment_status.name = 'aa'

    assert @appointment_status.invalid?
  end

  test 'name length must be less than 21' do
    @appointment_status.name = 'a' * 21

    assert @appointment_status.invalid?
  end

  test 'name must be unique' do
    @appointment_status.name = appointment_statuses(:success).name

    assert @appointment_status.invalid?
  end
end
