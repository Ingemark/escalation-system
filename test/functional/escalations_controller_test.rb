require 'test_helper'

class EscalationsControllerTest < ActionController::TestCase
  include Devise::TestHelpers

  @headers = { 'CONTENT_TYPE' => 'application/json',
              'ACCEPT' => 'application/json' }
  def setup
    sign_in users(:admin)
    users(:admin).add_role :user, Context
  end

  test 'create must provide external_reference_id and context_id' do
    post :create, {}, @headers
    body = JSON.parse(@response.body)

    assert_equal 'error', body["status"]
    assert_equal 'Request must contain external_reference_id and context_id.', body["message"]
  end

  test 'create context_id is not valid' do
    params = {context_id: -1, external_reference_id: "1"}
    post :create, params, @headers
    body = JSON.parse(@response.body)

    assert_equal 'error', body["status"]
    assert_equal 'Context_id is not valid.', body["message"]
  end

  test 'create current user cant access' do
    sign_out users(:admin)
    sign_in users(:trexmark)
    params = {context_id: contexts(:inge_mark).id, external_reference_id: "1"}
    post :create, params, @headers
    body = JSON.parse(@response.body)

    assert_equal 'error', body["status"]
    assert_equal 'Current user doesnt have access to this context.',
      body["message"]
  end

  test 'create escalations created' do
    params = {context_id: contexts(:inge_mark).id, external_reference_id: "1"}
    post :create, params, @headers
    body = JSON.parse(@response.body)

    assert_equal 'ok', body["status"]
    assert_equal '3 escalations created.', body["message"]
  end

  test 'create escalations not created' do
    params = {context_id: contexts(:inge_mark).id, external_reference_id: "1"}
    post :create, params, @headers
    post :create, params, @headers
    body = JSON.parse(@response.body)

    assert_equal 'error', body["status"]
    assert_equal 'Escalations with same context_id and external_reference_id'\
                   ' are already scheduled.', body["message"]
  end

  test 'destroy must provide external_reference_id and context_id' do
    post :destroy, {}, @headers
    body = JSON.parse(@response.body)

    assert_equal 'error', body["status"]
    assert_equal 'Request must contain external_reference_id and context_id.', body["message"]
  end

  test 'destroy context_id is not valid' do
    params = {context_id: -1, external_reference_id: "1"}
    post :destroy, params, @headers
    body = JSON.parse(@response.body)

    assert_equal 'error', body["status"]
    assert_equal 'Context_id is not valid.', body["message"]
  end

  test 'destroy current user cant access' do
    sign_out users(:admin)
    sign_in users(:trexmark)
    params = {context_id: contexts(:inge_mark).id, external_reference_id: "1"}
    post :destroy, params, @headers
    body = JSON.parse(@response.body)

    assert_equal 'error', body["status"]
    assert_equal 'Current user doesnt have access to this context.',
      body["message"]
  end

  test 'destroy external_reference_id invalid' do
    params = {context_id: contexts(:inge_mark).id, external_reference_id: "1"}
    post :destroy, params, @headers
    body = JSON.parse(@response.body)

    assert_equal 'error', body["status"]
    assert_equal "Escalations with that external_reference_id don't exist.",
      body["message"]
  end

  test 'destroy escalations canceled' do
    params = {context_id: contexts(:inge_mark).id, external_reference_id: "1"}
    post :create, params, @headers
    post :destroy, params, @headers
    body = JSON.parse(@response.body)

    assert_equal 'ok', body["status"]
    assert_equal '3 escalations canceled.', body["message"]
  end

  test 'destroy escalations already canceled' do
    params = {context_id: contexts(:inge_mark).id, external_reference_id: "1"}
    post :create, params, @headers
    post :destroy, params, @headers
    post :destroy, params, @headers
    body = JSON.parse(@response.body)

    assert_equal 'error', body["status"]
    assert_equal 'Escalations with same context_id and external_reference_id'\
      ' are already canceled.', body["message"]
  end
end
