class UsersController < ApplicationController
  def login
    user = User.find_by(name: login_params[:name])
    if user.authenticate(login_params[:password])
      token = Digest::SHA2.hexdigest(user.name.split('').shuffle.join(''))
      user.token = token
      render json: { token: token }, status: :ok
    else
      head :unauthorized
    end
  end

  private

  def login_params
    params.require(:credentials).permit(:name, :password)
  end
end
