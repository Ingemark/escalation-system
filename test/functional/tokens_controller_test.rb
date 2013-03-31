require 'test_helper'

class TokensControllerTest < ActionController::TestCase
  headers = { 'CONTENT_TYPE' => 'application/json',
              'ACCEPT' => 'application/json' }

  test 'must provide username and password' do
    post :create
    body = JSON.parse(@response.body)
    assert_equal 'error', body["status"]
    assert_equal 'Request must contain username and password.', body["message"]
  end

  test 'invalid username' do
    params = {username: "wrong", password: "wrong"}
    post :create, params, headers
    body = JSON.parse(@response.body)

    assert_equal 'error', body["status"]
    assert_equal 'Invalid username.', body["message"]
  end

  test 'invalid password' do
    params = {username: "admin", password: "wrong"}
    post :create, params, headers
    body = JSON.parse(@response.body)

    assert_equal 'error', body["status"]
    assert_equal 'Invalid password.', body["message"]
  end

  test 'valid token' do
    params = {username: "admin", password: "admin"}
    post :create, params, headers
    body = JSON.parse(@response.body)

    assert_equal 'ok', body["status"]
  end

  test 'token not found' do
    params = {auth_token: "wrong"}
    post :destroy, params, headers
    body = JSON.parse(@response.body)

    assert_equal 'error', body["status"]
    assert_equal 'Token not found.', body["message"]
  end

  test 'token destroyed' do
    params = {username: "admin", password: "admin"}
    post :create, params, headers
    body = JSON.parse(@response.body)
    token = body["message"]

    params = {auth_token: token}
    post :destroy, params, headers
    body = JSON.parse(@response.body)

    assert_equal 'ok', body["status"]
    assert_equal 'Token destroyed.', body["message"]
  end
end
