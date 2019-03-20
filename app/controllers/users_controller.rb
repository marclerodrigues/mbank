class UsersController < ApplicationController
  def create
    user = User.new(user_params)

    if user.save
      ::Users::CreateAccessToken.perform(user: user)

      render json: { success: true, access_token: user.access_token }
    else
      render json: { success: false, errors: user.errors.full_messages.join(', ') }, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email)
  end
end
