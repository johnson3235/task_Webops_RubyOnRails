# app/controllers/user_controller.rb

class UserController < ApplicationController
  before_action :authenticate_user

  def get_data
    render json: { user: current_user }
  end

  def get_user_by_email
    user = User.find_by(email: params[:email])

    if user
      render json: { user: user }
    else
      render json: { error: 'Email is invalid' }, status: :unprocessable_entity
    end
  end

  def get_user_by_id
    user = User.find_by(id: params[:id])

    if user
      render json: { user: user }
    else
      render json: { error: 'ID is invalid' }, status: :unprocessable_entity
    end
  end

  def update_user_profile
    user = User.find_by(id: params[:id])

    if user
      if params[:photo].present?
        # Handle photo upload logic here
        # Example: upload to cloud storage, update user's photo attribute, etc.
      end

      if user.update(update_user_params)
        render json: { message: 'Profile Updated Successfully' }
      else
        render json: { error: 'Something went wrong' }, status: :unprocessable_entity
      end
    else
      render json: { error: 'ID is invalid' }, status: :unprocessable_entity
    end
  end

  def change_password
    if current_user.authenticate(params[:old_password])
      current_user.password = params[:new_password]

      if current_user.save
        render json: { message: 'Your Password Updated' }
      else
        render json: { error: 'Something went wrong' }, status: :unprocessable_entity
      end
    else
      render json: { error: 'Invalid Password' }, status: :unprocessable_entity
    end
  end

  def delete_user_profile
    if current_user.destroy
      render json: { message: 'Profile Deleted Successfully' }
    else
      render json: { error: 'Something went wrong' }, status: :unprocessable_entity
    end
  end

  private

  def update_user_params
    params.permit(:name, :email, :phone) # Add other permitted attributes as needed
  end
end
