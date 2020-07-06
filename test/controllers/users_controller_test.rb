require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
  end

  test 'it sets the token on log in' do
    post '/login.json', params: { credentials: { name: 'john', password: 'randomness' } }
    @user.reload

    assert_not_nil @user.token
  end

  test 'it sends the token on log in' do
    post '/login.json', params: { credentials: { name: 'john', password: 'randomness' } }
    @user.reload

    assert_equal @user.token, JSON.parse(response.body)['token']
  end

  test 'it sends the user name on log in' do
    post '/login.json', params: { credentials: { name: 'john', password: 'randomness' } }

    assert_equal @user.name, JSON.parse(response.body)['username']
  end

  test 'it returns unauthorized on wrong credentials for log in' do
    post '/login.json', params: { credentials: { name: 'johny bravo', password: 'the best' } }

    assert_response :unauthorized
  end

  test 'it sends the user name on valid logged in' do
    post '/login.json', params: { credentials: { name: 'john', password: 'randomness' } }
    @user.reload
    get '/logged_in.json', headers: { Authorization: "Bearer #{@user.token}" }

    assert_equal @user.name, JSON.parse(response.body)['username']
  end

  test 'it returns unauthorized on unexistent token for logged in' do
    post '/login.json', params: { credentials: { name: 'john', password: 'randomness' } }
    @user.reload
    get '/logged_in.json', headers: { Authorization: "Bearer #{'abc123ef' * 8}" }

    assert_response :unauthorized
  end

  test 'show action valid token' do
    post '/login.json', params: { credentials: { name: 'john', password: 'randomness' } }
    @user.reload
    get '/user.json', headers: { Authorization: "Bearer #{@user.token}" }

    assert_equal({ 'name' => @user.name, 'email' => @user.email }, JSON.parse(response.body))
  end

  test 'show action invalid token' do
    post '/login.json', params: { credentials: { name: 'john', password: 'randomness' } }
    @user.reload
    get '/user.json', headers: { Authorization: "Bearer #{'abc123ef' * 8}" }

    assert_response :unauthorized
  end

  test 'create user valid data no problem' do
    assert_difference 'User.count' do
      post(
        '/users.json',
        params: {
          user: {
            name: 'gustav',
            email: 'gustav.rocks@example.org',
            password: 'ultrasecret',
            password_confirmation: 'ultrasecret'
          }
        }
      )
    end
  end

  test 'create user invalid data problem' do
    assert_no_difference 'User.count' do
      post(
        '/users.json',
        params: {
          user: {
            name: 'gustav',
            email: 'gustav.rocks@example.org',
            password: 'ultrasecret',
            password_confirmation: 'ultrasecreto'
          }
        }
      )
    end
  end

  test 'logout existing token' do
    post '/login.json', params: { credentials: { name: 'john', password: 'randomness' } }
    @user.reload
    delete '/logout.json', params: { token: @user.token }
    @user.reload

    assert_nil @user.token
  end

  test 'update valid current password' do
    post '/login.json', params: { credentials: { name: 'john', password: 'randomness' } }
    @user.reload

    put(
      '/users/update.json',
      params: {
        username: 'johny',
        email: @user.email,
        password: '',
        password_confirmation: '',
        current_password: 'randomness'
      },
      headers: { Authorization: "Bearer #{@user.token}" }
    )

    @user.reload

    assert_equal 'johny', @user.name    
  end

  test 'update invalid current password' do
    post '/login.json', params: { credentials: { name: 'john', password: 'randomness' } }
    @user.reload

    put(
      '/users/update.json',
      params: {
        username: 'johny',
        email: @user.email,
        password: '',
        password_confirmation: '',
        current_password: 'wadayawant'
      },
      headers: { Authorization: "Bearer #{@user.token}" }
    )

    @user.reload


    assert_equal 'john', @user.name
  end
end
