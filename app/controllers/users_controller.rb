class UsersController < ApplicationController
  def login
    user = User.find_by(name: login_params[:name])
    if user && user.authenticate(login_params[:password])
      token = Digest::SHA2.hexdigest(user.name.split('').shuffle.join(''))
      user.update_attribute(:token, token)
      TokenCleanupJob.set(wait: 1.day).perform_later(user)
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

  private

  def login_params
    params.require(:credentials).permit(:name, :password)
  end
end
