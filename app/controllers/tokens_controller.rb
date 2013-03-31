class TokensController < ApplicationController
  skip_before_filter :verify_authenticity_token
  respond_to :json

  #POST /tokens
  def create
    username = params[:username]
    password = params[:password]

    if username.nil? or password.nil?
      render :json => { :status => :error,
                        :message => 'Request must contain username and password.'}
      return
    end

    user = User.find_by_username(username)

    if user.nil?
      render :json => { :status => :error,
                        :message => 'Invalid username.'}
      return
    end

    user.ensure_authentication_token!

    if user.valid_password?(password)
      render :json => { :status => :ok,
                        :message => user.authentication_token}
    else
      render :json => { :status => :error,
                        :message => 'Invalid password.'}
    end
  end

  def destroy
    user = User.find_by_authentication_token(params[:auth_token])
    if user.nil?
      render :json => { :status => :error,
                        :message => 'Token not found.'}
    else
      user.reset_authentication_token!
      render :json => { :status => :ok,
                        :message => 'Token destroyed.'}
    end
  end
end
