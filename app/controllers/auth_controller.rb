# app/controllers/auth_controller.rb

class AuthController < ApplicationController
  skip_before_action :authenticate_user, only: [:login, :register]

  def login
    user = User.find_by(email: params[:email])

    if user && user.authenticate(params[:password])
      token = user.generate_jwt
      render json: {
        status: true,
        message: 'User Login Successfully',
        user: user,
        authorisation: {
          token: token,
          type: 'bearer'
        }
      }
    else
      render json: {
        status: false,
        message: 'Unauthorized',
        user: nil,
        authorisation: nil
      }, status: 200
    end
  end

  def register
    user = User.new(user_params)

    if user.save
      render json: {
        message: 'User successfully registered',
        user: user
      }, status: 201
    else
      render json: user.errors.full_messages, status: 400
    end
  end

  def logout
    # Your logout logic here
    render json: {
      status: 'success',
      message: 'Successfully logged out'
    }
  end

  def refresh
    token = auth_token.refresh
    render json: {
      status: 'success',
      message: 'Token refreshed',
      authorisation: {
        token: token,
        type: 'bearer'
      }
    }
  end

  def user_profile
    render json: current_user
  end

  private

  def user_params
    params.permit(:name, :email, :password, :phone)
  end

  def auth_token
    Knock::AuthToken.new(payload: { sub: current_user.id })
  end
end
