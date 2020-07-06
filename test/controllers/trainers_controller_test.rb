require 'test_helper'

class TrainersControllerTest < ActionDispatch::IntegrationTest
  test 'it gets index' do
    get '/trainers/group/0.json'

    assert_response :success
  end

  test 'it returns a group of at most 3 trainers' do
    get '/trainers/group/0.json'
    data = JSON.parse(response.body)

    assert data['trainers'].length <= 3
  end

  test 'if the group requested is the last last group is true' do
    get '/trainers/group/0.json'
    data = JSON.parse(response.body)

    assert data['last_group']
  end
end
