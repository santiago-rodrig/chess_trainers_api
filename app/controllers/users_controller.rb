class UsersController < ApplicationController
  def login
    user = User.find_by(name: login_params[:name])
    if user && user.authenticate(login_params[:password])
      token = user.token ? user.token : build_token(user)
      render json: { token: token }, status: :ok
    else
      head :unauthorized
    end
  end

  def logged_in
    answer = User.find_by(token: params[:token])
    if answer
      head :ok
    else
      head :unauthorized
    end
  end

  def create
    user = User.new(user_params)
    if user.save
      token = build_token(user)
      render json: { token: token }, status: :ok
    else
      head :not_acceptable
    end
  end

  def logout
    user = User.find_by(token: params[:token])
    if user
      user.update_attribute(:token, nil)
    end
    head :ok
  end

  private

  def build_token(user)
    token = Digest::SHA2.hexdigest(user.name.split('').shuffle.join(''))
    user.update_attribute(:token, token)
    TokenCleanupJob.set(wait: 1.day).perform_later(user)
    token
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def login_params
    params.require(:credentials).permit(:name, :password)
  end
end
