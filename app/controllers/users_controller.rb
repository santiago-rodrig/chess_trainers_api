class UsersController < ApplicationController
  def login
    user = User.find_by(name: login_params[:name])
    if user && user.authenticate(login_params[:password])
      if !user.token
        user.update_attribute(:token, build_token(user))
      end
      render json: { token: user.token, username: user.name }, status: :ok
    else
      head :unauthorized
    end
  end

  def logged_in
    answer = User.find_by(token: request.headers[:Authorization][7...])
    if answer
      render json: { username: answer.name }, status: :ok
    else
      head :unauthorized
    end
  end

  def show
    token = request.headers[:Authorization][7...]
    user = User.find_by(token: token)

    if user
      render json: { name: user.name, email: user.email }, status: :ok
    else
      head :unauthorized
    end
  end

  def update
    token = request.headers[:Authorization][7...]
    current_password = params[:current_password]
    user = User.find_by(token: token)

    data = {
      name: params[:username],
      email: params[:email],
      password: params[:password],
      password_confirmation: params[:password_confirmation]
    }

    if user && user.authenticate(current_password)
      if user.update(data)
        render json: { username: user.name }, status: :ok
      else
        head :unprocessable_entity
      end
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
