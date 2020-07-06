require 'test_helper'

class AppointmentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
    @trainer = trainers(:one)
    post '/login.json', params: { credentials: { name: 'john', password: 'randomness' } }
    @user.reload
  end

  test 'index returns at most 4 appointments' do
    get "/appointments/group/0.json?tname=#{@trainer.name}&status=111", headers: { Authorization: "Bearer #{@user.token}" }
    data = JSON.parse(response.body, object_class: OpenStruct)

    assert data.appointments.size <= 4
  end

  test 'index sets last group accordingly' do
    get "/appointments/group/0.json?tname=#{@trainer.name}&status=111", headers: { Authorization: "Bearer #{@user.token}" }
    data = JSON.parse(response.body, object_class: OpenStruct)

    assert data.last_group
  end

  test 'create appointment with valid data' do
    assert_difference 'Appointment.count' do
      post '/appointments.js', params: { token: @user.token, trainer: @trainer.name }
    end
  end

  test 'create appointment with invalid data' do
    assert_no_difference 'Appointment.count' do
      post '/appointments.js', params: { token: @user.token, trainer: 'juanito' }
    end
  end
end
